import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/card_button.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/card_header.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_app_bar.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_scuffold.dart';

import 'detailed_description_args.dart';

class DetailedDescriptionPage extends StatelessWidget {
  const DetailedDescriptionPage({required this.args});

  final DetailedDescriptionArgs args;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.withBanner(
        appBar: CustomAppBar(children: [
          Text(globals.Globals.instance.getLanguage().detailedDescription,
              style: headerTextStyle),
        ]),
        content: _buildPageContent(args));
  }

  CustomScrollView _buildPageContent(DetailedDescriptionArgs args) {
    return CustomScrollView(
      slivers: [
        _buildCardHeader(args.headerText),
        _buildCardButton(args.image),
        _buildDescriptionCard(args.descriptionCard),
      ],
    );
  }

  Widget _buildDescriptionCard(Widget categoryCard) {
    return categoryCard;
  }

  Widget _buildCardHeader(String? headerText) {
    return CardHeader(
      text: headerText,
    );
  }

  Widget _buildCardButton(Widget image) {
    return CardButton(
      image: image,
      onPressed: () => {},
    );
  }
}
