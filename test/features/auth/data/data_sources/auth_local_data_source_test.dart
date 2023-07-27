import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:unegvirtual_app/core/databases/db_provider.dart';
import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/user.dart';
import 'package:unegvirtual_app/core/error/exceptions.dart';
import 'package:unegvirtual_app/core/models/auth_model.dart';
import 'package:unegvirtual_app/features/auth/data/data_sources/auth_local_data_source.dart';

@GenerateNiceMocks([MockSpec<DBProvider>()])
import 'auth_local_data_source_test.mocks.dart';

void main() {
  late MockDBProvider mockDBProvider;
  late AuthLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockDBProvider = MockDBProvider();
    dataSourceImpl = AuthLocalDataSourceImpl(database: mockDBProvider);
  });

  const tId = 1;

  const tAuthModel = AuthModel(
    accessToken: AccessToken('test'),
    user: User(
      id: 'test',
      firstName: 'test',
      lastName: 'test',
      identityCard: 'test',
      email: 'test',
    ),
  );

  group('cacheAuth', () {
    test(
      'should store the auth in the database',
      () async {
        // arrange
        when(mockDBProvider.addAuth(tAuthModel)).thenAnswer((_) async => tId);

        // act
        await dataSourceImpl.cacheAuth(tAuthModel);

        // assert
        verify(mockDBProvider.addAuth(tAuthModel));
      },
    );

    test(
      'should remove the last token stored before adding new token',
      () async {
        // arrange
        when(mockDBProvider.removeAuth()).thenAnswer((_) async => tId);

        when(mockDBProvider.addAuth(tAuthModel)).thenAnswer((_) async => tId);

        // act
        await dataSourceImpl.cacheAuth(tAuthModel);

        // assert
        verifyInOrder([
          mockDBProvider.removeAuth(),
          mockDBProvider.addAuth(tAuthModel),
        ]);

        verifyNoMoreInteractions(mockDBProvider);
      },
    );
  });

  group('getAuth', () {
    test(
      'should get the auth from the database',
      () async {
        // arrange
        when(mockDBProvider.getAuth()).thenAnswer((_) async => tAuthModel);

        // act
        final result = await dataSourceImpl.getAuth();

        // assert
        verify(mockDBProvider.getAuth());
        expect(result, tAuthModel);
      },
    );

    test(
      'should throw NotFoundException if access token is not found',
      () async {
        // arrange
        when(mockDBProvider.getAuth()).thenAnswer((_) async => null);

        // act
        final call = dataSourceImpl.getAuth;

        // assert
        expect(() => call(), throwsA(const TypeMatcher<NotFoundException>()));
      },
    );
  });
}
