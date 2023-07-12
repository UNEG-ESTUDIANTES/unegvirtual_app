import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';
import 'package:classroom_app/features/auth/domain/use_cases/get_access_token.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
import 'get_access_token_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetAccessToken useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetAccessToken(mockAuthRepository);
  });

  const tAccessToken = AccessToken('test');

  test(
    'should get the access token from the repository',
    () async {
      // arrange
      when(mockAuthRepository.getAccessToken()).thenAnswer(
        (_) async => const Right(tAccessToken),
      );

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(tAccessToken));
      verify(mockAuthRepository.getAccessToken());
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
