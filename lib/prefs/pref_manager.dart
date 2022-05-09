import 'package:testing_base_stateful/prefs/pref_keys.dart';
import 'package:testing_base_stateful/prefs/pref_util.dart';

class PrefManager {
  static Future<bool> setLang(String data) async {
    return await PrefUtils.setString(PrefKeys.LANG, data);
  }

  static Future<String?> getLang() async {
    return await PrefUtils.getString(PrefKeys.LANG);
  }

  static Future<void> setLoggedIn() async {
    await PrefUtils.setBool(PrefKeys.IS_LOGGED_IN, true);
  }

  static Future<bool> isLoggedIn() async {
    return await PrefUtils.getBool(PrefKeys.IS_LOGGED_IN);
  }

  static Future<void> setToken(String data) async {
    await PrefUtils.setString(PrefKeys.TOKEN, data);
  }

  static Future<String?> getToken() async {
    return await PrefUtils.getString(PrefKeys.TOKEN);
  }

  static Future<void> setFirebaseToken(String data) async {
    await PrefUtils.setString(PrefKeys.FIREBASE_TOKEN, data);
  }

  static Future<String?> getFirebaseToken() async {
    return await PrefUtils.getString(PrefKeys.FIREBASE_TOKEN);
  }

  static Future<void> setName(String data) async {
    await PrefUtils.setString(PrefKeys.NAME, data);
  }

  static Future<String?> getName() async {
    return await PrefUtils.getString(PrefKeys.NAME);
  }

  static Future<void> setEmail(String data) async {
    await PrefUtils.setString(PrefKeys.EMAIL, data);
  }

  static Future<String?> getEmail() async {
    return await PrefUtils.getString(PrefKeys.EMAIL);
  }

  static Future<void> setRole(String data) async {
    await PrefUtils.setString(PrefKeys.ROLE, data);
  }

  static Future<String?> getRole() async {
    return await PrefUtils.getString(PrefKeys.ROLE);
  }

  static Future<void> setId(String data) async {
    await PrefUtils.setString(PrefKeys.ID, data);
  }

  static Future<String> getId() async {
    return (await PrefUtils.getString(PrefKeys.ID))!;
  }

  static Future<void> setCanCreateInAnyDepartment(bool data) async {
    await PrefUtils.setBool(PrefKeys.CAN_CREATE_IN_ANY_DEPARTMENT, data);
  }

  static Future<bool> getCanCreateInAnyDepartment() async {
    return (await PrefUtils.getBool(PrefKeys.CAN_CREATE_IN_ANY_DEPARTMENT));
  }

  static Future<void> setUser(
      String name,
      String email,
      String token,
      String role,
      String id,
      String firebaseToken,
      bool canCreateInAnyDepartment) async {
    await setName(name);
    await setEmail(email);
    await setToken(token);
    await setRole(role);
    await setId(id);
    await setFirebaseToken(firebaseToken);
    await setCanCreateInAnyDepartment(canCreateInAnyDepartment);
  }

  static Future<bool> isFirebaseToken(String? firebaseToken) async {
    String? token = await getFirebaseToken();
    return token == firebaseToken;
  }

  static Future<void> clearAllData() async {
    await PrefUtils.clearData();
  }
}
