import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/constants/styles/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    required this.children,
    this.actions = const [],
  });

  final List<Widget> children;
  final List<Widget> actions;

  AppBar build(BuildContext context) {
    return AppBar(
      iconTheme: appBarIconStyle,
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: appBarColor,
      actions: actions,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ), systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
