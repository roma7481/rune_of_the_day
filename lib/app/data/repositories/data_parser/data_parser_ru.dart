import 'package:rune_of_the_day/app/constants/styles/icons.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';

class DataParserRu extends DataParser {
  @override
  String get cardIdColumn => 'id';

  @override
  String get cardNameColumn => 'name';

  @override
  CardCategory getCardDescription(Map<String, dynamic> row, [bool? isFlipped]) {
    var columnName = 'meaning';
    var header = 'Руна дня';

    if (isFlipped != null && isFlipped) {
      columnName = 'meaning_upright';
      header = 'Руна дня (Перёвернутая)';
    }

    return CardCategory(
      header: header,
      description: row[columnName],
      icon: starIcon,
    );
  }

  @override
  int? getCardId(Map<String, dynamic> row) {
    return row['id'];
  }

  @override
  String? getCardName(Map<String, dynamic> row, bool? isFlipped) {
    var flippedNamePrefix = '';
    if (isFlipped != null && isFlipped) {
      flippedNamePrefix = ' (Перёвернутая)';
    }

    return row['name'] + flippedNamePrefix;
  }

  @override
  List<CardCategory> getCategories(
    Map<String, dynamic> row,
    bool? isFlipped,
    bool? canBeInverted,
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
        header: 'Стихия', description: row['second_name'], icon: infoIcon));
    categories.add(CardCategory(
        header: 'Ключевые слова', description: row['keyword'], icon: penIcon));
    categories.add(CardCategory(
        header: 'Работа', description: row['work'], icon: workIcon));
    categories.add(CardCategory(
        header: 'Личные отношения', description: row['love'], icon: loveIcon));
    categories.add(CardCategory(
        header: 'Совет Руны', description: row['advice'], icon: penIcon));
    categories.add(CardCategory(
        header: 'Да/Нет', description: row['yes_no'], icon: yesNoIcon));
    return categories;
  }

  List<CardCategory> _getFlippedCategories(Map<String, dynamic> row) {
    var flippedNamePrefix = ' \n(Перёвернутая)';
    List<CardCategory> categories = [];
    categories.add(
      CardCategory(
        header: 'Стихия' + flippedNamePrefix,
        description: row['second_name'],
        icon: infoIcon,
      ),
    );
    categories.add(CardCategory(
        header: 'Работа' + flippedNamePrefix,
        description: row['work_flipped'],
        icon: workIcon));
    categories.add(
      CardCategory(
          header: 'Личные отношения' + flippedNamePrefix,
          description: row['love_upright'],
          icon: loveIcon),
    );
    categories.add(
      CardCategory(
        header: 'Совет Руны',
        description: row['advice'],
        icon: penIcon,
      ),
    );
    categories.add(CardCategory(
        header: 'Да/Нет'+ flippedNamePrefix, description: row['yes_no_flipped'], icon: yesNoIcon));
    return categories;
  }

  @override
  String get tableName => 'runes_rus';
}
