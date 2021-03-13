import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserEn extends DataParser {
  const DataParserEn();

  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'Meaning', description: row['meaning'], icon: starIcon);
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
        CardCategory(header: 'Work', description: row['work'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Love', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Money', description: row['money'], icon: moneyIcon));
    categories.add(CardCategory(
        header: 'Spirit', description: row['spirit'], icon: atomIcon));
    categories.add(CardCategory(
        header: 'Health', description: row['health'], icon: healthIcon));
    categories.add(CardCategory(
        header: 'Yes/No', description: row['yes_no'], icon: yesNoIcon));
    categories.add(CardCategory(
        header: 'Key sentence',
        description: row['key_sentence'],
        icon: keyIcon));
    categories.add(CardCategory(
        header: 'Qualities', description: row['qualities'], icon: noteIcon));
    categories.add(CardCategory(
        header: 'Person', description: row['person'], icon: personIcon));
    categories.add(CardCategory(
        header: 'Events', description: row['eventive_meaning'], icon: checkMarkIcon));
    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_ENG';
}
