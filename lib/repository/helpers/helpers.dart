import 'package:firebase_todo/view/app_view/add_task_view.dart';
import 'package:firebase_todo/view/app_view/edit_task_view.dart';
import 'package:firebase_todo/view/app_view/task_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  //shared key init
  static String loggedKey = "LOGGEDKEY";
  static String nameKey = "NAMEKEY";
  static String surnameKey = "SURNAMEKEY";
  static String emailKey = "LOGINKEY";

  //save data
  static Future saveIsLoggedSharedPreferences(bool isLogged) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loggedKey, isLogged);
  }

  static Future saveNameSharedPreferences(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(nameKey, name);
  }

  static Future saveSurnameSharedPreferences(String surname) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(surnameKey, surname);
  }

  static Future saveEmailSharedPreferences(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(emailKey, email);
  }

  //get data
  static Future getIsLoggedSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedKey);
  }

  static Future getNameSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey);
  }

  static Future getSurnameSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(surnameKey);
  }

  static Future getEmailSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  //remove data
  static Future removeIsLoggedSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(loggedKey);
  }

  static Future removeNameSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(nameKey);
  }

  static Future removeSurnameSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(surnameKey);
  }

  static Future removeEmailSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(emailKey);
  }
}
