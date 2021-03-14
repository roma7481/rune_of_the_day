import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/language_cubit/language_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/localization/language/languages.dart';

class LanguageDialog extends StatefulWidget {
  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class LanguageItem {
  LanguageItem(
    this.locale,
    this.languageName,
  );

  final String locale;
  final String languageName;
}

class _LanguageDialogState extends State<LanguageDialog> {
  static Map<int, LanguageItem> allButtons = {
    0: LanguageItem(en, english),
    1: LanguageItem(ru, russian),
  };

  @override
  Widget build(BuildContext context) {
    Languages language = globals.Globals.instance.getLanguage();
    var _selectedButtonId = context.watch<LanguageCubit>().state.buttonId;
    return CupertinoActionSheet(
      title: Text(
        language.languagesDialogHeader,
        style: dialogHeaderTextStyle,
      ),
      message: Text(
        language.languagesDialogText,
        style: dialogContentTextStyle,
      ),
      actions: List<Widget>.generate(allButtons.length, (int index) {
        var languageItem = allButtons[index];
        return CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              _selectedButtonId = index;
              context
                  .read<LanguageCubit>()
                  .emitLocale(languageItem.locale, index);
              Navigator.pop(context);
            });
          },
          isDefaultAction: _selectedButtonId == index,
          child: Text(languageItem.languageName),
        );
      }),
    );
  }
}
