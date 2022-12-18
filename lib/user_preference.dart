import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{
  static SharedPreferences? _preferences;
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static const _userToken = 'userTokenId';
  static const _userId = "userId";
  static const _userName = "username";

  static Future setUserToken(String userTokenId) async => await _preferences!.setString(_userToken, userTokenId);
  static String? getUserToken() => _preferences!.getString(_userToken);

  static Future setUserId(String userId) async => await _preferences!.setString(_userId, userId);
  static String? getUserId() => _preferences!.getString(_userId);

  static Future setUserName(String username) async => await _preferences!.setString(_userName, username);
  static String? getUserName() => _preferences!.getString(_userName);
}