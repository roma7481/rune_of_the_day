import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:rune_of_the_day/app/data/data_providers/sqlite/sqlite_helper.dart';

class DBService {
  static final _lock = Lock();

  DBService._privateConstructor();

  static final DBService instance = DBService._privateConstructor();

  Future<T> getEntryById<T>({
    @required int id,
    @required String column,
    @required String tableName,
    @required T Function(Map<String, dynamic> data, int id) builder,
  }) async {
    return _lock.synchronized(() async {
      var db = DatabaseHelper.instance;
      var queryRows = await db.queryRecord(tableName, column, id);
      await db.closeDB();

      var row = queryRows.first;
      return builder(row, id);
    });
  }

  Future<List<T>> getEntriesForColumns<T>({
    @required String column1,
    @required String column2,
    @required String tableName,
    @required T Function(Map<String, dynamic> row) builder,
  }) async {
    return _lock.synchronized(() async {
      var db = DatabaseHelper.instance;
      var rows = await db.queryColumns(tableName, column1, column2);
      await db.closeDB();

      return rows.map((row) => builder(row)).toList();
    });
  }
}
