import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: child,
      ),
    );
  }
}
