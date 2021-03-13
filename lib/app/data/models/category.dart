import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;

class CardCategory {
  const CardCategory({
    this.header = '',
    this.description = '',
    this.icon = '',
  });

  final String header;
  final String description;
  final String icon;

  static List<CardCategory> getCategories(Map<String, dynamic> row) {
    return globals.Globals.instance.getDataParser().getCategories(row);
  }

  static CardCategory getCardDescription(Map<String, dynamic> row) {
    return globals.Globals.instance.getDataParser().getCardDescription(row);
  }

  static String getCardName(Map<String, dynamic> row) {
    return globals.Globals.instance.getDataParser().getCardName(row);
  }

  static int getCardId(Map<String, dynamic> row) {
    return globals.Globals.instance.getDataParser().getCardId(row);
  }

  static String get cardIdColumn =>
      globals.Globals.instance.getDataParser().cardIdColumn;

  static String get cardNameColumn =>
      globals.Globals.instance.getDataParser().cardNameColumn;

  static String get tableName =>
      globals.Globals.instance.getDataParser().tableName;
}
