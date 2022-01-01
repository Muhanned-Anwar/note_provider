import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbProvider {
  static final DbProvider _instance = DbProvider._internal();
  late Database _database;

  factory DbProvider() {
    return _instance;
  }

  Database get database => _database;

  DbProvider._internal();

  Future<void> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        db.execute('CREATE TABLE notes('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'content TEXT'
            ')');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
