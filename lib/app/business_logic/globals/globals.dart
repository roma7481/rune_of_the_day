library app.globals;

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_en.dart';
import 'package:rune_of_the_day/app/localization/language/language_en.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/localization/locale_utils.dart';

class Globals {
  Globals._({
    this.textSize = 18.0,
    this.language = const LanguageEn(),
    this.dataParser = const DataParserEn(),
    this.localeType = LocaleType.en,
  });

  static final instance = Globals._();

  double textSize;
  Languages language;
  DataParser dataParser;
  LocaleType localeType;

  void setLocale({@required String localeCode}) {
    this.language = LocaleUtils.selectLanguage(localeCode);
    this.dataParser = LocaleUtils.selectDataParser(localeCode);
    this.localeType = LocaleUtils.getTimePickerLocale(localeCode);
  }

  Languages getLanguage() {
    return this.language;
  }

  LocaleType getLocaleType() {
    return this.localeType;
  }

  DataParser getDataParser() {
    return this.dataParser;
  }

  void setTextSize({@required double textSize}) {
    this.textSize = textSize;
  }

  double getTextSize() {
    return textSize;
  }
}
