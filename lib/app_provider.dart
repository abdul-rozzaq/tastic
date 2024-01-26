import 'package:flutter/material.dart';
import 'package:tastic/models/book_model.dart';
import 'package:tastic/models/note_model.dart';

class AppProvider extends ChangeNotifier {
  DateTime createNoteDateTime = DateTime.now();

  List<Book> books = [];
  bool isBooksLoading = true;

  List<Note> notes = [];
  bool isNotesLoading = true;

  String get getLabel {
    return "${createNoteDateTime.year}.${createNoteDateTime.month < 10 ? '0${createNoteDateTime.month}' : createNoteDateTime.month}.${createNoteDateTime.day < 10 ? '0${createNoteDateTime.day}' : createNoteDateTime.day} ${createNoteDateTime.hour < 10 ? '0${createNoteDateTime.hour}' : createNoteDateTime.hour}:${createNoteDateTime.minute < 10 ? '0${createNoteDateTime.minute}' : createNoteDateTime.minute}";
  }

  void init() {
    loadBooks();
    loadNotes();
  }

  updateDateTime(DateTime value) {
    createNoteDateTime = value;
    print(value);
    notifyListeners();
  }

  loadBooks() async {
    books = await Book.all();
    isBooksLoading = false;

    notifyListeners();
  }

  updateBook(Book book, String name, String pagesCount) async {
    await book.update(name: name, pagesCount: int.parse(pagesCount));
    loadBooks();
  }

  deleteBook(Book book) async {
    await book.delete();

    loadBooks();
  }

  createBook(String name, String pagesCount) async {
    await Book.create(name: name, pagesCount: int.parse(pagesCount));

    loadBooks();
  }

  loadNotes() async {
    notes = await Note.all();
    isBooksLoading = false;

    notifyListeners();
  }

  createNote(String bookId, String start, String end) async {
    await Note.create(
      bookId: bookId,
      start: int.parse(start),
      end: int.parse(end),
      date: createNoteDateTime,
    );

    loadNotes();
  }

  updateNote(Note note, String start, String end, String date) async {
    await note.update(
      start: int.parse(start),
      end: int.parse(end),
      // date: DateTime.parse(date),
    );

    loadNotes();
  }

  deleteNote(Note note) async {
    await note.delete();

    loadNotes();
  }

  setDate() {
    createNoteDateTime = DateTime.now();

    notifyListeners();
  }
}
