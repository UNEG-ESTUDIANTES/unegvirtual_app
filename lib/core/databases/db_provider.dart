import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:classroom_app/core/models/access_token_model.dart';

class DBProvider {
  /// The [path] to store this database.
  final String path;
  Database? _database;

  DBProvider({required this.path});

  /// The database instance.
  Future<Database> get database async {
    // Returns database in case is already instanced
    if (_database != null) return _database!;

    // Initialize DB
    _database = await initDB();
    return _database!;
  }

  /// Creates the tables in the [db].
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Token(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        token TEXT UNIQUE NOT NULL
      )
    ''');
  }

  /// Initializes the database.
  Future<Database> initDB() async {
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Insertes a new [accessToken].
  Future<int> addToken(AccessTokenModel accessToken) async {
    final db = await database;

    return await db.insert(
      'Token',
      accessToken.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Removes the latest stored token.
  Future<int> removeToken() async {
    final db = await database;

    /// Gets the latest token.
    final latestToken = await db.query('Token', limit: 1, orderBy: 'id DESC');

    if (latestToken.isEmpty) return 0;

    return await db.delete(
      'Token',
      where: 'id = ?',
      whereArgs: [latestToken.last['id']],
    );
  }
}
