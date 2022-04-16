import 'package:shared_preferences/shared_preferences.dart';

const String keyTheme = 'theme';
const String _token = 'token';
const String _firstTime = 'firstTime';
const String _sortType = 'sortType';

const String _skipAd = '_skipAd';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  bool get checkPrefsNull =>
      _sharedPrefs != null && _sharedPrefs!.containsKey(keyTheme);

  int get theme => _sharedPrefs?.getInt(keyTheme) ?? 0;

  String? get token => _sharedPrefs?.getString(_token);

  bool get isFirstTime => _sharedPrefs?.getBool(_firstTime) ?? true;

  bool get sortType => _sharedPrefs?.getBool(_firstTime) ?? false;

  bool get skipAd => _sharedPrefs?.getBool(_skipAd) ?? true;

  Future<void> setToken(String value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setString(_token, value);
    }
  }

  Future<void> setSkipAd(bool value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_skipAd, value);
    }
  }

  Future<void> setSortType(bool value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_sortType, value);
    }
  }

  Future<bool> deleteEverything() async {
    print('This runs -7');
    if (_sharedPrefs != null) {
      print('This runs -6');
      final result = await _sharedPrefs?.clear();
      return result ?? false;
    }
    return false;
  }

  Future<void> setFirstTime(bool value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setBool(_firstTime, value);
    }
  }

  //setTheme
  // We can access this as await SharedPrefs().setTheme(event.theme.index);
  Future<void> setTheme(int value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setInt(keyTheme, value);
    }
  }
}
