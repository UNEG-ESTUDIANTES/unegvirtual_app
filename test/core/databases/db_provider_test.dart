import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:unegvirtual_app/core/databases/db_provider.dart';
import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/entities/user.dart';
import 'package:unegvirtual_app/core/models/auth_model.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation.
  sqfliteFfiInit();

  // Set global factory.
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  sqfliteTestInit();

  late DBProvider dbProvider;

  setUp(() async {
    dbProvider = DBProvider(path: inMemoryDatabasePath);
  });

  group('Auth', () {
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

    test(
      'should create the Auth table',
      () async {
        // arrange
        final db = await dbProvider.database;

        // act
        final tables = await db.query(
          'sqlite_master',
          where: 'name = ?',
          whereArgs: ['Auth'],
        );

        // assert
        expect(tables.length, equals(1));
      },
    );

    group('addAuth', () {
      test(
        'should insert the token',
        () async {
          // act
          final result = await dbProvider.addAuth(tAuthModel);

          // assert
          expect(result, 1);
        },
      );
    });

    group('getAuth', () {
      test(
        'should get the latest auth',
        () async {
          // act
          final result = await dbProvider.getAuth();

          // assert
          expect(result, tAuthModel);
        },
      );
    });

    group('removeAuth', () {
      test(
        'should remove the latest token',
        () async {
          // act
          final result = await dbProvider.removeAuth();

          // assert
          expect(result, 1);
        },
      );

      test(
        'should return zero when table is empty',
        () async {
          // act
          final result = await dbProvider.removeAuth();

          // assert
          expect(result, 0);
        },
      );
    });

    group('getToken', () {
      test(
        'should return null when table is empty',
        () async {
          // act
          final result = await dbProvider.getAuth();

          // assert
          expect(result, null);
        },
      );
    });
  });
}
