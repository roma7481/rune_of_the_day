import 'package:flutter/material.dart';

class CardImageWidget extends StatelessWidget {
  const CardImageWidget({Key? key, this.imageSizeRatio, this.imagePath})
      : super(key: key);

  final double? imageSizeRatio;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * imageSizeRatio!,
          child: IconButton(
            icon: Image.asset(imagePath!),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
