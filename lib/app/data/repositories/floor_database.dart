import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';

import '../data_providers/floor/note_dao.dart';

///flutter packages pub run build_runner build
/// or  flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
/// the name of the part, should match the name of your database class
part 'floor_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;

  static Future<void> insertNote(Note note) async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    await noteDao.insertNote(note);
  }

  static Future<void> updateNote(Note note) async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    await noteDao.updateNote(note);
  }

  static Future<List<Note>> getAllNotes() async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    return noteDao.getAll();
  }

  static Future<List<Note>> getUniqueCardNotes() async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    return noteDao.getCards();
  }

  static Future<int> deleteNotes(List<Note> notes) async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    return noteDao.deleteNotes(notes);
  }

  static Future<void> deleteNote(Note note) async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    return noteDao.deleteNote(note);
  }

  static Future<Note?> getLastNoteForCard(int? cardId) async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    return noteDao.getLastNote(cardId!);
  }

  static Future<List<Note>> getNotesForCard(int? cardId) async {
    final database = await $FloorAppDatabase.databaseBuilder(floorDB).build();
    final noteDao = database.noteDao;

    return noteDao.getNotesByCardId(cardId!);
  }
}
