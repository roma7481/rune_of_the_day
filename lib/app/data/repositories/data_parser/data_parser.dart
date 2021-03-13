import 'package:rune_of_the_day/app/data/models/category.dart';

abstract class DataParser {
  const DataParser();

  List<CardCategory> getCategories(Map<String, dynamic> row);

  CardCategory getCardDescription(Map<String, dynamic> row);

  String getCardName(Map<String, dynamic> row);

  int getCardId(Map<String, dynamic> row);

  String get cardIdColumn;

  String get cardNameColumn;

  String get tableName;
}
