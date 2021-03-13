import 'package:shared_preferences/shared_preferences.dart';

final String _key = 'ads_counter';
final int _initValue = 0;

class AdsCounter {
  AdsCounter._();

  static final instance = AdsCounter._();

  Future<int> getAdsCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getInt(_key);
    if (value == null) {
      prefs.setInt(_key, _initValue);
      return _initValue;
    }
    return value;
  }

  Future<void> increaseAdCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _value = prefs.getInt(_key);
    _value = _value == null ? _initValue : _value;
    prefs.setInt(_key, _value + 1);
  }

  Future<void> resetAdCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, _initValue);
  }
}
