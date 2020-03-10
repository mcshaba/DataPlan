// To parse this JSON data, do
//
//     final transactionRequest = transactionRequestFromJson(jsonString);

import 'dart:convert';

TransactionRequest transactionRequestFromJson(String str) => TransactionRequest.fromJson(json.decode(str));

String transactionRequestToJson(TransactionRequest data) => json.encode(data.toJson());

class TransactionRequest {
  double amount;
  String customerDesc;
  int customerId;
  String fullName;
  String email;
  String itemCode;
  String itemName;
  int iAccount;
  int iCustomer;
  int operatorId;
  double vat;
  int iProduct;
  String phoneNumber;
  String portalCode;
  int providerId;
  String session;
  double value;
  bool allocateAll;

  TransactionRequest({
    this.amount,
    this.customerDesc,
    this.customerId,
    this.fullName,
    this.email,
    this.itemCode,
    this.itemName,
    this.iAccount,
    this.vat,
    this.iCustomer,
    this.operatorId,
    this.iProduct,
    this.phoneNumber,
    this.portalCode,
    this.providerId,
    this.session,
    this.value,
    this.allocateAll,
  });

  factory TransactionRequest.fromJson(Map<String, dynamic> json) => TransactionRequest(
    amount: json["amount"].toDouble(),
    customerDesc: json["CustomerDesc"],
    customerId: json["CustomerID"],
    fullName: json["FullName"],
    email: json["Email"],
    itemCode: json["ItemCode"],
    itemName: json["ItemName"],
    iAccount: json["i_account"],
    iCustomer: json["i_customer"],
    operatorId: json["OperatorID"],
    vat: json["Vat"].toDouble(),
    iProduct: json["i_product"],
    phoneNumber: json["PhoneNumber"],
    portalCode: json["PortalCode"],
    providerId: json["provider_id"],
    session: json["Session"],
    value: json["Value"].toDouble(),
    allocateAll: json["AllocateAll"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "CustomerDesc": customerDesc,
    "CustomerID": customerId,
    "FullName": fullName,
    "Email": email,
    "ItemCode": itemCode,
    "ItemName": itemName,
    "i_account": iAccount,
    "i_customer": iCustomer,
    "OperatorID": operatorId,
    "Vat": vat,
    "i_product": iProduct,
    "PhoneNumber": phoneNumber,
    "PortalCode": portalCode,
    "provider_id": providerId,
    "Session": session,
    "Value": value,
    "AllocateAll": allocateAll,
  };
}
