import 'dart:collection';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import 'ad_counter.dart';

// String testInterestialAppId = 'ca-app-pub-3940256099942544/4411468910';
String realInterestialAppId = 'ca-app-pub-1763151471947181/1800598808';

// String testNativeAppId = 'ca-app-pub-3940256099942544/3986624511';
const String realNativeAppId = 'ca-app-pub-1763151471947181/8366007157';

class AdManager {
  static int _loadNativeAdAttempts = 0;
  static final Queue<NativeAd> _admobAdQueue = Queue<NativeAd>();
  static NativeAd _admobNativeIntermediateAd;
  static int _loadInterstitialAttempts = 0;
  static bool _loaded = false;
  static InterstitialAd _admobInterstitialAd;

  static String get nativeAdUnitId {
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

  static setup() async {
    await MobileAds.instance.initialize();
    MobileAds.instance.setAppVolume(0);
    MobileAds.instance.setAppMuted(true);
    _loadInterstitial();
    await _loadNativeAd();
  }

  static _loadInterstitial() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _admobInterstitialAd = ad;
            _loaded = true;
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _loaded = false;
              _loadInterstitial();
            }, onAdFailedToShowFullScreenContent:
                    (InterstitialAd ad, AdError error) {
              ad.dispose();
              _loaded = false;
              _loadInterstitial();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            _loadInterstitialAttempts++;
            if (_loadInterstitialAttempts < 3) {
              _loadInterstitial();
            }
          },
        ));
  }

  static NativeAd getNativeAd() {
    if (_admobAdQueue.isNotEmpty) {
      _loadNativeAd();
      final ad = _admobAdQueue.first;
      _admobAdQueue.removeFirst();
      return ad;
    }
    return null;
  }

  static _loadNativeAd() async {
    if (_admobNativeIntermediateAd != null) return;
    _admobNativeIntermediateAd = NativeAd(
      adUnitId: nativeAdUnitId,
      factoryId: 'healingAdFactory',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _admobAdQueue.add(_admobNativeIntermediateAd);
          _admobNativeIntermediateAd = null;
          if (_admobAdQueue.length < 5) {
            _loadNativeAd();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _loadNativeAdAttempts++;
          if (_loadNativeAdAttempts < 3) {
            _admobNativeIntermediateAd?.load();
          }
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    );
    await _admobNativeIntermediateAd?.load();
  }

  static showInterstitial() async {
    var isPremium = await PremiumController.instance.isPremium();
    if (!isPremium) {
      _showInterstitial();
    }
  }

  static _showInterstitial() async {
    var adCount = await AdsCounter.instance.getAdsCounter();

    if (adCount >= AdsCounter.maxNumClicks) {
      if (_loaded) {
        _admobInterstitialAd?.show();
        await AdsCounter.instance.resetAdCounter();
      }
    } else {
      await AdsCounter.instance.increaseAdCounter();
    }
  }
}
