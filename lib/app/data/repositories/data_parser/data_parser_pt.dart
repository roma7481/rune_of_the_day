import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserPt extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'O que significa a Carta',
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
        header: 'Descrição detalhada',
        description: row['deep_description'],
        icon: atomIcon));
    categories.add(
        CardCategory(header: 'Amor', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Saúde', description: row['health'], icon: healthIcon));
    categories.add(CardCategory(
        header: 'Trabalho/ Dinheiro ',
        description: row['work_money'],
        icon: moneyIcon));
    categories.add(CardCategory(
        header: 'Sim / Não ', description: row['yes_no'], icon: yesNoIcon));
    categories.add(CardCategory(
        header: 'O Lado Negativo',
        description: row['negative'],
        icon: negativeIcon));

    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_PORT';
}
