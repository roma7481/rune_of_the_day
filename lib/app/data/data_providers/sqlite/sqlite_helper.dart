import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'runes_db3.db';
  static final _assets = 'assets';
  static final _subPackage = 'database';

  //defining DB as singleton
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    return (_database != null) ? _database : await _initiateDatabase();
  }

  _initiateDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application

      debugPrint("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join(_assets + '/' + _subPackage, _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint("Opening existing database");
    }

    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<Map<String, dynamic>>> queryRecord(
      String tableName, String columnName, int value) async {
    Database db =
        await instance.database; // this command calls get database async method
    return await db.query(
      tableName,
      where: columnName + ' = ?',
      whereArgs: [value],
    );
  }

  Future<List<Map<String, dynamic>>> queryColumns(
      String tableName, String columnName1, String columnName2) async {
    Database db =
        await instance.database; // this command calls get database async method
    // return await db.query(_tableName);
    return await db.query(
      tableName,
      columns: [columnName1, columnName2],
    );
  }

  Future closeDB() async {
    Database db = await instance.database;
    debugPrint("Closing database");
    await db.close();
  }
}
