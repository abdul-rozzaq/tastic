import 'package:sqflite/sqflite.dart';
import 'package:tastic/db/db_helper.dart';
import 'package:tastic/models/book_model.dart';
import 'package:uuid/uuid.dart';

class Note {
  String id;
  String bookId;
  int start;
  int end;
  DateTime date;

  Note({
    required this.id,
    required this.bookId,
    required this.start,
    required this.end,
    required this.date,
  });

  Book book(List<Book> books) {
    for (var book in books) {
      if (book.id == bookId) return book;
    }

    return Book(id: '', name: '', pagesCount: 0);
  }

  // Convert a Note object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_id': bookId,
      'start': start,
      'end': end,
      'date': date.toIso8601String(), // Convert DateTime to string
    };
  }

  // Create a Note object from a map
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      bookId: map['book_id'],
      start: map['start'],
      end: map['end'],
      date: DateTime.parse(map['date']), // Parse string to DateTime
    );
  }

  // Delete a Note from the database
  Future<void> delete() async {
    Database db = await SQLHelper.db();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Update a Note in the database
  Future<void> update({required int start, required int end}) async {
    Database db = await SQLHelper.db();
    await db.update('notes', {'start': start, 'end': end}, where: 'id = ?', whereArgs: [id]);
  }

  // Create a new Note in the database
  static Future<Note> create({required String bookId, required int start, required int end, required DateTime date}) async {
    Database db = await SQLHelper.db();
    String id = const Uuid().v4();

    Note note = Note(
      id: id,
      bookId: bookId,
      start: start,
      end: end,
      date: date,
    );

    await db.insert('notes', note.toMap());

    return note;
  }

  // Retrieve all notes from the database
  static Future<List<Note>> all() async {
    Database db = await SQLHelper.db();

    return (await db.query('notes')).map<Note>((e) => Note.fromMap(e)).toList();
  }
}
