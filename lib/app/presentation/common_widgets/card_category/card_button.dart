import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    Key key,
    this.image,
    this.onPressed,
  }) : super(key: key);

  final Widget image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
          child: IconButton(
            icon: image!,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
