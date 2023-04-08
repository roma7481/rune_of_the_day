import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';

Widget progressBar() {
  return Container(color: tabBackgroundColor, child: Center(child: new SizedBox(
      height: 50.0,
      width: 50.0,
      child: new CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
        color: runeHeaderColor,
      ))),);
}