import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserDe extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'card_name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'Tageskarte',
        description: row['card_of_the_day'],
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
        header: 'Interpretation', description: row['meaning'], icon: noteIcon));
    categories.add(CardCategory(
        header: 'Beruf', description: row['work'], icon: workIcon));
    categories.add(CardCategory(
        header: 'Liebe', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Kartenberatung', description: row['advice'], icon: penIcon));
    categories.add(CardCategory(
        header: 'Bestätigung',
        description: row['claim'],
        icon: microphoneIcon));
    categories.add(CardCategory(
        header: 'Astrologie',
        description: row['astrology'],
        icon: constellationIcon));
    categories.add(CardCategory(
        header: 'Beschreibung',
        description: row['image_description'],
        icon: imageIcon));
    categories.add(CardCategory(
        header: 'Schlüsselwörter',
        description: row['keywords'],
        icon: keyIcon));
    return categories;
  }

  @override
  String get tableName => 'DAILY_CARD_INFO_TAROT_DE';
}
