// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../repositories/floor_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`noteId` INTEGER PRIMARY KEY AUTOINCREMENT, `cardId` INTEGER, `cardImage` TEXT, `cardName` TEXT, `date` TEXT, `note` TEXT, `timeSaved` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, dynamic>{
                  'noteId': item.noteId,
                  'cardId': item.cardId,
                  'cardImage': item.cardImage,
                  'date': item.date,
                  'note': item.note,
                  'timeSaved': item.timeSaved
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['noteId'],
            (Note item) => <String, dynamic>{
                  'noteId': item.noteId,
                  'cardId': item.cardId,
                  'cardImage': item.cardImage,
                  'date': item.date,
                  'note': item.note,
                  'timeSaved': item.timeSaved
                }),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'Note',
            ['noteId'],
            (Note item) => <String, dynamic>{
                  'noteId': item.noteId,
                  'cardId': item.cardId,
                  'cardImage': item.cardImage,
                  'date': item.date,
                  'note': item.note,
                  'timeSaved': item.timeSaved
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Future<List<Note>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Note ORDER BY timeSaved DESC',
        mapper: (Map<String, dynamic> row) => Note(
            noteId: row['noteId'] as int,
            cardId: row['cardId'] as int,
            cardImage: row['cardImage'] as String,
            date: row['date'] as String,
            note: row['note'] as String,
            timeSaved: row['timeSaved'] as int));
  }

  @override
  Future<List<Note>> getNotesByCardId(int cardId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Note WHERE cardId = ? ORDER BY timeSaved DESC',
        arguments: <dynamic>[cardId],
        mapper: (Map<String, dynamic> row) => Note(
            noteId: row['noteId'] as int,
            cardId: row['cardId'] as int,
            cardImage: row['cardImage'] as String,
            date: row['date'] as String,
            note: row['note'] as String,
            timeSaved: row['timeSaved'] as int));
  }

  @override
  Future<Note> getLastNote(int cardId) async {
    return _queryAdapter.query(
        'SELECT * FROM Note WHERE cardId = ? ORDER BY timeSaved DESC LIMIT 1',
        arguments: <dynamic>[cardId],
        mapper: (Map<String, dynamic> row) => Note(
            noteId: row['noteId'] as int,
            cardId: row['cardId'] as int,
            cardImage: row['cardImage'] as String,
            date: row['date'] as String,
            note: row['note'] as String,
            timeSaved: row['timeSaved'] as int));
  }

  @override
  Future<List<Note>> getCards() async {
    return _queryAdapter.queryList('SELECT DISTINCT cardId FROM Note',
        mapper: (Map<String, dynamic> row) => Note(
            noteId: row['noteId'] as int,
            cardId: row['cardId'] as int,
            cardImage: row['cardImage'] as String,
            date: row['date'] as String,
            note: row['note'] as String,
            timeSaved: row['timeSaved'] as int));
  }

  @override
  Future<Note> getNoteById(int id) async {
    return _queryAdapter.query('SELECT * FROM Note WHERE noteId = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Note(
            noteId: row['noteId'] as int,
            cardId: row['cardId'] as int,
            cardImage: row['cardImage'] as String,
            date: row['date'] as String,
            note: row['note'] as String,
            timeSaved: row['timeSaved'] as int));
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _noteDeletionAdapter.delete(note);
  }

  @override
  Future<int> deleteNotes(List<Note> notes) {
    return _noteDeletionAdapter.deleteListAndReturnChangedRows(notes);
  }
}
