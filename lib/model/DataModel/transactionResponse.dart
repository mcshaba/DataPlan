// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  int status;
  String message;
  Data data;

  TransactionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
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
  int id;
  String portalCode;
  String transRef;
  int customerId;
  String customerDesc;
  String email;
  double value;
  String fullName;
  String session;
  String itemCode;
  String itemName;
  String phoneNumber;
  double amount;
  String redirectLink;
  int operatorId;
  int iCustomer;
  int iAccount;
  int iProduct;
  int providerId;
  String requestPayload;
  String transactionStatus;
  bool isSuccessful;
  int prospectId;
  bool allocateAll;
  String responsePayload;
  DateTime dateCreated;

  Data({
    this.id,
    this.portalCode,
    this.transRef,
    this.customerId,
    this.customerDesc,
    this.email,
    this.value,
    this.fullName,
    this.session,
    this.itemCode,
    this.itemName,
    this.phoneNumber,
    this.amount,
    this.redirectLink,
    this.operatorId,
    this.iCustomer,
    this.iAccount,
    this.iProduct,
    this.providerId,
    this.requestPayload,
    this.transactionStatus,
    this.isSuccessful,
    this.prospectId,
    this.allocateAll,
    this.responsePayload,
    this.dateCreated,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    portalCode: json["PortalCode"],
    transRef: json["TransRef"],
    customerId: json["CustomerID"],
    customerDesc: json["CustomerDesc"],
    email: json["Email"],
    value: json["Value"].toDouble(),
    fullName: json["FullName"],
    session: json["Session"],
    itemCode: json["ItemCode"],
    itemName: json["ItemName"],
    phoneNumber: json["PhoneNumber"],
    amount: json["amount"].toDouble(),
    redirectLink: json["RedirectLink"],
    operatorId: json["OperatorID"],
    iCustomer: json["i_customer"],
    iAccount: json["i_account"],
    iProduct: json["i_product"],
    providerId: json["provider_id"],
    requestPayload: json["Request_Payload"],
    transactionStatus: json["Transaction_status"],
    isSuccessful: json["IsSuccessful"],
    prospectId: json["ProspectID"],
    allocateAll: json["AllocateAll"],
    responsePayload: json["Response_Payload"],
//    dateCreated: DateTime.parse(json["DateCreated"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "PortalCode": portalCode,
    "TransRef": transRef,
    "CustomerID": customerId,
    "CustomerDesc": customerDesc,
    "Email": email,
    "Value": value,
    "FullName": fullName,
    "Session": session,
    "ItemCode": itemCode,
    "ItemName": itemName,
    "PhoneNumber": phoneNumber,
    "amount": amount,
    "RedirectLink": redirectLink,
    "OperatorID": operatorId,
    "i_customer": iCustomer,
    "i_account": iAccount,
    "i_product": iProduct,
    "provider_id": providerId,
    "Request_Payload": requestPayload,
    "Transaction_status": transactionStatus,
    "IsSuccessful": isSuccessful,
    "ProspectID": prospectId,
    "AllocateAll": allocateAll,
    "Response_Payload": responsePayload,
    "DateCreated": dateCreated.toIso8601String(),
  };
}
