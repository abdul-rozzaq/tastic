import 'package:sqflite/sqflite.dart';
import 'package:tastic/db/db_helper.dart';
import 'package:uuid/uuid.dart';

class Book {
  String id;
  String name;
  int pagesCount;

  Book({
    required this.id,
    required this.name,
    required this.pagesCount,
  });

  Map<String, Object?> toMap() => {'id': id, 'name': name, 'pages_count': pagesCount};

  static Book fromMap(Map map) => Book(id: map['id'], name: map['name'], pagesCount: map['pages_count']);

  /* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

  delete() async {
    Database db = await SQLHelper.db();
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  update({required String name, required int pagesCount}) async {
    Database db = await SQLHelper.db();
    await db.update('books', {'name': name, 'pages_count': pagesCount},  where: 'id = ?', whereArgs: [id]);
  }

  static Future<Book> create({required String name, required int pagesCount}) async {
    Database db = await SQLHelper.db();
    String id = const Uuid().v4();

    Book book = Book(id: id, name: name, pagesCount: pagesCount);

    await db.insert('books', book.toMap());

    return book;
  }

  static Future<List<Book>> all() async {
    Database db = await SQLHelper.db();

    return (await db.query('books')).map<Book>((e) => Book.fromMap(e)).toList();
  }
}
