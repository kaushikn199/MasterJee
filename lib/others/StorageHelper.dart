import 'dart:convert';

import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/login/login_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {

  // Access keys safely
  static const String userIdKey = 'USER_ID';
  static const String userKey = 'USER_DATA';
  static const String classListKey = 'CLASS_DATA';
  static const String classIdKey = 'CLASS_ID';
  static const String sectionIdKey = 'SECTION_ID';
  static const String selectedClassDataKey = 'SELECTED_CLASS_DATA';
  static const String selectedSectionDataKey = 'SELECTED_SECTION_DATA';
  static late SharedPreferences _prefs;

  // Init - must be called before using any StorageHelper function
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save UserData object
  static Future<void> saveUserData(UserData user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(userKey, userJson);
    await _prefs.setString(userIdKey, user.userId!);
  }

  // Get UserData object
  static Future<UserData?> getUserData() async {
    final userJson = _prefs.getString(userKey);
    if (userJson == null) return null;

    try {
      final Map<String, dynamic> data = jsonDecode(userJson);
      return UserData.fromJson(data);
    } catch (e) {
      print("Error decoding user data: $e");
      return null;
    }
  }

  // Get saved userId directly
  static getStringData(String key)  {
    return _prefs.getString(key);
  }

  static setStringData(String key,String value)  {
    return _prefs.setString(key,value);
  }

  // Clear user data (on logout)
  static Future<void> clearUserData() async {
    await _prefs.remove(userKey);
  }

  // Optional: check if user is logged in
  static Future<bool> isLoggedIn() async {
    return _prefs.containsKey(userKey);
  }

  // Save list to preferences
  static Future<void> saveClassList(List<ClassData> users) async {
    List<String> jsonList =
        users.map((user) => jsonEncode(user.toJson())).toList();
    await _prefs.setStringList(classListKey, jsonList);
  }

  // Get list from preferences
  static Future<List<ClassData>> getClassList() async {
    List<String>? jsonList = _prefs.getStringList(classListKey);
    if (jsonList == null) return [];
    return jsonList
        .map((item) => ClassData.fromJson(jsonDecode(item)))
        .toList();
  }

  static Future<ClassData?> saveSelectedClass(ClassData users) async {
    final userJson = jsonEncode(users.toJson());
    await _prefs.setString(selectedClassDataKey, userJson);
  }

  static Future<ClassData?> getSelectedClass() async {
    final userJson = _prefs.getString(selectedClassDataKey);
    if (userJson == null) return null;
    try {
      final Map<String, dynamic> data = jsonDecode(userJson);
      return ClassData.fromJson(data);
    } catch (e) {
      print("Error decoding user data: $e");
      return null;
    }
  }


  static Future<SectionData?> saveSelectedSectionData(SectionData users) async {
    final userJson = jsonEncode(users.toJson());
    await _prefs.setString(selectedSectionDataKey, userJson);
  }

  static Future<SectionData?> getSelectedSection() async {
    final userJson = _prefs.getString(selectedSectionDataKey);
    if (userJson == null) return null;
    try {
      final Map<String, dynamic> data = jsonDecode(userJson);
      return SectionData.fromJson(data);
    } catch (e) {
      print("Error decoding user data: $e");
      return null;
    }
  }
}
