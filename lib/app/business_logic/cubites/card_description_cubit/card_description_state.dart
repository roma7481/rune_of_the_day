part of 'card_description_cubit.dart';

@immutable
abstract class CardDescriptionState {}

class CardDescriptionLoading extends CardDescriptionState {}

class CardDescriptionReady extends CardDescriptionState {
  final TarotCard card;
  final Note note;

  CardDescriptionReady({required this.note, required this.card});
}

class CardDescriptionNoteUpdate extends CardDescriptionState {
  final TarotCard card;
  final Note note;

  CardDescriptionNoteUpdate({required this.note, required this.card});
}

class CardDescriptionError extends CardDescriptionState {
  final Exception exception;

  CardDescriptionError({required this.exception});
}
