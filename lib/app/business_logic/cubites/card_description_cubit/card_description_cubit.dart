import 'package:meta/meta.dart';
import 'package:rune_of_the_day/app/data/models/card.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';
import 'package:rune_of_the_day/app/data/repositories/floor_database.dart';
import 'package:bloc/bloc.dart';

part 'card_description_state.dart';

class CardDescriptionCubit extends Cubit<CardDescriptionState> {
  CardDescriptionCubit(int? cardId) : super(CardDescriptionLoading()) {
    emitCardDescriptionReady(cardId: cardId);
  }

  void emitCardDescriptionReady({required int? cardId}) async {
    try {
      TarotCard card = await TarotCard.getCardById(cardId);
      Note? note = await AppDatabase.getLastNoteForCard(cardId);
      note = note == null ? Note() : note;

      emit(CardDescriptionReady(note: note, card: card));
    } on Exception catch (e) {
      emitCardDescriptionException(e);
    }
  }

  void emitCardDescriptionNoteUpdate(
      {required Note note, required TarotCard card}) {
    if (note.cardId == card.id) {
      emit(CardDescriptionNoteUpdate(note: note, card: card));
    }
  }

  void emitCardDescriptionException(exception) => emit(CardDescriptionError(
        exception: exception,
      ));
}
