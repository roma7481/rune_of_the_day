import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

class CardHeader extends StatelessWidget {
  CardHeader({
    Key key,
    this.isVisible = true,
    this.topPadding = 88.0,
    this.text,
  }) : super(key: key);

  final bool isVisible;
  final String text;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(top: topPadding),
          child: Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: isVisible,
            child: Text(
          text,
          textAlign: TextAlign.center,
          style: headerTextStyle,
        ),
      ),
    ));
  }
}
