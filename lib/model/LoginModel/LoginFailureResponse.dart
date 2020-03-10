// To parse this JSON data, do
//
//     final loginFailureResponse = loginFailureResponseFromJson(jsonString);

import 'dart:convert';

LoginFailureResponse loginFailureResponseFromJson(String str) => LoginFailureResponse.fromJson(json.decode(str));

String loginFailureResponseToJson(LoginFailureResponse data) => json.encode(data.toJson());

class LoginFailureResponse {
  int status;
  String message;
  Data data;

  LoginFailureResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginFailureResponse.fromJson(Map<String, dynamic> json) => LoginFailureResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String userName;
  String password;
  bool rememberMe;

  Data({
    this.userName,
    this.password,
    this.rememberMe,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userName: json["UserName"],
    password: json["Password"],
    rememberMe: json["RememberMe"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "Password": password,
    "RememberMe": rememberMe,
  };
}
