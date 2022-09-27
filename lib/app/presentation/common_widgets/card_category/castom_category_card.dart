import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/business_logic/globals/globals.dart'
    as globals;
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';
import 'package:rune_of_the_day/app/data/models/note.dart';

import '../csv_icon_widget.dart';
import 'card_with_url.dart';

class CustomCategoryCard extends StatelessWidget {
  CustomCategoryCard({
    Key key,
    @required this.header,
    @required this.content,
    @required this.icon,
    this.onMoreInfoPressed,
    this.onAddNote,
    this.isWrapped = true,
    this.isDefaultCard = false,
  }) : super(
          key: key,
        );

  final String header;
  final String content;
  final String icon;
  final bool isWrapped;
  final bool isDefaultCard;
  final VoidCallback onMoreInfoPressed;
  final ValueSetter<Note> onAddNote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildLine(context),
        _buildContent(context),
      ],
    );
  }

  Padding _buildLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: 2.0,
        width: MediaQuery.of(context).size.width * 0.64,
        color: cardLineColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildCardContent(context)),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    if (isDefaultCard) {
      return UrlCard(content: content);
    } else if (isWrapped) {
      return AutoSizeText(content,
          minFontSize: mediumTextSize,
          maxLines: 4,
          overflowReplacement: _buildContentWithLink(context),
          style: contextTextStyle());
    }
    return Text(
      content??"",
      style: contextTextStyle(),
    );
  }

  Widget _buildContentWithLink(BuildContext context) {
    return Column(children: [
      Text(
        content,
        style: contextTextStyle(),
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: _buildLinkAndShareIcon(context),
        ),
      )
    ]);
  }

  Widget _buildLinkAndShareIcon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onMoreInfoPressed,
          child: Text(
            globals.Globals.instance.getLanguage().readMore,
            style: showMoreTextStyle(),
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 8.0,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buildIcon(icon, categoryIconSize),
        Text(
          header,
          style: headerTextStyle,
        ),
        Opacity(
          child: buildIcon(icon, categoryIconSize),
          opacity: 0.0,
        ),
      ]),
    );
  }
}
