import 'package:flutter/widgets.dart';
import 'package:rune_of_the_day/app/constants/enums/enums.dart';
import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';

import '../../data/models/card.dart';

class CardModel {
  CardModel({
    this.isForwardEnabled = false,
    this.isBackEnabled = false,
    this.header = '',
    this.cardType = CardType.closed,
    this.card = const TarotCard(),
    this.note = const Note(),
  });

  final CardType cardType;
  final TarotCard card;
  final String header;
  final bool isBackEnabled;
  final bool isForwardEnabled;
  final Note note;

  CardModel copyWith(
    bool isForwardEnabled,
    bool isBackEnabled,
    CardType cardType,
    String cardName,
    TarotCard card,
    String header,
    Note note,
  ) {
    return CardModel(
      isForwardEnabled: isForwardEnabled ?? this.isForwardEnabled,
      isBackEnabled: isBackEnabled ?? this.isBackEnabled,
      cardType: cardType ?? this.cardType,
      card: card ?? this.card,
      header: header ?? this.header,
      note: note ?? this.note,
    );
  }

  bool get isHeaderVisible => cardType != CardType.closed;

  Widget get image {
    final String imagePath =
        cardType == CardType.closed ? cardBack : card.image;

    return Image.asset(imagePath);
  }

  String get descriptionHeader => card.descriptionCategory.header;

  String get descriptionContent => card.descriptionCategory.description;

  String get descriptionImage => card.descriptionCategory.icon;
}
