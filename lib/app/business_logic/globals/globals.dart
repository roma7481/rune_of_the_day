library app.globals;

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dateTimePicker;
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_en.dart';
import 'package:rune_of_the_day/app/localization/language/language_en.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/localization/locale_utils.dart';


class Globals {
  Globals._();

  static final instance = Globals._();

  double? textSize = 18.0;
  Languages language = const LanguageEn();
  DataParser dataParser = const DataParserEn();
  dateTimePicker.LocaleType localeType = dateTimePicker.LocaleType.en;

  void setLocale({required String? localeCode}) {
    this.language = LocaleUtils.selectLanguage(localeCode!);
    this.dataParser = LocaleUtils.selectDataParser(localeCode);
    this.localeType = LocaleUtils.getTimePickerLocale(localeCode);
  }

  Languages getLanguage() {
    return this.language;
  }

  dateTimePicker.LocaleType getLocaleType() {
    return this.localeType;
  }

  DataParser getDataParser() {
    return this.dataParser;
  }

  void setTextSize({required double? textSize}) {
    this.textSize = textSize;
  }

  double? getTextSize() {
    return textSize;
  }
}
