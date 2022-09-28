import 'dart:collection';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/error_dialog.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import 'ad_counter.dart';

// String testInterestialAppId = 'ca-app-pub-3940256099942544/4411468910';
String realInterestialAppId = 'ca-app-pub-1763151471947181/1800598808';

// String testNativeAppId = 'ca-app-pub-3940256099942544/3986624511';
const String realNativeAppId = 'ca-app-pub-1763151471947181/8366007157';

String testBannerAppId = 'ca-app-pub-3940256099942544/6300978111';
const String realBannerAppId = 'ca-app-pub-1763151471947181/8811732192';

class AdManager {
  static int _loadNativeAdAttempts = 0;
  static final Queue<NativeAd> _admobAdQueue = Queue<NativeAd>();
  static NativeAd _admobNativeIntermediateAd;
  static int _loadInterstitialAttempts = 0;
  static bool _interLoaded = false;
  static bool _bannerLoaded = false;
  static Ad bannerAd;
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
      return realBannerAppId;
    } else if (Platform.isIOS) {
      return realBannerAppId;
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

  static setup() async {
    await MobileAds.instance.initialize();
    MobileAds.instance.setAppVolume(0);
    MobileAds.instance.setAppMuted(true);
    _loadInterstitial();
    _loadBanner();
    await _loadNativeAd();
  }

  static _loadInterstitial() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _admobInterstitialAd = ad;
            _interLoaded = true;
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interLoaded = false;
              _loadInterstitial();
            }, onAdFailedToShowFullScreenContent:
                    (InterstitialAd ad, AdError error) {
              ad.dispose();
              _interLoaded = false;
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
      if (_interLoaded) {
        _admobInterstitialAd?.show();
        await AdsCounter.instance.resetAdCounter();
      }
    } else {
      await AdsCounter.instance.increaseAdCounter();
    }
  }

  static _loadBanner() {
    try {
      BannerAd(
        adUnitId: AdManager.bannerAdUnitId,
        size: AdSize.fullBanner,
        request: AdRequest(),
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            _bannerLoaded = true;
            bannerAd = ad;
            debugPrint('Ad loaded.');
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            _bannerLoaded = false;
            _loadBanner();
            debugPrint('Ad failed to load: $error');
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) => print('Ad opened.'),
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {
            ad.dispose();
            _bannerLoaded = false;
            _loadBanner();
            debugPrint('Ad closed.');
          },
          // Called when an ad is in the process of leaving the application.
        ),
      )..load();
    } catch (e) {
      print('banner failed with error: $e');
      return null;
    }
  }

  static showBanner() {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SizedBox();
            default:
              if (snapshot.hasError) {
                return errorDialog();
              } else {
                var isPremium = snapshot.data;
                if (isPremium) {
                  return SizedBox();
                }
                if(_bannerLoaded && bannerAd != null){
                  return Container(
                    alignment: Alignment.center,
                    child: AdWidget(ad: bannerAd),
                    width: bannerAd == null ? 0 : AdSize.fullBanner.width.toDouble(),
                    height: bannerAd == null ? 0 : AdSize.fullBanner.height.toDouble(),
                  );
                }
                return SizedBox();
              }
          }
        });
  }
}
