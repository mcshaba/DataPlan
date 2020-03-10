// To parse this JSON data, do
//
//     final activeSessionModel = activeSessionModelFromJson(jsonString);

import 'dart:convert';

ActiveSessionModel activeSessionModelFromJson(String str) => ActiveSessionModel.fromJson(json.decode(str));

String activeSessionModelToJson(ActiveSessionModel data) => json.encode(data.toJson());

class ActiveSessionModel {
  int iAccount;
  int iCustomer;

  ActiveSessionModel({
    this.iAccount,
    this.iCustomer,
  });

  factory ActiveSessionModel.fromJson(Map<String, dynamic> json) => ActiveSessionModel(
    iAccount: json["i_account"],
    iCustomer: json["i_customer"],
  );

  Map<String, dynamic> toJson() => {
    "i_account": iAccount,
    "i_customer": iCustomer,
  };
}
