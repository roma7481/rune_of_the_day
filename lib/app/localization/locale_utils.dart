import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_en.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_ru.dart';

import 'language/language_en.dart';
import 'language/language_ru.dart';
import 'language/languages.dart';

class LocaleUtils {
  static Languages selectLanguage(String localeCode) {
    switch (localeCode) {
      case en:
        return LanguageEn();
        break;
      case ru:
        return LanguageRu();
        break;
    }
  }

  static DataParser selectDataParser(String localeCode) {
    switch (localeCode) {
      case en:
        return DataParserEn();
        break;
      case ru:
        return DataParserRu();
        break;
    }
  }

  static LocaleType getTimePickerLocale(String localeCode) {
    switch (localeCode) {
      case en:
        return LocaleType.en;
        break;
      case ru:
        return LocaleType.ru;
        break;
    }
  }
}
