import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/constants.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/csv_icon_widget.dart';

class NavigationButton extends StatelessWidget {
  final bool isEnabled;
  final String icon;
  final VoidCallback onClick;

  const NavigationButton({
    @required this.isEnabled,
    @required this.icon,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: isEnabled,
      child: IconButton(
        icon: buildIcon(icon, appBarIconsSize),
        onPressed: onClick,
      ),
    );
  }
}
