part of 'journal_cubit.dart';

@immutable
abstract class JournalState {}

class JournalLoading extends JournalState {}

class JournalError extends JournalState {
  final Exception exception;

  JournalError({@required this.exception});
}

class JournalByDates extends JournalState {
  final Map<Note, TarotDeckCard> notesByDateToCards;

  JournalByDates({@required this.notesByDateToCards});
}

class JournalByCards extends JournalState {
  final Map<TarotCard, int> cardToNumNotes;

  JournalByCards({@required this.cardToNumNotes});
}
