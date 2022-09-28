import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserDe extends DataParser {
  const DataParserDe();

  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'name_de';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row, bool isFlipped) {
    var columnName = 'second_name_de';
    var header = 'Zweitname';

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
      flippedNamePrefix = ' (Umgekehrt)';
    }

    return row['name_de'] + flippedNamePrefix;
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
        header: 'Rune des Tages', description: row['meaning_de'], icon: infoIcon));
    categories.add(CardCategory(
        header: 'Runenberatung', description: row['advice_de'], icon: penIcon));
    categories.add(
        CardCategory(header: 'Arbeit', description: row['work_de'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Liebe', description: row['love_de'], icon: loveIcon));
    return categories;
  }

  _getFlippedCategories(Map<String, dynamic> row) {
    var flippedNamePrefix = ' (Umgekehrt)';
    List<CardCategory> categories = [];
    categories.add(CardCategory(
        header: 'Rune des Tages (Umgekehrt)', description: row['meaning_upright_de'], icon: infoIcon));
    categories.add(
        CardCategory(header: 'Arbeit'+ flippedNamePrefix, description: row['work_flipped_de'], icon: workIcon));
    categories.add(
        CardCategory(header: 'Liebe'+ flippedNamePrefix, description: row['love_upright_de'], icon: loveIcon));
    return categories;
  }

  @override
  String get tableName => 'runes_de';
}
