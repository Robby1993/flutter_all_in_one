import 'dart:async';
import 'package:all_in_one/utilities/my_share_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  bool _loginState = false;
  bool _initialized = false;
  bool _onboarding = false;
  bool _onprofile = false;

  AppService(this.sharedPreferences);

  bool get loginState => _loginState;

  bool get initialized => _initialized;

  bool get onboarding => _onboarding;

  bool get onProfile => _onprofile;

  set loginState(bool state) {
    sharedPreferences.setBool(MySharedPreferences.isLongedIn, state);
    _loginState = state;
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set onboarding(bool value) {
   // sharedPreferences.setBool(MySharedPreferences.isOnBoarding, value);
    _onboarding = value;
    notifyListeners();
  }

  void onLogout() {
    sharedPreferences.setBool(MySharedPreferences.isLongedIn, false);
    sharedPreferences.setBool(MySharedPreferences.isProfileUpdate, false);
   // sharedPreferences.setBool(MySharedPreferences.isOnBoarding, false);
    _loginState = false;
    _onprofile = false;
    _onboarding = false;
    notifyListeners();
  }

  set onProfile(bool value) {
    sharedPreferences.setBool(MySharedPreferences.isProfileUpdate, value);
    _onprofile = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _onboarding =
        sharedPreferences.getBool(MySharedPreferences.isOnBoarding) ?? false;
    _onprofile =
        sharedPreferences.getBool(MySharedPreferences.isProfileUpdate) ?? false;
    _loginState =
        sharedPreferences.getBool(MySharedPreferences.isLongedIn) ?? false;

    // This is just to demonstrate the splash screen is working.
    // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
    await Future.delayed(const Duration(seconds: 2));

    _initialized = true;
    notifyListeners();
  }
}
