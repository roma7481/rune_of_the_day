import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

class CardHeader extends StatelessWidget {
  CardHeader({
    Key key,
    this.isVisible = true,
    this.topPadding = 96.0,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: [ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: cardHeaderTextStyle,
                    ),
                  ),
                ),
              )],
            ),
          ],
        ),
      ),
    ));
  }
}
