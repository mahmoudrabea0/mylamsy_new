import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("userName");
    return datId;
  }

  static Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("userId");
    return datId;
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("emailPref");
    return datId;
  }

  static Future<String> getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("passwordPref");
    return datId;
  }

  static Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("userPhone");
    print(datId);
    return datId;
  }


  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("token");
    return datId;
  }
  static Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("id");
    return datId;
  }
}
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);