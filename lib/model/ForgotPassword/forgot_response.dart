// To parse this JSON data, do
//
//     final forgotResponse = forgotResponseFromJson(jsonString);

import 'dart:convert';

ForgotResponse forgotResponseFromJson(String str) => ForgotResponse.fromJson(json.decode(str));

String forgotResponseToJson(ForgotResponse data) => json.encode(data.toJson());

class ForgotResponse {
  int status;
  String message;
  dynamic data;

  ForgotResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ForgotResponse.fromJson(Map<String, dynamic> json) => ForgotResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
