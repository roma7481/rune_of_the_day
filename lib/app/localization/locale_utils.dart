import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_de.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_en.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_es.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_it.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_ja.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_pt.dart';
import 'package:rune_of_the_day/app/data/repositories/data_parser/data_parser_ru.dart';

import 'language/language_de.dart';
import 'language/language_en.dart';
import 'language/language_it.dart';
import 'language/language_ja.dart';
import 'language/language_pt.dart';
import 'language/language_ru.dart';
import 'language/language_sp.dart';
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
      case es:
        return LanguageEs();
        break;
      case pt:
        return LanguagePt();
        break;
      case it:
        return LanguageIt();
        break;
      case de:
        return LanguageDe();
        break;
      case ja:
        return LanguageJa();
        break;
      default:
        return LanguageEn();
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
      case es:
        return DataParserEs();
        break;
      case pt:
        return DataParserPt();
        break;
      case it:
        return DataParserIt();
        break;
      case de:
        return DataParserDe();
        break;
      case ja:
        return DataParserJa();
        break;
      default:
        return DataParserEn();
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
      case es:
        return LocaleType.es;
        break;
      case pt:
        return LocaleType.pt;
        break;
      case it:
        return LocaleType.it;
        break;
      case de:
        return LocaleType.de;
        break;
      case ja:
        return LocaleType.jp;
        break;
      default:
        return LocaleType.en;
    }
  }
}
