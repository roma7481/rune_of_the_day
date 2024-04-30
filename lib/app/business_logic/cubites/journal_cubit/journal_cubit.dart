import 'package:meta/meta.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/deck.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/data/repositories/floor_database.dart';
import 'package:bloc/bloc.dart';


part 'journal_state.dart';

class JournalCubit extends Cubit<JournalState> {
  JournalCubit() : super(JournalLoading()) {
    emitJournalByDates();
  }

  void emitJournalByDates() async {
    try {
      List<Note> notes = await AppDatabase.getAllNotes();
      List<TarotDeckCard> cards = await TarotDeckCard.getDeck();

      Map<Note, TarotDeckCard> notesByDateToCards = {};

      notes.forEach((note) {
        TarotDeckCard card = _getCardById(note.cardId, cards);
        notesByDateToCards.putIfAbsent(note, () => card);
      });

      emit(JournalByDates(
        notesByDateToCards: notesByDateToCards,
      ));
    } on Exception catch (e) {
      emitJournalException(e);
    }
  }

  void emitJournalByCards() async {
    try {
      Map<TarotCard, int> cardToNumNotes = await getCardsToNumNotes();

      emit(JournalByCards(
        cardToNumNotes: cardToNumNotes,
      ));
    } on Exception catch (e) {
      emitJournalException(e);
    }
  }

  Future<Map<TarotCard, int>> getCardsToNumNotes() async {
    List<Note> notes = await AppDatabase.getAllNotes();
    Map<int?, int> cardIdToNumNotes = {};

    List<TarotDeckCard> cards = await TarotDeckCard.getDeck();

    notes.forEach((note) {
      if (cardIdToNumNotes.containsKey(note.cardId)) {
        cardIdToNumNotes.update(note.cardId, (value) => value + 1);
      } else {
        cardIdToNumNotes.putIfAbsent(note.cardId, () => 1);
      }
    });

    Map<TarotCard, int> cardToNumNotes = {};

    cardIdToNumNotes.forEach((cardId, numNotes) {
      Note note = notes.firstWhere((note) => note.cardId == cardId);
      TarotDeckCard card = _getCardById(note.cardId, cards);
      var tarotCard =
          TarotCard(id: cardId, image: note.cardImage, name: card.name);
      cardToNumNotes.putIfAbsent(tarotCard, () => numNotes);
    });
    return cardToNumNotes;
  }

  void emitJournalException(exception) => emit(JournalError(
        exception: exception,
      ));

  TarotDeckCard _getCardById(int? cardId, List<TarotDeckCard> cards) {
    return cards.where((card) => card.cardId == cardId).toList().first;
  }
}
