import 'package:shared_preferences/shared_preferences.dart';

final String _keysKey = 'list_key';

class SharedPref {
  List<String> _keys = [];
  int _index = 0;

  SharedPref._();

  static final instance = SharedPref._();

  Future initKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keys = prefs.getString(_keysKey);
    this._keys = [];
    keys != null ? this._keys.addAll(keys.split(',')) : this._keys = [];
    _index = _keys.length - 1;
  }

  storeValue({String key, int value}) async {
    if (_keys.contains(key)) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _keys.add(key);
    _index = _keys.length - 1;
    prefs.setInt(key, value);

    var _keyList = prefs.getString(_keysKey);

    _keyList == null
        ? prefs.setString(_keysKey, key)
        : prefs.setString(_keysKey, _keyList + "," + key);
  }

  Future<int> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<List> getValueByIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String key = _keys[index];
    int value = prefs.getInt(key);

    return [key, value];
  }

  Future<List> getPrevKeyValue() async {
    _index = _index - 1;

    List keyValue = await getValueByIndex(_index);
    return [keyValue[0], keyValue[1]];
  }

  Future<List> getPrevKeyValueForClosedCard() async {
    List keyValue = await getValueByIndex(_index);
    return [keyValue[0], keyValue[1]];
  }

  Future<List> getNextKeyValue() async {
    if (!_validIndex()) {
      return [null, null];
    }

    _index = _index + 1;

    List keyValue = await getValueByIndex(_index);
    return [keyValue[0], keyValue[1]];
  }

  bool _validIndex() => _index + 1 <= _keys.length - 1;

  int getNumKeys() {
    return _keys.length;
  }

  int getIndexValue() {
    return _index;
  }
}
