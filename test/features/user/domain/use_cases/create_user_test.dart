import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';
import 'package:unegvirtual_app/features/user/domain/repositories/user_repository.dart';
import 'package:unegvirtual_app/features/user/domain/use_cases/create_user.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
import 'create_user_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late CreateUser useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = CreateUser(mockUserRepository);
  });

  const tAccessToken = AccessToken('test');

  const tUnsavedUser = UnsavedUser(
    password: 'test',
    securityKey: 'test',
    type: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  test(
    'should create the user in the repository',
    () async {
      // arrange
      when(
        mockUserRepository.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        ),
      );

      // act
      await useCase(
        const CreateUserParams(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        ),
      );

      // assert
      verify(
        mockUserRepository.createUser(
          accessToken: tAccessToken,
          unsavedUser: tUnsavedUser,
        ),
      );

      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
