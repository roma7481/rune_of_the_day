import 'package:flutter/material.dart';

class DetailedDescriptionArgs {
  DetailedDescriptionArgs({
    @required this.descriptionCard,
    @required this.image,
    @required this.headerText,
  });

  final Widget image;
  final String headerText;
  final Widget descriptionCard;
}
