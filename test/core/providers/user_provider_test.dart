import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/providers/user_provider.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';
import 'package:unegvirtual_app/features/user/domain/use_cases/create_user.dart';

@GenerateNiceMocks([MockSpec<CreateUser>()])
import 'user_provider_test.mocks.dart';

void main() {
  late MockCreateUser mockCreateUser;
  late UserProvider provider;

  setUp(() {
    mockCreateUser = MockCreateUser();

    provider = UserProvider(
      createUser: mockCreateUser,
    );
  });

  const tUnsavedUser = UnsavedUser(
    password: 'test',
    securityKey: 'test',
    type: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  const tAccessToken = AccessToken('test');

  test(
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('createUser', () {
    test(
      'should create the user with the use case',
      () async {
        // arrange
        when(mockCreateUser(any)).thenAnswer((_) async => const Right(null));

        // act
        await provider.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        );

        // assert
        verify(
          mockCreateUser(
            const CreateUserParams(
              accessToken: tAccessToken,
              unsavedUser: tUnsavedUser,
            ),
          ),
        );
      },
    );

    test(
      'should notify [Loading, Loaded] when user is gotten successfully',
      () async {
        // arrange
        when(mockCreateUser(any)).thenAnswer((_) async => const Right(null));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        );
      },
    );

    test(
      'should notify [Loading, Loaded] when user is gotten successfully',
      () async {
        // arrange
        when(mockCreateUser(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        );
      },
    );
  });
}
