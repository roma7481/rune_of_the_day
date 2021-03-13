import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserRu extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'Таро как карта дня',
        description: row['meaning'],
        icon: starIcon);
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
    categories.add(CardCategory(
        header: 'Общее значение', description: row['general'], icon: infoIcon));
    categories.add(CardCategory(
        header: 'Личностное состояние',
        description: row['personal_condition'],
        icon: penIcon));
    categories.add(CardCategory(
        header: 'На более глубоком уровне',
        description: row['deep_meaning'],
        icon: atomIcon));
    categories.add(CardCategory(
        header: 'Работа',
        description: row['work'],
        icon: workIcon));
    categories.add(CardCategory(
        header: 'Финансовое положение',
        description: row['money'],
        icon: moneyIcon));
    categories.add(CardCategory(
        header: 'Личные отношения', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Состояние здоровья',
        description: row['health'],
        icon: healthIcon));
    categories.add(CardCategory(
        header: 'Совет карты', description: row['advice'], icon: penIcon));

    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_RUS';
}
