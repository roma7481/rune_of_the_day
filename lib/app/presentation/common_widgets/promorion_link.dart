import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ad_widget.dart';

Widget buildHealingSoundsPromotion() {
  return InkWell(
    onTap: () {
      _launchURL(healingSoundsLink);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: new RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: [
            WidgetSpan(child: healingSoundsAdWidgetTag()),
            new TextSpan(text: Globals.instance.getLanguage().healingSoundsPromotion1, style: contextTextStyle()),
            new TextSpan(text: Globals.instance.getLanguage().healingSoundsPromotion2, style: urlLinkStyle),
            new TextSpan(text: Globals.instance.getLanguage().healingSoundsPromotion3, style: contextTextStyle()),
            new TextSpan(text: '\n'),
          ],
        ),
      ),
    ),
  );
}

Future<void> _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await  launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}