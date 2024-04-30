import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

class UrlCard extends StatelessWidget {
  const UrlCard({Key? key, this.content}) : super(key: key);

  final String? content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: new TextSpan(
        children: [
          new TextSpan(
            text: content,
            style: contextTextStyle(),
          ),
          /*new TextSpan( TODO uncomment when need a link to app
            text: appUrl,
            style: urlLinkStyle,
            recognizer: new TapGestureRecognizer()
              ..onTap = () { launch('https://google.com');
              },
          ),*/
        ],
      ),
    );
  }
}
