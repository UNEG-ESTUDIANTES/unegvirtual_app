import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/auth.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';
import 'package:classroom_app/features/auth/domain/use_cases/get_auth.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
import 'get_auth_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetAuth useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetAuth(mockAuthRepository);
  });

  const tAuth = Auth(
    accessToken: AccessToken('test'),
    user: User(
      id: 'test',
      firstName: 'test',
      lastName: 'test',
      identityCard: 'test',
      email: 'test',
    ),
  );

  test(
    'should get the auth from the repository',
    () async {
      // arrange
      when(mockAuthRepository.getAuth()).thenAnswer(
        (_) async => const Right(tAuth),
      );

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(tAuth));
      verify(mockAuthRepository.getAuth());
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
