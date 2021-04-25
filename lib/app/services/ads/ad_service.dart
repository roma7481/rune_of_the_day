import 'dart:io';

// String testInterestialAppId = 'ca-app-pub-3940256099942544/4411468910';
String realInterestialAppId = 'ca-app-pub-1763151471947181/1800598808';

// String testNativeAppId = 'ca-app-pub-3940256099942544/3986624511';
const String realNativeAppId = 'ca-app-pub-1763151471947181/8366007157';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return realNativeAppId;
    } else if (Platform.isIOS) {
      return realNativeAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return realInterestialAppId;
    } else if (Platform.isIOS) {
      return realInterestialAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
