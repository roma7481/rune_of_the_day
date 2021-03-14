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
  CardCategory getCardDescription(Map<String, dynamic> row, bool isFlipped) {
    var columnName = 'rune_of_the_day';
    var header = 'Rune of the day';

    if (isFlipped != null && isFlipped) {
      columnName = 'rune_of_the_day_upright';
      header = 'Rune of the day (Reversed)';
    }

    return CardCategory(
      header: header,
      description: row[columnName],
      icon: starIcon,
    );
  }

  @override
  int getCardId(Map<String, dynamic> row) {
    return row['id'];
  }

  @override
  String getCardName(Map<String, dynamic> row, bool isFlipped) {
    var flippedNamePrefix = '';
    if (isFlipped != null && isFlipped) {
      flippedNamePrefix = ' (Reversed)';
    }

    return row['name'] + flippedNamePrefix;
  }

  @override
  List<CardCategory> getCategories(
    Map<String, dynamic> row,
    bool isFlipped,
    bool canBeInverted,
  ) {
    if (isFlipped == null) {
      if (canBeInverted != null && canBeInverted) {
        return _getCategories(row) + _getFlippedCategories(row);
      }
      return _getCategories(row);
    }

    List<CardCategory> categories =
        isFlipped ? _getFlippedCategories(row) : _getCategories(row);

    return categories;
  }

  List<CardCategory> _getCategories(Map<String, dynamic> row) {
    List<CardCategory> categories = [];
    categories.add(CardCategory(
        header: 'General info',
        description: row['general_info'],
        icon: workIcon));
    categories.add(CardCategory(
        header: 'General meaning',
        description: row['meaning'],
        icon: workIcon));
    categories.add(CardCategory(
        header: 'Key sentence',
        description: row['keysentence'],
        icon: workIcon));
    categories.add(
        CardCategory(header: 'Work', description: row['work'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Love', description: row['love'], icon: loveIcon));
    return categories;
  }

  _getFlippedCategories(Map<String, dynamic> row) {
    var flippedNamePrefix = ' (Reversed)';
    List<CardCategory> categories = [];
    categories.add(CardCategory(
        header: 'General info',
        description: row['general_info'],
        icon: workIcon));
    categories.add(CardCategory(
        header: 'General meaning' + flippedNamePrefix,
        description: row['meaning_upright'],
        icon: workIcon));
    categories.add(CardCategory(
        header: 'Key sentence' + flippedNamePrefix,
        description: row['keysentence_upright'],
        icon: workIcon));
    categories.add(CardCategory(
      header: 'Work' + flippedNamePrefix,
      description: row['work_upright'],
      icon: workIcon,
    ));
    categories.add(CardCategory(
      header: 'Love' + flippedNamePrefix,
      description: row['love_upright'],
      icon: loveIcon,
    ));
    return categories;
  }

  @override
  String get tableName => 'runes_en';
}
