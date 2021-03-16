import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

class NotesHeader extends StatelessWidget {
  NotesHeader({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: cardHeaderTextStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
