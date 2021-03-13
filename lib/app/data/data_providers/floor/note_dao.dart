import 'package:floor/floor.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';

@dao
abstract class NoteDao {
  @Query("SELECT * FROM " + noteTable + " ORDER BY timeSaved DESC")
  Future<List<Note>> getAll();

  @Query("SELECT * FROM " +
      noteTable +
      " WHERE cardId = :cardId ORDER BY timeSaved DESC")
  Future<List<Note>> getNotesByCardId(int cardId);

  @Query("SELECT * FROM " +
      noteTable +
      " WHERE cardId = :cardId ORDER BY timeSaved DESC LIMIT 1")
  Future<Note> getLastNote(int cardId);

  @Query("SELECT DISTINCT cardId FROM " + noteTable)
  Future<List<Note>> getCards();

  @Query("SELECT * FROM " + noteTable + " WHERE noteId = :id")
  Future<Note> getNoteById(int id);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @delete
  Future<int> deleteNotes(List<Note> notes);
}
