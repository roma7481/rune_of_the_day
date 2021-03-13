import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/notifications_cubit/notifications_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/localization/language/language_en.dart';
import 'package:rune_of_the_day/app/localization/language/language_ja.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';
import 'package:rune_of_the_day/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationDialog extends StatefulWidget {
  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  var hoursInit;
  var minutesInit;
  var isAlarmSetInit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
      hoursInit = hoursInit ?? state.hours;
      minutesInit = minutesInit ?? state.minutes;
      isAlarmSetInit = isAlarmSetInit ?? state.isAlarmSet;
      var isAlarmSet = state.isAlarmSet;
      var hours = state.hours;
      var minutes = state.minutes;
      return _buildDialog(context, isAlarmSet, hours, minutes);
    });
  }

  CupertinoAlertDialog _buildDialog(
    BuildContext context,
    bool isAlarmSet,
    int hours,
    int minutes,
  ) {
    Languages language = globals.Globals.instance.getLanguage();

    return CupertinoAlertDialog(
      title: new Text(language.dailyReminder),
      content: _buildDialogContent(
        context,
        isAlarmSet,
        hours,
        minutes,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            scheduleAlarm(isAlarmSet, hours, minutes);
            Navigator.of(context, rootNavigator: true).pop('Discard');
          },
          child: Text(language.yes),
        ),
        CupertinoDialogAction(
          onPressed: () {
            context.read<NotificationsCubit>().emitResetAlarm(
                  isAlarmSetInit,
                  hoursInit,
                  minutesInit,
                );
            Navigator.of(context, rootNavigator: true).pop('Discard');
          },
          child: Text(language.cancel),
        )
      ],
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    bool isAlarmSet,
    int hours,
    int minutes,
  ) {
    return Column(
      children: [
        _buildDialogText(),
        _buildTimeDropdown(
          context,
          hours,
          minutes,
        ),
        _buildOnOffSwitch(context, isAlarmSet),
      ],
    );
  }

  Text _buildDialogText() =>
      Text(globals.Globals.instance.getLanguage().clickOnTheTimeToSet);

  Widget _buildOnOffSwitch(BuildContext context, bool isAlarmSet) {
    return CupertinoSwitch(
      activeColor: cupertinoSwitchActive,
      value: isAlarmSet,
      onChanged: (bool isAlarmActive) {
        isAlarmSet = isAlarmActive;
        context.read<NotificationsCubit>().emitSetAlarmState(isAlarmSet);
      },
    );
  }

  Widget _buildTimeDropdown(BuildContext context, int hours, int minutes) {
    return CupertinoDialogAction(
      onPressed: () {
        _buildBottomPicker(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _getFormattedDate(hours, minutes),
              style: notificationPickerTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  void _buildBottomPicker(BuildContext context) {
    Languages language = globals.Globals.instance.getLanguage();
    if (language is LanguageEn) {
      _showAmPm(context);
    } else {
      _showStandard(context);
    }
  }

  void _showAmPm(BuildContext context) {
    DatePicker.showTime12hPicker(
      context,
      theme: _dialogTheme(),
      showTitleActions: true,
      onConfirm: (date) {
        onConfirmTime(context, date);
      },
      locale: LocaleType.en,
      currentTime: DateTime.now(),
    );
  }

  void _showStandard(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      theme: _dialogTheme(),
      showTitleActions: true,
      onConfirm: (date) {
        onConfirmTime(context, date);
      },
      locale: globals.Globals.instance.getLocaleType(),
      currentTime: DateTime.now(),
    );
  }

  DatePickerTheme _dialogTheme() {
    return DatePickerTheme(
      backgroundColor: datePickerColor,
      doneStyle: TextStyle(color: datePickerItem),
      itemStyle: TextStyle(color: datePickerItem),
      cancelStyle: TextStyle(color: datePickerItem),
      containerHeight: 210.0,
    );
  }

  void onConfirmTime(BuildContext context, DateTime date) {
    context.read<NotificationsCubit>().emitSetAlarmTime(
          date.hour,
          date.minute,
        );
  }

  String _getFormattedDate(int hours, int minutes) {
    String formattedHours = hours.toString();
    String formattedMinutes = minutes.toString();
    if (globals.Globals.instance.getLanguage() is LanguageEn) {
      TimeOfDay timeOfTheDay = TimeOfDay(hour: hours, minute: minutes);
      String isAmPm = timeOfTheDay.period == DayPeriod.am ? 'AM' : 'PM';
      String formattedHours = timeOfTheDay.hourOfPeriod.toString();
      formattedHours = formattedHours.length == 1
          ? '0$formattedHours' : formattedHours;
      formattedMinutes = formattedMinutes.length == 1
          ? '0$formattedMinutes'
          : formattedMinutes;
      return '$formattedHours : $formattedMinutes $isAmPm';
    } else {
      formattedHours =
          formattedHours.length == 1 ? '0$formattedHours' : formattedHours;
      formattedMinutes = formattedMinutes.length == 1
          ? '0$formattedMinutes'
          : formattedMinutes;
    }
    return '$formattedHours : $formattedMinutes';
  }

  void scheduleAlarm(bool isAlarmSet, int hours, int minutes) async {
    if (!isAlarmSet) {
      flutterLocalNotificationsPlugin.cancelAll();
      return;
    }

    tz.initializeTimeZones();

    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap(androidAppIcon),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: false,
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var dateTime = DateTime.now();
    dateTime = new DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hours,
      minutes,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        globals.Globals.instance.getLanguage().cardOfTheDay,
        _getNotificationText(),
        tz.TZDateTime.from(dateTime, tz.local),
        platformChannelSpecifics,
        matchDateTimeComponents: DateTimeComponents.time,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  String _getNotificationText() {
    var language = globals.Globals.instance.getLanguage();
    var dateService = DateService();
    var formattedDateTime = dateService.formatDateTime(DateTime.now());

    if (language is LanguageJa) {
      return formattedDateTime + ' ' + language.choseCardForDate;
    }
    return language.choseCardForDate + formattedDateTime;
  }
}
