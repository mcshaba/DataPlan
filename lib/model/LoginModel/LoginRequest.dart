// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfcare/util/validator.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login extends Equatable{
  String username;
  String password;

  bool isFormField() {
    if (username.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPasswordValid() {
    return Validators.isPasswordValid(password);
  }

  bool isUsernameValid() {
    return Validators.isUsernameValid(username);
  }

  Login({
    @required this.username,
    @required this.password,
  }): super([username, password]);

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  @override
  String toString() {
    return super.toString();
  }
}
