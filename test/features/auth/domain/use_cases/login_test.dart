import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/domain/repository/auth_repository.dart';
import 'package:classroom_app/features/auth/domain/use_cases/login.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
import 'login_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late Login useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = Login(mockAuthRepository);
  });

  const tUserCredentials = UserCredentials(
    email: 'test',
    password: 'test',
  );

  const tAccessToken = AccessToken('test');

  test(
    'should login the user in the repository',
    () async {
      // arrange
      when(mockAuthRepository.login(any)).thenAnswer(
        (_) async => const Right(tAccessToken),
      );

      // act
      final result = await useCase(
        const LoginParams(userCredentials: tUserCredentials),
      );

      // assert
      expect(result, const Right(tAccessToken));
      verify(mockAuthRepository.login(tUserCredentials));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
