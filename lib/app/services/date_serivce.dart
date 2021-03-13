import 'package:intl/intl.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/localization/language/language_en.dart';

abstract class DateBase {
  String getCurrentDate();

  String formatDateTime(DateTime date);
}

class DateService extends DateBase {
  static var standardDateFormat = 'dd-MM-yyyy';
  static var usDateFormat = 'MMM-dd-yyyy';

  @override
  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat(standardDateFormat).format(now);
  }

  String formatDateTime(DateTime date) {
    //if EN local
    final DateFormat formatter = DateFormat(standardDateFormat);
    return formatter.format(date);
  }

  String formatDateTimeByLocale(DateTime date) {
    //if EN local
    if (globals.Globals.instance.getLanguage() is LanguageEn) {
      return DateFormat('hh:mm a').format(date);
    }
    return  DateFormat('hh:mm').format(date);
  }

  static String toPresentationDate(String date) {
    if (globals.Globals.instance.getLanguage() is LanguageEn) {
      try {
        DateTime dateTime = new DateFormat(standardDateFormat).parse(date);
        return DateFormat(usDateFormat).format(dateTime);
      } catch (e) {
        return date;
      }
    }
    return date;
  }
}
