import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/services/date_serivce.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker(
      {Key key, @required this.currentDate, @required this.onDateSelect})
      : super(key: key);

  final String currentDate;
  final ValueSetter<DateTime> onDateSelect;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  String _date;
  DateService dateService = DateService();

  @override
  void initState() {
    super.initState();
    _date = widget.currentDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.0)),
            ),
            onPressed: () {
              DatePicker.showDatePicker(context,
                  theme: DatePickerTheme(
                    backgroundColor: datePickerColor,
                    doneStyle: TextStyle(color: datePickerItem),
                    itemStyle: TextStyle(color: datePickerItem),
                    cancelStyle: TextStyle(color: datePickerItem),
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true,
                  minTime: DateTime(2010, 1, 1),
                  maxTime: DateTime(2080, 12, 31), onConfirm: (date) {
                widget.onDateSelect(date);
                _date = dateService.formatDateTime(date);
                setState(() {});
              },
                  currentTime: DateTime.now(),
                  locale: globals.Globals.instance.getLocaleType());
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              " $_date",
                              style: datePickerTextStyle,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18.0,
                              color: datePickerTextColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
        ],
      ),
    );
  }
}
