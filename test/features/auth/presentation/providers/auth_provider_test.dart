import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/use_cases/use_case.dart';
import 'package:classroom_app/features/auth/domain/entities/user_credentials.dart';
import 'package:classroom_app/features/auth/domain/use_cases/get_access_token.dart';
import 'package:classroom_app/features/auth/domain/use_cases/login.dart';
import 'package:classroom_app/features/auth/presentation/providers/auth_provider.dart';

@GenerateNiceMocks([
  MockSpec<GetAccessToken>(),
  MockSpec<Login>(),
])
import 'auth_provider_test.mocks.dart';

void main() {
  late MockGetAccessToken mockGetAccessToken;
  late MockLogin mockLogin;
  late AuthProvider provider;

  setUp(() {
    mockGetAccessToken = MockGetAccessToken();
    mockLogin = MockLogin();

    provider = AuthProvider(
      getAccessTokenUseCase: mockGetAccessToken,
      loginUseCase: mockLogin,
    );
  });

  const tAccessToken = AccessToken('test');

  test(
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('getToken', () {
    test(
      'should get the token with the use case',
      () async {
        // arrange
        when(mockGetAccessToken(any))
            .thenAnswer((_) async => const Right(tAccessToken));

        // act
        await provider.getToken();

        // assert
        verify(mockGetAccessToken(NoParams()));
      },
    );

    test(
      'should notify [Loading, Loaded] when token is gotten successfully',
      () async {
        // arrange
        when(mockGetAccessToken(any))
            .thenAnswer((_) async => const Right(tAccessToken));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getToken();
      },
    );

    test(
      'should notify [Loading, Error] when user is login fails',
      () async {
        // arrange
        when(mockGetAccessToken(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: cacheFailureMessage),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getToken();
      },
    );
  });

  group('login', () {
    const tUserCredentials = UserCredentials(
      email: 'test',
      password: 'test',
    );

    test(
      'should login the user with the login use case',
      () async {
        // arrange
        when(mockLogin(any)).thenAnswer((_) async => const Right(tAccessToken));

        // act
        await provider.login(tUserCredentials);

        // assert
        verify(mockLogin(const LoginParams(userCredentials: tUserCredentials)));
      },
    );

    test(
      'should notify [Loading, Loaded] when user is logged in successfully',
      () async {
        // arrange
        when(mockLogin(any)).thenAnswer((_) async => const Right(tAccessToken));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.login(tUserCredentials);
      },
    );

    test(
      'should notify [Loading, Error] when user is login fails',
      () async {
        // arrange
        when(mockLogin(any)).thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage)
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.login(tUserCredentials);
      },
    );
  });
}
