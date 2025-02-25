import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  Future<void> saveUserData(String username, int accountId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setInt('account_id', accountId);
  }

  Future<Map<String, String>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final int? accountId = prefs.getInt('account_id');

    if (username != null && accountId != null) {
      return {'username': username, 'account_id': accountId.toString()};
    }
    return null;
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
