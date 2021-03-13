import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/localization/language/language_ja.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/castom_category_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildDescriptionCard({
  @required CardCategory descriptionCategory,
  @required bool isClosedCard,
}) {
  if (isClosedCard) {
    return SliverToBoxAdapter(child: Container());
  }
  return SliverToBoxAdapter(
    child: CustomCard(
      child: Column(
        children: [
          CustomCategoryCard(
            header: descriptionCategory.header,
            content: descriptionCategory.description,
            icon: descriptionCategory.icon,
            isWrapped: false,
          ),
          _buildJapaneseAttribution(),
        ],
      ),
    ),
  );
}

StatelessWidget _buildJapaneseAttribution() {
  return (globals.Globals.instance.getLanguage() is LanguageJa)
      ? InkWell(
          onTap: () {
            _launchURL();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              japaneseWebsite,
              style: urlLinkStyle,
            ),
          ),
        )
      : Container();
}

Future<void> _launchURL() async {
  const url = 'http://tarot-stock.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
