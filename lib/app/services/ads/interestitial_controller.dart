import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rune_of_the_day/app/services/premium/premium_controller.dart';

import 'ad_counter.dart';
import 'ad_service.dart';

class InterestitialController {
  InterestitialController._();

  static final instance = InterestitialController._();

  static final premiumController = PremiumController.instance;

  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  Function() _callback;
  bool isPersonalized = false;

  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  Future<void> showInterstitialAd() async {
    _loadPage(_callback);

    bool isPremium = await premiumController.isPremium();
    if (!isPremium) {
      var adCounter = await AdsCounter.instance.getAdsCounter();
      if (adCounter > 5 && _isInterstitialAdReady) {
        _interstitialAd.show();
        AdsCounter.instance.resetAdCounter();
      }
    }
  }

  void setCallback(Function() callback) {
    this._callback = callback;
  }

  void _loadPage(void Function() callback) {
    callback();
  }

  void setInter() {
    AdRequest request = AdRequest(
      keywords: <String>[
        'Online shopping',
        'clothes online',
        'Entertainment',
        'free streaming',
        'cooking',
        'recipes',
        'astrology',
        'tarot',
        'psychic reading',
        'pharmacy',
        'cosmetics',
        'baby',
      ],
      // contentUrl: 'http://foo.com/bar.html',
      nonPersonalizedAds: isPersonalized,
    );

    _interstitialAd = InterstitialAd(
      request: request,
      adUnitId: AdManager.interstitialAdUnitId,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          _isInterstitialAdReady = false;
          setInter();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          _interstitialAd = null;
          _isInterstitialAdReady = false;
          setInter();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    );
    _loadInterstitialAd();
  }
}
