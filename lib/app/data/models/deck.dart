import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/data/repositories/sqlite_database.dart';
import 'package:rune_of_the_day/app/services/image_picker_service.dart';

import 'category.dart';

class TarotDeckCard {
  TarotDeckCard(this.image, this.name, this.cardId);

  final Widget image;
  final String? name;
  final int? cardId;

  factory TarotDeckCard.fromMap(Map<String, dynamic> row) {
    ImagePickerBase imagePicker = ImagePickerService();

    int? id = CardCategory.getCardId(row);
    String? cardName = CardCategory.getCardName(row);
    String imagePath = imagePicker.getImageById(id)!;

    return new TarotDeckCard(
      Image.asset(imagePath),
      cardName,
      id,
    );
  }

  static Future<List<TarotDeckCard>> getDeck() async {
    DBService _dbService = DBService.instance;
    List<TarotDeckCard> cards = await _dbService.getEntriesForColumns(
      tableName: CardCategory.tableName,
      column1: CardCategory.cardIdColumn,
      column2: CardCategory.cardNameColumn,
      builder: (row) => TarotDeckCard.fromMap(row),
    );

    return cards;
  }
}
