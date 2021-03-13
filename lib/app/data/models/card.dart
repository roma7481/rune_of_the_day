import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/sqlite_database.dart';
import 'package:rune_of_the_day/app/services/image_picker_service.dart';

class TarotCard {
  const TarotCard(
      {this.image = '',
      this.id = 0,
      this.descriptionCategory = const CardCategory(),
      this.categories = const [],
      this.name = ''});

  final String name;
  final int id;
  final CardCategory descriptionCategory;
  final List<CardCategory> categories;
  final String image;

  static Future<TarotCard> getCardById(int cardId) async {
    DBService _dbService = DBService.instance;
    return await _dbService.getEntryById(
      tableName: CardCategory.tableName,
      column: CardCategory.cardIdColumn,
      id: cardId,
      builder: (data, id) => TarotCard.fromMap(data, id),
    );
  }

  factory TarotCard.fromMap(Map<String, dynamic> row, int cardId) {
    //factory c`tor, implementation of a c`tor that doesn't always create an object
    if (row == null) {
      return null;
    }
    ImagePickerBase imagePicker = ImagePickerService();

    String name = CardCategory.getCardName(row);
    CardCategory description = CardCategory.getCardDescription(row);
    String image = imagePicker.getImageById(cardId);
    List<CardCategory> _cardCategories = CardCategory.getCategories(row);

    return new TarotCard(
        id: cardId,
        image: image,
        descriptionCategory: description,
        categories: _cardCategories,
        name: name);
  }
}
