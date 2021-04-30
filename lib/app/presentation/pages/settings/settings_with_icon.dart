import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

Widget buildSettingWithIcon(
  Function onClick,
  Widget icon,
  String text,
) {
  return TextButton(
    onPressed: () {
      onClick();
    },
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: icon,
        ),
        Text(
          text,
          style: settingsTextStyle,
        ),
      ],
    ),
  );
}
