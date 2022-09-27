
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_service.dart';

class NativeAdItem extends StatelessWidget {
  const NativeAdItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NativeAd nativeAd = AdManager.getNativeAd();
    if (nativeAd == null) {
      return Container();
    }
    return AspectRatio(aspectRatio: 2.6, child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
      child: Container(
          padding: const EdgeInsets.all(8.0),
          child: AdWidget(ad: nativeAd)),
    ));
  }
}
