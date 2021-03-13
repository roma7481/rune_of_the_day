import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserIt extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'Descrizione', description: row['meaning'], icon: starIcon);
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
        header: 'Frase chiave',
        description: row['key_sentence'],
        icon: keyIcon));
    categories.add(CardCategory(
        header: 'Amore', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Lavoro', description: row['work'], icon: workIcon));
    categories.add(CardCategory(
        header: 'Soldi', description: row['money'], icon: moneyIcon));
    categories.add(CardCategory(
        header: 'Consigli per una relazion',
        description: row['advice'],
        icon: personIcon));

    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_IT';
}
