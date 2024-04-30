import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;

class CardCategory {
  const CardCategory({
    this.header = '',
    this.description = '',
    this.icon = '',
  });

  final String header;
  final String? description;
  final String icon;

  static List<CardCategory> getCategories(Map<String, dynamic> row, [bool? isFlipped, bool? canBeInverted]) {
    return globals.Globals.instance.getDataParser().getCategories(row, isFlipped, canBeInverted);
  }

  static CardCategory getCardDescription(Map<String, dynamic> row, [bool? isFlipped]) {
    return globals.Globals.instance.getDataParser().getCardDescription(row, isFlipped);
  }

  static String? getCardName(Map<String, dynamic> row, [bool? isFlipped]) {
    return globals.Globals.instance.getDataParser().getCardName(row, isFlipped);
  }

  static int? getCardId(Map<String, dynamic> row) {
    return globals.Globals.instance.getDataParser().getCardId(row);
  }

  static String get cardIdColumn =>
      globals.Globals.instance.getDataParser().cardIdColumn;

  static String get cardNameColumn =>
      globals.Globals.instance.getDataParser().cardNameColumn;

  static String get tableName =>
      globals.Globals.instance.getDataParser().tableName;
}
