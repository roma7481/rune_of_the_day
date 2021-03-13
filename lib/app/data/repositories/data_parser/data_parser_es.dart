import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserEs extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'Descripción', description: row['meaning'], icon: starIcon);
  }

  @override
  int getCardId(Map<String, dynamic> row) {
    return row['id'];
  }

  @override
  String getCardName(Map<String, dynamic> row) {
    return row['card_name'];
  }

  @override
  List<CardCategory> getCategories(Map<String, dynamic> row) {
    List<CardCategory> categories = [];
    categories.add(
        CardCategory(header: 'Amor', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Trabajo', description: row['work'], icon: workIcon));
    categories.add(CardCategory(
        header: 'Salud', description: row['health'], icon: healthIcon));
    categories.add(CardCategory(
        header: 'Dinero', description: row['money'], icon: moneyIcon));
    categories.add(CardCategory(
        header: 'Sí / No', description: row['yes_no'], icon: yesNoIcon));

    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_ES';
}
