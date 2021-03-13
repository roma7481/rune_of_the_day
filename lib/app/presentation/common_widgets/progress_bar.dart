import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';

Widget progressBar() {
  Widget progressIndicator = Platform.isIOS
      ? showCupertinoProgressBar()
      : CircularProgressIndicator();
  return Center(child: progressIndicator);
}

Widget showCupertinoProgressBar(){
  return NutsActivityIndicator(
    radius: 33,
    activeColor: activeProgress,
    inactiveColor: inactiveProgress,
    tickCount: 11,
    startRatio: 0.55,
  );
}
