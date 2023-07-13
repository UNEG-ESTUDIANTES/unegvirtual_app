import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:classroom_app/core/databases/db_provider.dart';
import 'package:classroom_app/core/models/access_token_model.dart';

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

  const tAccessTokenModel = AccessTokenModel('test');

  test(
    'should create the Token table',
    () async {
      // arrange
      final db = await dbProvider.database;

      // act
      final tables = await db.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: ['Token'],
      );

      // assert
      expect(tables.length, equals(1));
    },
  );

  group('addToken', () {
    test(
      'should insert the token',
      () async {
        // act
        final result = await dbProvider.addToken(tAccessTokenModel);

        // assert
        expect(result, 1);
      },
    );
  });

  group('getToken', () {
    test(
      'should get the latest token',
      () async {
        // act
        final result = await dbProvider.getToken();

        // assert
        expect(result, tAccessTokenModel);
      },
    );
  });

  group('removeToken', () {
    test(
      'should remove the latest token',
      () async {
        // act
        final result = await dbProvider.removeToken();

        // assert
        expect(result, 1);
      },
    );

    test(
      'should return zero when table is empty',
      () async {
        // act
        final result = await dbProvider.removeToken();

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
        final result = await dbProvider.getToken();

        // assert
        expect(result, null);
      },
    );
  });
}
