import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/error/failures.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/utils/utils.dart';
import 'package:classroom_app/features/user/domain/use_cases/get_current_user.dart';
import 'package:classroom_app/features/user/presentation/providers/user_provider.dart';

@GenerateNiceMocks([MockSpec<GetCurrentUser>()])
import 'user_provider_test.mocks.dart';

void main() {
  late MockGetCurrentUser mockGetCurrentUser;
  late UserProvider provider;

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUser();

    provider = UserProvider(
      getCurrentUserUseCase: mockGetCurrentUser,
    );
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
    'initial state should be Empty',
    () async {
      // assert
      expect(provider.state, Empty());
    },
  );

  group('getCurrentUser', () {
    test(
      'should get the user with the use case',
      () async {
        // arrange
        when(mockGetCurrentUser(any))
            .thenAnswer((_) async => const Right(tUser));

        // act
        await provider.getCurrentUser(tAccessToken);

        // assert
        verify(
          mockGetCurrentUser(
            const GetCurrentUserParams(
              accessToken: tAccessToken,
            ),
          ),
        );
      },
    );

    test(
      'should notify [Loading, Loaded] when user is gotten successfully',
      () async {
        // arrange
        when(mockGetCurrentUser(any))
            .thenAnswer((_) async => const Right(tUser));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getCurrentUser(tAccessToken);
      },
    );

    test(
      'should notify [Loading, Loaded] when user is gotten successfully',
      () async {
        // arrange
        when(mockGetCurrentUser(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage),
        ];

        expectLater(provider.stream, emitsInOrder(expected));

        // act
        await provider.getCurrentUser(tAccessToken);
      },
    );
  });
}
