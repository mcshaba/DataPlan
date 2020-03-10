// To parse this JSON data, do
//
//     final forgotModel = forgotModelFromJson(jsonString);

import 'dart:convert';

ForgotModel forgotModelFromJson(String str) => ForgotModel.fromJson(json.decode(str));

String forgotModelToJson(ForgotModel data) => json.encode(data.toJson());

class ForgotModel {
  String userName;

  ForgotModel({
    this.userName,
  });

  factory ForgotModel.fromJson(Map<String, dynamic> json) => ForgotModel(
    userName: json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
  };
}
