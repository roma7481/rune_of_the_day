import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';
import 'package:rune_of_the_day/app/presentation/pages/settings/settings_with_icon.dart';

import 'open_link.dart';

Widget buildMoreApps(String iconPath, String url, String appName) {
  var customIcon = ClipRRect(
    borderRadius: BorderRadius.circular(4.0),
    child: Container(
      height: 30,
      child: Image.asset(iconPath),
    ),
  );

  return Padding(
    padding:
        const EdgeInsets.only(left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSettingWithIcon(
              () => openLink(url),
              customIcon,
              appName,
            ),
            _buildAd(),
          ],
        ),
      ],
    ),
  );
}

ClipRRect _buildAd() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(4.0),
    child: Container(
      color: cardUrlLinkColor,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          'Ad',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
