import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getRemainderPreferences();
  }

  bool _isRemainderActive = false;
  bool get isRemainderActive => _isRemainderActive;

  void _getRemainderPreferences() async {
    _isRemainderActive = await preferencesHelper.isRemainderActive;
    notifyListeners();
  }

  void enableDailyRemainder(bool value) {
    preferencesHelper.setDailyRemainder(value);
    _getRemainderPreferences();
  }
}
