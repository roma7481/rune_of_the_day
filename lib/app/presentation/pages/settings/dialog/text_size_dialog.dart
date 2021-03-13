
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rune_of_the_day/app/business_logic/cubites/text_size_cubit/text_size_cubit.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/strings/strings.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

class TextSizeDialog extends StatefulWidget {
  @override
  State createState() => new TextSizeDialogState();
}

class TextSizeDialogState extends State<TextSizeDialog> {
  static const Map<int, String> allButtons = {
    0: small,
    1: medium,
    2: large,
  };

  @override
  Widget build(BuildContext context) {
    /// platform dependent dialog usage example
    // return Platform.isIOS
    //     ? _cupertinoDialog(context)
    //     : _materialDialog(context);
    return _cupertinoDialog(context);
  }

  Widget _cupertinoDialog(BuildContext context) {
    var language = globals.Globals.instance.getLanguage();
    var _selectedButton = context.watch<TextSizeCubit>().state.buttonId;
    return CupertinoActionSheet(
      title: Text(
        language.textSize,
        style: dialogHeaderTextStyle,
      ),
      message: Text(
        language.selectTextSize,
        style: dialogContentTextStyle,
      ),
      actions: List<Widget>.generate(allButtons.length, (int index) {
        var button = allButtons[index];
        return CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              var textSizeMode = index;
              _selectedButton = textSizeMode;
              context.read<TextSizeCubit>().emitTextSize(textSizeMode);
              Navigator.pop(context);
            });
          },
          isDefaultAction: _selectedButton == index,
          child: _getButtonText(button),
        );
      }),
    );
  }

  Widget _getButtonText(String buttonText) {
    var language = globals.Globals.instance.getLanguage();
    if (buttonText == small) {
      return Text(language.small);
    } else if (buttonText == large) {
      return Text(language.large);
    }
    return Text(language.medium);
  }

  ///uncomment when platform dependent dialog is required
/*
  Widget _materialDialog(BuildContext context) {
    var language = globals.Globals.instance.getLanguage();
    var _selectedRadio = context.watch<TextSizeCubit>().state.buttonId;
    return AlertDialog(
      title: Text(
        language.textSize,
        style: dialogHeaderTextStyle,
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(allButtons.length, (int index) {
              var button = allButtons[index];
              return Row(
                children: [
                  Radio<int>(
                    value: index,
                    groupValue: _selectedRadio,
                    onChanged: (int textSizeMode) async {
                      setState(() {
                        _selectedRadio = textSizeMode;
                        context
                            .read<TextSizeCubit>()
                            .emitTextSize(textSizeMode);
                      });
                    },
                  ),
                  _getButtonText(button),
                ],
              );
            }),
          );
        },
      ),
    );
  }
*/
}
