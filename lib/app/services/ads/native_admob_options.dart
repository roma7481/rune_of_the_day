import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/colours.dart';

class NativeTextStyle {
  final double fontSize;
  final Color color;
  final Color backgroundColor;
  final bool isVisible;

  const NativeTextStyle({
    this.fontSize,
    this.color,
    this.backgroundColor,
    this.isVisible = true,
  });

  Map<String, dynamic> toJson() => {
        "backgroundColor": backgroundColor != null
            ? "#${backgroundColor.value.toRadixString(16)}"
            : null,
        "fontSize": fontSize,
        "color": color != null ? "#${color.value.toRadixString(16)}" : null,
        "isVisible": isVisible,
      };
}

class NativeAdmobOptions {
  final bool showMediaContent;
  final Color ratingColor;
  final Color backgroundColor;
  final NativeTextStyle adLabelTextStyle;
  final NativeTextStyle headlineTextStyle;
  final NativeTextStyle advertiserTextStyle;
  final NativeTextStyle bodyTextStyle;
  final NativeTextStyle storeTextStyle;
  final NativeTextStyle priceTextStyle;
  final NativeTextStyle callToActionStyle;

  const NativeAdmobOptions({
    this.showMediaContent = true,
    this.ratingColor = adBackground,
    this.backgroundColor,
    this.adLabelTextStyle = const NativeTextStyle(
      fontSize: 12,
      color: adColor,
      backgroundColor: adBackground,
    ),
    this.headlineTextStyle = const NativeTextStyle(
      color: bodyTextAdmob,
    ),
    this.advertiserTextStyle = const NativeTextStyle(
      color: bodyTextAdmob,
    ),
    this.bodyTextStyle = const NativeTextStyle(
      color: bodyTextAdmob,
    ),
    this.storeTextStyle = const NativeTextStyle(
      color: bodyTextAdmob,
    ),
    this.priceTextStyle = const NativeTextStyle(
      color: bodyTextAdmob,
    ),
    this.callToActionStyle = const NativeTextStyle(
      color: Colors.black,
      backgroundColor: callToAction,
    ),
  });

  Map<String, dynamic> toJson() => {
        "showMediaContent": this.showMediaContent,
        "ratingColor": "#${ratingColor.value.toRadixString(16)}",
        "backgroundColor": backgroundColor != null
            ? "#${backgroundColor.value.toRadixString(16)}"
            : null,
        "adLabelTextStyle": adLabelTextStyle.toJson(),
        "headlineTextStyle": headlineTextStyle.toJson(),
        "advertiserTextStyle": advertiserTextStyle.toJson(),
        "bodyTextStyle": bodyTextStyle.toJson(),
        "storeTextStyle": storeTextStyle.toJson(),
        "priceTextStyle": priceTextStyle.toJson(),
        "callToActionStyle": callToActionStyle.toJson(),
      };
}
