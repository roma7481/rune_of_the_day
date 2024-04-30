import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/pages/main/empty_content.dart';

Widget buildCustomStream<T>(
    {required Widget Function(T? data) builder,
    required Stream<T> streamMethod}) {
  Languages language = globals.Globals.instance.getLanguage();
  return StreamBuilder<T>(
      stream: streamMethod,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data);
        } else if (snapshot.hasError) {
          return EmptyContent(
            title: language.errorMessageHeader,
            message: language.errorMessageContent,
          );
        }
        Widget progressIndicator = Platform.isIOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator();
        return Center(child: progressIndicator);
      });
}
