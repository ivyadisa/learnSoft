import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyLoginTime = 'login_time';
  static const String _keyFirstLogin = 'first_login';
  static const int sessionDurationMinutes = 1; 

  Future<void> saveLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLoginTime, DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> isSessionExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loginTime = prefs.getInt(_keyLoginTime);
    if (loginTime == null) {
      return true;
    }
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int elapsedTime = currentTime - loginTime;
    return elapsedTime > sessionDurationMinutes * 60 * 1000;
  }

  Future<void> setFirstLogin(bool isFirstLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLogin, isFirstLogin);
  }

  Future<bool> isFirstLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstLogin) ?? true;
  }

  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoginTime);
    await prefs.remove(_keyFirstLogin);
  }

  Future<void> updateLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLoginTime, DateTime.now().millisecondsSinceEpoch);
  }
}
