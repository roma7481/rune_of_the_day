import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/localization/language/languages.dart';
import 'package:rune_of_the_day/app/presentation/pages/main/empty_content.dart';

Widget errorDialog() {
  Languages language = globals.Globals.instance.getLanguage();
  return EmptyContent(
    title: language.errorMessageHeader,
    message: language.errorMessageContent,
  );
}
