part of 'deck_cubit.dart';

@immutable
abstract class DeckState {}

class DeckLoading extends DeckState {}

class DeckError extends DeckState {
  final Exception exception;

  DeckError({@required this.exception});
}

class DeckCardsReady extends DeckState {
  final List<TarotDeckCard> allCards;

  DeckCardsReady({@required this.allCards});
}
