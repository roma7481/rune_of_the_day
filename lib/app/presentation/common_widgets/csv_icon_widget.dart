import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';

Widget buildIcon(String assetPath, double size) {
  return SvgPicture.asset(assetPath,
      color: cardIconColour, width: size, height: size, fit: BoxFit.fitWidth);
}
