import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/features/user/domain/repositories/user_repository.dart';
import 'package:classroom_app/features/user/domain/use_cases/get_current_user.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
import 'get_current_user_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetCurrentUser useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetCurrentUser(mockUserRepository);
  });

  const tUser = User(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  const tAccessToken = AccessToken('test');

  test(
    'should get current user from the repository',
    () async {
      // arrange
      when(mockUserRepository.getCurrentUser(any))
          .thenAnswer((_) async => const Right(tUser));

      // act
      final result = await useCase(
        const GetCurrentUserParams(accessToken: tAccessToken),
      );

      // assert
      expect(result, const Right(tUser));
      verify(mockUserRepository.getCurrentUser(tAccessToken));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
