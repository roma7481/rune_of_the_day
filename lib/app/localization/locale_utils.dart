import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dateTimePicker;
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_de.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_en.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_ru.dart';

import 'language/language_de.dart';
import 'language/language_en.dart';
import 'language/language_ru.dart';
import 'language/languages.dart';

class LocaleUtils {
  static Languages selectLanguage(String localeCode) {
    switch (localeCode) {
      case en:
        return LanguageEn();
      case de:
        return LanguageDe();
      case ru:
        return LanguageRu();
      default:
        return LanguageEn();
    }
  }

  static DataParser selectDataParser(String localeCode) {
    switch (localeCode) {
      case en:
        return DataParserEn();
      case de:
        return DataParserDe();
      case ru:
        return DataParserRu();
      default:
        return DataParserEn();
    }
  }

  static dateTimePicker.LocaleType getTimePickerLocale(String localeCode) {
    switch (localeCode) {
      case en:
        return dateTimePicker.LocaleType.en;
      case de:
        return dateTimePicker.LocaleType.de;
      case ru:
        return dateTimePicker.LocaleType.ru;
      default:
        return dateTimePicker.LocaleType.en;
    }
  }
}
