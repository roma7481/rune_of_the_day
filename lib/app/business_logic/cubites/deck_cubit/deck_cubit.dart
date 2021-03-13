import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rune_of_the_day/app/data/models/deck.dart';

part 'deck_state.dart';

class DeckCubit extends Cubit<DeckState> {
  DeckCubit() : super(DeckLoading()) {
    emitDeckCardsReady();
  }

  void emitDeckCardsReady() async {
    try {
      List<TarotDeckCard> cards = await TarotDeckCard.getDeck();
      emit(DeckCardsReady(allCards: cards));
    } on Exception catch (e) {
      emitDeckException(e);
    }
  }

  void emitDeckException(exception) => emit(DeckError(
        exception: exception,
      ));
}
