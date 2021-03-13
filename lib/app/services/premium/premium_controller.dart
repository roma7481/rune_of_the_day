import 'package:shared_preferences/shared_preferences.dart';

final String _key = 'is_premium';

class PremiumController {
  PremiumController._();

  static final instance = PremiumController._();

  Future<void> enablePremium() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, true);
  }

  Future<void> disablePremium() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, false);
  }

  Future<bool> isPremium() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _isPremium = prefs.getBool(_key);
    return _isPremium == null ? false : _isPremium;
  }
}
