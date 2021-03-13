import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/presentation/pages/pay_wall/pay_wall.dart';

void navigatePremium(BuildContext context) {
  Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
    builder: (BuildContext context) {
      return new PayWall();
    },
  ));
}
