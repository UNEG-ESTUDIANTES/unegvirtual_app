import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/auth.dart';
import 'package:unegvirtual_app/core/entities/user.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/auth_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/use_cases/use_case.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/auth/domain/entities/user_credentials.dart';
import 'package:unegvirtual_app/features/auth/domain/use_cases/get_auth.dart';
import 'package:unegvirtual_app/features/auth/domain/use_cases/login.dart';

@GenerateNiceMocks([
  MockSpec<GetAuth>(),
  MockSpec<Login>(),
])
import 'auth_provider_test.mocks.dart';

void main() {
  late MockGetAuth mockGetAuth;
  late MockLogin mockLogin;
  late AuthProvider provider;

  setUp(() {
    mockGetAuth = MockGetAuth();
    mockLogin = MockLogin();

    provider = AuthProvider(
      getAuth: mockGetAuth,
      login: mockLogin,
    );
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
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('getAuth', () {
    test(
      'should get the auth with the use case',
      () async {
        // arrange
        when(mockGetAuth(any)).thenAnswer((_) async => const Right(tAuth));

        // act
        await provider.getAuth();

        // assert
        verify(mockGetAuth(NoParams()));
      },
    );

    test(
      'should notify [Loading, Loaded] when auth is gotten successfully',
      () async {
        // arrange
        when(mockGetAuth(any)).thenAnswer((_) async => const Right(tAuth));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getAuth();
      },
    );

    test(
      'should notify [Loading, Error] when user is login fails',
      () async {
        // arrange
        when(mockGetAuth(any)).thenAnswer((_) async => Left(CacheFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: cacheFailureMessage),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getAuth();
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
        when(mockLogin(any)).thenAnswer((_) async => const Right(tAuth));

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
        when(mockLogin(any)).thenAnswer((_) async => const Right(tAuth));

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
          Error(message: Utils.getErrorMessage(ServerFailure())),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.login(tUserCredentials);
      },
    );
  });
}
