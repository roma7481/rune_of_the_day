import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserRu extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'name';


/*  CREATE TABLE "runes_rus" (
  "id"	INTEGER,
  "name"	TEXT,
  "meaning"	TEXT,
  "love"	TEXT,
  "work"	TEXT,
  "advice"	TEXT,
  "meaning_upright"	TEXT,
  "love_upright"	TEXT,
  "work_flipped"	TEXT,
  "second_name"	TEXT,
  PRIMARY KEY("id")
  );*/

  @override
  CardCategory getCardDescription(Map<String, dynamic> row) {
    return CardCategory(
        header: 'Руна дня',
        description: row['meaning'],
        icon: starIcon);
  }

  @override
  int getCardId(Map<String, dynamic> row) {
    return row['id'];
  }

  @override
  String getCardName(Map<String, dynamic> row) {
    return row['name'];
  }

  @override
  List<CardCategory> getCategories(Map<String, dynamic> row) {
    List<CardCategory> categories = [];
    categories.add(CardCategory(
        header: 'Работа',
        description: row['work'],
        icon: workIcon));
    categories.add(CardCategory(
        header: 'Личные отношения', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Совет Руны', description: row['advice'], icon: penIcon));

    return categories;
  }

  @override
  String get tableName => 'runes_rus';
}
