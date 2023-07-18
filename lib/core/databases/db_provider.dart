import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:classroom_app/core/models/access_token_model.dart';
import 'package:classroom_app/core/models/user_model.dart';

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
      );

      CREATE TABLE UserProfile(
        _id TEXT PRIMARY KEY NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        ci TEXT NOT NULL,
        email TEXT NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
      );
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

  /// Inserts a new [accessToken].
  Future<int> addToken(AccessTokenModel accessToken) async {
    final db = await database;

    return await db.insert(
      'Token',
      accessToken.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Gets the latest stored token.
  Future<AccessTokenModel?> getToken() async {
    final db = await database;

    // Gets the latest token.
    final tokens = await db.query('Token', limit: 1, orderBy: 'id DESC');

    if (tokens.isEmpty) return null;

    return AccessTokenModel.fromJson(tokens.first);
  }

  /// Removes the latest stored token.
  Future<int> removeToken() async {
    final db = await database;

    // Gets the latest token.
    final tokens = await db.query('Token', limit: 1, orderBy: 'id DESC');

    if (tokens.isEmpty) return 0;

    return await db.delete(
      'Token',
      where: 'id = ?',
      whereArgs: [tokens.first['id']],
    );
  }

  /// Inserts a new [user].
  Future<int> addUserProfile(UserModel user) async {
    final db = await database;

    return await db.insert(
      'UserProfile',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Gets the latest stored user profile.
  Future<UserModel?> getUserProfile() async {
    final db = await database;

    // Gets the latest user.
    final users = await db.query(
      'UserProfile',
      limit: 1,
      orderBy: 'createdAt DESC',
    );

    if (users.isEmpty) return null;

    return UserModel.fromJson(users.first);
  }

  /// Removes the latest stored user.
  Future<int> removeUserProfile() async {
    final db = await database;

    // Gets the latest user.
    final users = await db.query(
      'UserProfile',
      limit: 1,
      orderBy: 'createdAt DESC',
    );

    if (users.isEmpty) return 0;

    return await db.delete(
      'UserProfile',
      where: '_id = ?',
      whereArgs: [users.first['_id']],
    );
  }
}
