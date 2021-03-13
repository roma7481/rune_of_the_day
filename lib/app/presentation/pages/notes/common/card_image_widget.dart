import 'package:flutter/material.dart';

class CardImageWidget extends StatelessWidget {
  const CardImageWidget({Key key, this.imageSizeRatio, this.imagePath})
      : super(key: key);

  final double imageSizeRatio;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: IconButton(
          icon: Image.asset(imagePath),
          iconSize: MediaQuery.of(context).size.height * imageSizeRatio,
          onPressed: () {},
        ),
      ),
    );
  }
}
