// To parse this JSON data, do
//
//     final completeTransactionResponse = completeTransactionResponseFromJson(jsonString);

import 'dart:convert';

CompleteTransactionResponse completeTransactionResponseFromJson(String str) => CompleteTransactionResponse.fromJson(json.decode(str));

String completeTransactionResponseToJson(CompleteTransactionResponse data) => json.encode(data.toJson());

class CompleteTransactionResponse {
  bool status;
  String message;
  Data data;

  CompleteTransactionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CompleteTransactionResponse.fromJson(Map<String, dynamic> json) => CompleteTransactionResponse(
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
  dynamic description;
  dynamic portaOneReference;
  dynamic source;
  dynamic creator;
  dynamic customer;
  dynamic allocationCustomer;
  dynamic paymentAccount;
  dynamic allocationAccount;
  double amount;
  dynamic creditedAmount;
  double oldBalance;
  dynamic actualPaymentReceiptNumber;
  dynamic receiptNumber;
  String transactionReference;
  dynamic portaOneActionType;
  dynamic product;
  dynamic expirationExtension;
  dynamic oldBalanceExtension;
  dynamic isEmailSent;
  dynamic isSmsSent;
  Discount discount;
  dynamic promotions;
  int paymentType;
  dynamic isReversal;
  dynamic noofDays;
  dynamic accessories;
  dynamic additionalAmount;
  dynamic allocateAll;
  dynamic location;
  dynamic category;
  dynamic mdrmnRefNo;
  dynamic origin;
  dynamic paymentId;
  dynamic exactAmount;
  dynamic deviceCommission;
  dynamic activationCommission;
  int gateway;
  dynamic outlet;
  dynamic navUpdateStatus;
  dynamic providers;
  dynamic periods;
  dynamic productList;
  dynamic modemList;
  dynamic createdBy;
  dynamic userPassword;
  dynamic password;
  DateTime createdDate;
  dynamic dealerUserId;
  dynamic dealerId;
  dynamic loginDealer;
  dynamic logActivity;
  String errorMessage;
  int requestFrom;
  dynamic userIpAddress;
  dynamic noEfTracked;

  Data({
    this.description,
    this.portaOneReference,
    this.source,
    this.creator,
    this.customer,
    this.allocationCustomer,
    this.paymentAccount,
    this.allocationAccount,
    this.amount,
    this.creditedAmount,
    this.oldBalance,
    this.actualPaymentReceiptNumber,
    this.receiptNumber,
    this.transactionReference,
    this.portaOneActionType,
    this.product,
    this.expirationExtension,
    this.oldBalanceExtension,
    this.isEmailSent,
    this.isSmsSent,
    this.discount,
    this.promotions,
    this.paymentType,
    this.isReversal,
    this.noofDays,
    this.accessories,
    this.additionalAmount,
    this.allocateAll,
    this.location,
    this.category,
    this.mdrmnRefNo,
    this.origin,
    this.paymentId,
    this.exactAmount,
    this.deviceCommission,
    this.activationCommission,
    this.gateway,
    this.outlet,
    this.navUpdateStatus,
    this.providers,
    this.periods,
    this.productList,
    this.modemList,
    this.createdBy,
    this.userPassword,
    this.password,
    this.createdDate,
    this.dealerUserId,
    this.dealerId,
    this.loginDealer,
    this.logActivity,
    this.errorMessage,
    this.requestFrom,
    this.userIpAddress,
    this.noEfTracked,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    description: json["Description"],
    portaOneReference: json["PortaOneReference"],
    source: json["Source"],
    creator: json["Creator"],
    customer: json["Customer"],
    allocationCustomer: json["AllocationCustomer"],
    paymentAccount: json["PaymentAccount"],
    allocationAccount: json["AllocationAccount"],
    amount: json["Amount"].toDouble(),
    creditedAmount: json["CreditedAmount"],
    oldBalance: json["OldBalance"].toDouble(),
    actualPaymentReceiptNumber: json["ActualPaymentReceiptNumber"],
    receiptNumber: json["ReceiptNumber"],
    transactionReference: json["TransactionReference"],
    portaOneActionType: json["PortaOneActionType"],
    product: json["Product"],
    expirationExtension: json["ExpirationExtension"],
    oldBalanceExtension: json["OldBalanceExtension"],
    isEmailSent: json["IsEmailSent"],
    isSmsSent: json["IsSMSSent"],
    discount: Discount.fromJson(json["Discount"]),
    promotions: json["Promotions"],
    paymentType: json["PaymentType"],
    isReversal: json["IsReversal"],
    noofDays: json["NoofDays"],
    accessories: json["Accessories"],
    additionalAmount: json["AdditionalAmount"],
    allocateAll: json["AllocateAll"],
    location: json["Location"],
    category: json["Category"],
    mdrmnRefNo: json["MDRMNRefNo"],
    origin: json["Origin"],
    paymentId: json["PaymentID"],
    exactAmount: json["ExactAmount"],
    deviceCommission: json["DeviceCommission"],
    activationCommission: json["ActivationCommission"],
    gateway: json["Gateway"],
    outlet: json["Outlet"],
    navUpdateStatus: json["NAVUpdateStatus"],
    providers: json["Providers"],
    periods: json["Periods"],
    productList: json["ProductList"],
    modemList: json["ModemList"],
    createdBy: json["CreatedBy"],
    userPassword: json["UserPassword"],
    password: json["Password"],
//    createdDate: DateTime.parse(json["CreatedDate"]),
    dealerUserId: json["DealerUserID"],
    dealerId: json["DealerID"],
    loginDealer: json["LoginDealer"],
    logActivity: json["LogActivity"],
    errorMessage: json["ErrorMessage"],
    requestFrom: json["RequestFrom"],
    userIpAddress: json["UserIPAddress"],
    noEfTracked: json["NoEFTracked"],
  );

  Map<String, dynamic> toJson() => {
    "Description": description,
    "PortaOneReference": portaOneReference,
    "Source": source,
    "Creator": creator,
    "Customer": customer,
    "AllocationCustomer": allocationCustomer,
    "PaymentAccount": paymentAccount,
    "AllocationAccount": allocationAccount,
    "Amount": amount,
    "CreditedAmount": creditedAmount,
    "OldBalance": oldBalance,
    "ActualPaymentReceiptNumber": actualPaymentReceiptNumber,
    "ReceiptNumber": receiptNumber,
    "TransactionReference": transactionReference,
    "PortaOneActionType": portaOneActionType,
    "Product": product,
    "ExpirationExtension": expirationExtension,
    "OldBalanceExtension": oldBalanceExtension,
    "IsEmailSent": isEmailSent,
    "IsSMSSent": isSmsSent,
    "Discount": discount.toJson(),
    "Promotions": promotions,
    "PaymentType": paymentType,
    "IsReversal": isReversal,
    "NoofDays": noofDays,
    "Accessories": accessories,
    "AdditionalAmount": additionalAmount,
    "AllocateAll": allocateAll,
    "Location": location,
    "Category": category,
    "MDRMNRefNo": mdrmnRefNo,
    "Origin": origin,
    "PaymentID": paymentId,
    "ExactAmount": exactAmount,
    "DeviceCommission": deviceCommission,
    "ActivationCommission": activationCommission,
    "Gateway": gateway,
    "Outlet": outlet,
    "NAVUpdateStatus": navUpdateStatus,
    "Providers": providers,
    "Periods": periods,
    "ProductList": productList,
    "ModemList": modemList,
    "CreatedBy": createdBy,
    "UserPassword": userPassword,
    "Password": password,
    "CreatedDate": createdDate.toIso8601String(),
    "DealerUserID": dealerUserId,
    "DealerID": dealerId,
    "LoginDealer": loginDealer,
    "LogActivity": logActivity,
    "ErrorMessage": errorMessage,
    "RequestFrom": requestFrom,
    "UserIPAddress": userIpAddress,
    "NoEFTracked": noEfTracked,
  };
}

class Discount {
  int id;
  dynamic category;
  int type;
  double value;

  Discount({
    this.id,
    this.category,
    this.type,
    this.value,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["ID"],
    category: json["Category"],
    type: json["Type"],
    value: json["Value"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Category": category,
    "Type": type,
    "Value": value,
  };
}
