import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/userdata.dart';

String table = 'user';

class ConnectionDB {
  Future<Database> initializeDB() async {
    String part = await getDatabasesPath();
    return openDatabase(
      join(part, 'tododatabase.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $table(id INTEGER PRIMARY KEY, tire TEXT, price TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    final db = await initializeDB();
    await db.insert(table, user.tomap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Function Insert');
  }

  Future<List<User>> getUser() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query(table);
    return queryResult.map((e) => User.toJson(e)).toList();
    //queryResult.map((e) => todo.fromMap(e)).toList();
  }

  Future<void> updateUser(User user) async {
    final db = await initializeDB();
    await db.update(table, user.tomap(), where: 'id=?', whereArgs: [user.id]);
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(table, where: 'id=?', whereArgs: [id]);
  }
}
