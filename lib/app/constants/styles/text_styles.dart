import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;

import 'colours.dart';

TextStyle contextTextStyle() {
  double textSize = globals.Globals.instance.getTextSize();
  return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(fontSize: textSize, color: cardContentColor));
}

TextStyle buttonTextStyle() {
  double textSize = globals.Globals.instance.getTextSize();
  return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(fontSize: textSize, color: Colors.black));
}

TextStyle urlLinkStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 18.0,
  color: cardUrlLinkColor,
  decoration: TextDecoration.underline,
));

TextStyle hintTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(fontSize: 18.0, color: hintTextColor));

TextStyle settingsTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(fontSize: 18.0, color: noteInputTextColor));

TextStyle dialogHeaderTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
));

TextStyle dialogContentTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 18.0,
  color: Colors.black,
));

TextStyle noteInputTextStyle() {
  double textSize = globals.Globals.instance.getTextSize();
  return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(fontSize: textSize, color: noteInputTextColor));
}

TextStyle noteInputHeaderTextStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
        fontSize: 18.0, color: noteHintColor, fontWeight: FontWeight.bold));

const TextStyle noteHintTextStyle = TextStyle(
  fontSize: 24.0,
  color: noteHintColor,
);

TextStyle appBarTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(fontSize: 18.0, color: appBarTextColor));

TextStyle showMoreTextStyle() {
  double textSize = globals.Globals.instance.getTextSize();
  return GoogleFonts.philosopher(
      textStyle: TextStyle(
          fontSize: textSize - 1.5,
          color: showMoreTextColor,
          fontWeight: FontWeight.bold));
}

TextStyle headerTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 19.0, color: cardHeaderColor, fontWeight: FontWeight.bold),
);

TextStyle moreAppsHeaderTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 19.0, color: datePickerItem, fontWeight: FontWeight.bold),
);

TextStyle moreAppsTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
);

TextStyle cardHeaderTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 19.0, color: runeHeaderColor, fontWeight: FontWeight.bold),
);

TextStyle notesForCardStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 19.0, color: noteInputTextColor, fontWeight: FontWeight.bold),
);

TextStyle noteHeaderTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 17.0, color: cardHeaderColor, fontWeight: FontWeight.bold),
);

TextStyle datePickerTextStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
        fontSize: 19.0,
        color: datePickerTextColor,
        fontWeight: FontWeight.bold));

TextStyle notificationPickerTextStyle =
    TextStyle(fontSize: 60.0, color: Colors.black);

TextStyle cardDeckTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
      fontSize: 16.0, color: cardHeaderColor, fontWeight: FontWeight.bold),
);

IconThemeData appBarIconStyle = IconThemeData(
  color: appBarIconColour, //change your color here
);
