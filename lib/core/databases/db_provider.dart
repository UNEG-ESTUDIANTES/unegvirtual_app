import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'package:classroom_app/core/models/auth_model.dart';

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
      CREATE TABLE Auth(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        data TEXT NOT NULL
      );
    ''');
  }

  /// Initializes the database.
  Future<Database> initDB() async {
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  /// Inerts a new [auth].
  Future<int> addAuth(AuthModel auth) async {
    final db = await database;

    return await db.insert(
      'Auth',
      {
        'data': json.encode(auth.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Gets the latest stored token.
  Future<AuthModel?> getAuth() async {
    final db = await database;

    // Gets the latest token.
    final auths = await db.query('Auth', limit: 1, orderBy: 'id DESC');

    if (auths.isEmpty) return null;

    return AuthModel.fromJson(json.decode(Map.from(auths.first)['data']));
  }

  /// Removes the latest stored token.
  Future<int> removeAuth() async {
    final db = await database;

    // Gets the latest token.
    final auths = await db.query('Auth', limit: 1, orderBy: 'id DESC');

    if (auths.isEmpty) return 0;

    return await db.delete(
      'Auth',
      where: 'id = ?',
      whereArgs: [auths.first['id']],
    );
  }
}
