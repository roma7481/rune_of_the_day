import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserEn extends DataParser {
  const DataParserEn();


  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'name';

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
    return row['name'];
  }

  @override
  List<CardCategory> getCategories(Map<String, dynamic> row) {
    List<CardCategory> categories = [];
    categories.add(
        CardCategory(header: 'Rune of the day', description: row['rune_of_the_day'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Genaral info', description: row['general_info'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Key sentence', description: row['keysentence'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Work', description: row['work'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Love', description: row['love'], icon: loveIcon));

    return categories;
  }

  @override
  String get tableName => 'runes_en';
}
