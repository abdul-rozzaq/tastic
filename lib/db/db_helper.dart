import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    debugPrint("Tables creating...");
    await database.execute(
      """
      CREATE TABLE books (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        pages_count INTEGER NOT NULL
      )
      """,
    );

    await database.execute(
      """
      CREATE TABLE notes (
        id TEXT PRIMARY KEY,
        book_id TEXT NOT NULL,
        start INTEGER NOT NULL,
        end INTEGER NOT NULL,
        date TEXT NOT NULL
      );
      """,
    );
  }

  static Future<Database> db() async {
    return openDatabase(
      'TASTIC-2.db',
      version: 3,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }
}
