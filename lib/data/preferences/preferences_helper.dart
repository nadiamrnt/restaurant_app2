import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const DAILY_REMAINDER = 'DAILY_REMAINDER';

  Future<bool> get isRemainderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_REMAINDER) ?? false;
  }

  void setDailyRemainder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_REMAINDER, value);
  }
}
