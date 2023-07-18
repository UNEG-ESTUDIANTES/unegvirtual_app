import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:classroom_app/core/databases/db_provider.dart';
import 'package:classroom_app/core/error/exceptions.dart';
import 'package:classroom_app/core/models/user_model.dart';
import 'package:classroom_app/features/user/data/data_sources/user_local_data_source.dart';

@GenerateNiceMocks([MockSpec<DBProvider>()])
import 'user_local_data_source_test.mocks.dart';

void main() {
  late MockDBProvider mockDBProvider;
  late UserLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockDBProvider = MockDBProvider();
    dataSourceImpl = UserLocalDataSourceImpl(database: mockDBProvider);
  });

  const tId = 1;

  const tUserModel = UserModel(
    id: 'test',
    firstName: 'test',
    lastName: 'test',
    identityCard: 'test',
    email: 'test',
  );

  group('cacheUser', () {
    test(
      'should store the user in the database',
      () async {
        // arrange
        when(mockDBProvider.addUserProfile(tUserModel))
            .thenAnswer((_) async => tId);

        // act
        await dataSourceImpl.cacheUser(tUserModel);

        // assert
        verify(mockDBProvider.addUserProfile(tUserModel));
      },
    );

    test(
      'should remove the last token stored before adding new token',
      () async {
        // arrange
        when(mockDBProvider.removeUserProfile()).thenAnswer((_) async => tId);

        when(mockDBProvider.addUserProfile(tUserModel))
            .thenAnswer((_) async => tId);

        // act
        await dataSourceImpl.cacheUser(tUserModel);

        // assert
        verifyInOrder([
          mockDBProvider.removeUserProfile(),
          mockDBProvider.addUserProfile(
            tUserModel,
          )
        ]);

        verifyNoMoreInteractions(mockDBProvider);
      },
    );
  });

  group('getCurrentUser', () {
    test(
      'should get the user from the database',
      () async {
        // arrange
        when(mockDBProvider.getUserProfile())
            .thenAnswer((_) async => tUserModel);

        // act
        final result = await dataSourceImpl.getCurrentUser();

        // assert
        verify(mockDBProvider.getUserProfile());
        expect(result, tUserModel);
      },
    );

    test(
      'should throw NotFoundException if access token is not found',
      () async {
        // arrange
        when(mockDBProvider.getToken()).thenAnswer((_) async => null);

        // act
        final call = dataSourceImpl.getCurrentUser;

        // assert
        expect(() => call(), throwsA(const TypeMatcher<NotFoundException>()));
      },
    );
  });
}
