import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';

Widget buildIcon(String assetPath, double size) {
  return Padding(
    padding: const EdgeInsets.all(smallIconsPadding),
    child: SvgPicture.asset(assetPath,
        color: cardIconColour, width: size, height: size, fit: BoxFit.fitWidth),
  );
}
