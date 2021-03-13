import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserJa extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: '意味', description: row['meaning'], icon: starIcon);
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
        CardCategory(header: '恋愛', description: row['love'], icon: loveIcon));
    categories.add(
        CardCategory(header: '仕事', description: row['work'], icon: workIcon));
    categories.add(
        CardCategory(header: 'お金', description: row['money'], icon: moneyIcon));
    categories.add(CardCategory(
        header: '人物像', description: row['person'], icon: personIcon));
    categories.add(CardCategory(
        header: 'カードを読み解くポイント',
        description: row['how_to_read'],
        icon: noteIcon));
    categories.add(CardCategory(
        header: 'カードの意味を更に深く考察',
        description: row['deep_meaning'],
        icon: atomIcon));

    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_JAP';
}
