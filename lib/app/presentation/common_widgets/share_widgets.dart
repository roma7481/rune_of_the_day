import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
as globals;
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/icons.dart';

import 'csv_icon_widget.dart';

Widget buildShareAndCopy(String content) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    IconButton(
        icon: buildIcon(shareIcon, shareIconSize),
        onPressed: () => _share(content)),
    IconButton(
        icon: buildIcon(copyIcon, copyIconSize),
        onPressed: () => _copy(content))
  ]);
}

void _share(String content) {
  Share.share(content);
}

void _copy(String content) {
  Clipboard.setData(new ClipboardData(text: content));
  Fluttertoast.showToast(
    msg: globals.Globals.instance.getLanguage().copyToast,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
  );
}
