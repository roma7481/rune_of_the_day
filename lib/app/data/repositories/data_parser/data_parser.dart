import 'package:rune_of_the_day/app/data/models/category.dart';

abstract class DataParser {
  const DataParser();

  List<CardCategory> getCategories(Map<String, dynamic> row, bool? isFlipped, bool? canBeInverted);

  CardCategory getCardDescription(Map<String, dynamic> row, bool? isFlipped);

  String? getCardName(Map<String, dynamic> row, bool? isFlipped);

  int? getCardId(Map<String, dynamic> row);

  String get cardIdColumn;

  String get cardNameColumn;

  String get tableName;
}
