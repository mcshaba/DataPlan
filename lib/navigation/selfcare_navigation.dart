import 'package:flutter/material.dart';

class SelfCareNavigator {
  static void gotToHome(BuildContext context){
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToLogin(BuildContext context){
    Navigator.pushReplacementNamed(context, "/login");
  }
}