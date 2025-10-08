import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userKey = 'current_user';
  static const String _usersKey = 'all_users';

  static Future<void> saveUser(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userData);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> addUser(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_usersKey) ?? [];
    users.add(userData);
    await prefs.setStringList(_usersKey, users);
  }

  static Future<List<String>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_usersKey) ?? [];
  }
}
