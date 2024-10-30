import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {

  static String userIdKey = "userIdKey";
  static String nameKey = "nameKey";
  static String emailKey = "emailKey";
  static String imageKey = "imageKey";

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(nameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(emailKey, getUserEmail);
  }

  Future<bool> saveUserImage(String getUserImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(imageKey, getUserImage);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(imageKey);
  }

  Future<bool> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(userIdKey);
  }

  Future<bool> removeUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(nameKey);
  }

  Future<bool> removeUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(emailKey);
  }

  Future<bool> removeUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(imageKey);
  }

}