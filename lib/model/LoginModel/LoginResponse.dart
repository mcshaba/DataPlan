// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse extends Equatable{
  int status;
  String message;
  Data data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
  String accessToken;
  User user;
  List<Account> accounts;

  Data({
    this.accessToken,
    this.user,
    this.accounts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    user: User.fromJson(json["user"]),
    accounts: List<Account>.from(json["accounts"].map((x) => Account.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user": user.toJson(),
    "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
  };
}

class Account {
  int voipClientType;
  int iCustomer;
  Customer customer;
  int iAccount;
  dynamic iMasterAccount;
  String id;
  dynamic accountName;
  double openingBalance;
  String servicePassword;
  int type;
  DateTime issueDate;
  DateTime activationDate;
  DateTime expirationDate;
  dynamic firstUsage;
  DateTime lastUsage;
  dynamic lastRecharge;
  int lifeTime;
  Product product;
  int block;
  int billStatus;
  Subscriber subscriber;
  dynamic ipDevice;
  dynamic aliases;
  dynamic creditLimit;
  ServiceType serviceType;
  double balance;
  dynamic staticIp;
  int isPoc;
  dynamic ipMask;
  dynamic imsi;
  PortaoneAccountCredential portaoneAccountCredential;
  dynamic usageDetails;
  int accountState;
  dynamic allocation;
  double dataVolume;
  int operatorCode;
  dynamic postPaid;
  dynamic resetPattern;
  dynamic postPaidReset;
  dynamic accountOfficer;
  dynamic lastNotificationPattern;
  dynamic discount;
  dynamic lastAutoRenewalDate;
  int loanCount;
  dynamic resumeOnline;
  dynamic actualValue;
  dynamic downloadType;
  dynamic batchName;
  int downloadMilestone;
  dynamic intendedProduct;
  int iAccountRole;
  dynamic activeCalls;
  dynamic autoRenewalProduct;
  dynamic staffNo;
  bool isOnline;
  int idClient;
  dynamic username;
  dynamic newCustomerId;
  dynamic newName;
  dynamic newAccountLogging;
  bool newPostpaidAccountReset;
  dynamic newAccountId;
  dynamic createdBy;
  dynamic userPassword;
  String password;
  DateTime createdDate;
  dynamic dealerUserId;
  dynamic dealerId;
  dynamic loginDealer;
  dynamic logActivity;
  dynamic errorMessage;
  int requestFrom;
  dynamic userIpAddress;
  dynamic noEfTracked;

  Account({
    this.voipClientType,
    this.iCustomer,
    this.customer,
    this.iAccount,
    this.iMasterAccount,
    this.id,
    this.accountName,
    this.openingBalance,
    this.servicePassword,
    this.type,
    this.issueDate,
    this.activationDate,
    this.expirationDate,
    this.firstUsage,
    this.lastUsage,
    this.lastRecharge,
    this.lifeTime,
    this.product,
    this.block,
    this.billStatus,
    this.subscriber,
    this.ipDevice,
    this.aliases,
    this.creditLimit,
    this.serviceType,
    this.balance,
    this.staticIp,
    this.isPoc,
    this.ipMask,
    this.imsi,
    this.portaoneAccountCredential,
    this.usageDetails,
    this.accountState,
    this.allocation,
    this.dataVolume,
    this.operatorCode,
    this.postPaid,
    this.resetPattern,
    this.postPaidReset,
    this.accountOfficer,
    this.lastNotificationPattern,
    this.discount,
    this.lastAutoRenewalDate,
    this.loanCount,
    this.resumeOnline,
    this.actualValue,
    this.downloadType,
    this.batchName,
    this.downloadMilestone,
    this.intendedProduct,
    this.iAccountRole,
    this.activeCalls,
    this.autoRenewalProduct,
    this.staffNo,
    this.isOnline,
    this.idClient,
    this.username,
    this.newCustomerId,
    this.newName,
    this.newAccountLogging,
    this.newPostpaidAccountReset,
    this.newAccountId,
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

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    voipClientType: json["voip_client_type"],
    iCustomer: json["i_customer"],
    customer: Customer.fromJson(json["Customer"]),
    iAccount: json["i_account"],
    iMasterAccount: json["i_master_account"],
    id: json["ID"],
    accountName: json["AccountName"],
    openingBalance: json["OpeningBalance"].toDouble(),
    servicePassword: json["ServicePassword"] == null ? null : json["ServicePassword"],
    type: json["Type"],
    issueDate: DateTime.parse(json["IssueDate"]),
    activationDate: DateTime.parse(json["ActivationDate"]),
    expirationDate: DateTime.parse(json["ExpirationDate"]),
    firstUsage: json["FirstUsage"],
    lastUsage: json["LastUsage"] == null ? null : DateTime.parse(json["LastUsage"]),
    lastRecharge: json["LastRecharge"],
    lifeTime: json["LifeTime"],
    product: Product.fromJson(json["Product"]),
    block: json["block"],
    billStatus: json["BillStatus"],
    subscriber: Subscriber.fromJson(json["subscriber"]),
    ipDevice: json["IPDevice"],
    aliases: json["Aliases"],
    creditLimit: json["CreditLimit"],
    serviceType: ServiceType.fromJson(json["ServiceType"]),
    balance: json["Balance"].toDouble(),
    staticIp: json["StaticIP"],
    isPoc: json["isPOC"],
    ipMask: json["IPMask"],
    imsi: json["IMSI"],
    portaoneAccountCredential: PortaoneAccountCredential.fromJson(json["PortaoneAccountCredential"]),
    usageDetails: json["UsageDetails"],
    accountState: json["AccountState"],
    allocation: json["allocation"],
    dataVolume: json["DataVolume"].toDouble(),
    operatorCode: json["OperatorCode"],
    postPaid: json["PostPaid"],
    resetPattern: json["ResetPattern"],
    postPaidReset: json["PostPaidReset"],
    accountOfficer: json["AccountOfficer"],
    lastNotificationPattern: json["LastNotificationPattern"],
    discount: json["Discount"],
    lastAutoRenewalDate: json["LastAutoRenewalDate"],
    loanCount: json["LoanCount"] == null ? null : json["LoanCount"],
    resumeOnline: json["ResumeOnline"],
    actualValue: json["ActualValue"],
    downloadType: json["DownloadType"],
    batchName: json["BatchName"],
    downloadMilestone: json["DownloadMilestone"],
    intendedProduct: json["IntendedProduct"],
    iAccountRole: json["i_account_role"],
    activeCalls: json["ActiveCalls"],
    autoRenewalProduct: json["AutoRenewalProduct"],
    staffNo: json["StaffNo"],
    isOnline: json["IsOnline"],
    idClient: json["id_client"],
    username: json["username"],
    newCustomerId: json["new_CustomerID"],
    newName: json["new_name"],
    newAccountLogging: json["new_AccountLogging"],
    newPostpaidAccountReset: json["new_PostpaidAccountReset"],
    newAccountId: json["new_Account_ID"],
    createdBy: json["CreatedBy"],
    userPassword: json["UserPassword"],
    password: json["Password"] == null ? null : json["Password"],
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
    "voip_client_type": voipClientType,
    "i_customer": iCustomer,
    "Customer": customer.toJson(),
    "i_account": iAccount,
    "i_master_account": iMasterAccount,
    "ID": id,
    "AccountName": accountName,
    "OpeningBalance": openingBalance,
    "ServicePassword": servicePassword == null ? null : servicePassword,
    "Type": type,
    "IssueDate": issueDate.toIso8601String(),
    "ActivationDate": activationDate.toIso8601String(),
    "ExpirationDate": expirationDate.toIso8601String(),
    "FirstUsage": firstUsage,
    "LastUsage": lastUsage == null ? null : lastUsage.toIso8601String(),
    "LastRecharge": lastRecharge,
    "LifeTime": lifeTime,
    "Product": product.toJson(),
    "block": block,
    "BillStatus": billStatus,
    "subscriber": subscriber.toJson(),
    "IPDevice": ipDevice,
    "Aliases": aliases,
    "CreditLimit": creditLimit,
    "ServiceType": serviceType.toJson(),
    "Balance": balance,
    "StaticIP": staticIp,
    "isPOC": isPoc,
    "IPMask": ipMask,
    "IMSI": imsi,
    "PortaoneAccountCredential": portaoneAccountCredential.toJson(),
    "UsageDetails": usageDetails,
    "AccountState": accountState,
    "allocation": allocation,
    "DataVolume": dataVolume,
    "OperatorCode": operatorCode,
    "PostPaid": postPaid,
    "ResetPattern": resetPattern,
    "PostPaidReset": postPaidReset,
    "AccountOfficer": accountOfficer,
    "LastNotificationPattern": lastNotificationPattern,
    "Discount": discount,
    "LastAutoRenewalDate": lastAutoRenewalDate,
    "LoanCount": loanCount == null ? null : loanCount,
    "ResumeOnline": resumeOnline,
    "ActualValue": actualValue,
    "DownloadType": downloadType,
    "BatchName": batchName,
    "DownloadMilestone": downloadMilestone,
    "IntendedProduct": intendedProduct,
    "i_account_role": iAccountRole,
    "ActiveCalls": activeCalls,
    "AutoRenewalProduct": autoRenewalProduct,
    "StaffNo": staffNo,
    "IsOnline": isOnline,
    "id_client": idClient,
    "username": username,
    "new_CustomerID": newCustomerId,
    "new_name": newName,
    "new_AccountLogging": newAccountLogging,
    "new_PostpaidAccountReset": newPostpaidAccountReset,
    "new_Account_ID": newAccountId,
    "CreatedBy": createdBy,
    "UserPassword": userPassword,
    "Password": password == null ? null : password,
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

class Customer {
  int prospectId;
  int iCustomer;
  String url;
  String id;
  String salutation;
  String firstName;
  String lastName;
  String middleInitial;
  String emailAddress;
  String mobilePhone;
  String homePhone;
  String tin;
  Address address;
  dynamic dateOfBirth;
  dynamic anniversary;
  dynamic primaryContact;
  String gender;
  String nextOfKin;
  String spouseName;
  Office office;
  dynamic contactMethod;
  dynamic block;
  double creditLimit;
  bool creditLimitSpecified;
  dynamic temporaryCreditLimmit;
  DateTime creationDate;
  int billStatus;
  dynamic accounts;
  bool portaBillingCreditable;
  dynamic customerCategory;
  dynamic customerClass;
  double balance;
  dynamic customerServiceType;
  dynamic customerName;
  int operatorCode;
  dynamic notepad;
  bool emailUnsubscribe;
  bool smsUnsubscribe;
  dynamic accountOfficer;
  dynamic kycStatus;
  dynamic isDealer;
  dynamic airTimeCommission;
  int shareCategory;
  dynamic defaultProduct;
  dynamic batchNo;
  dynamic referralActivationCode;
  dynamic referralCode;
  bool followUp;
  double billingBalance;
  dynamic session;
  int referreeICustomer;
  dynamic newKycStatus;
  String customerKycStatus;
  dynamic approvedBy;
  dynamic approvedDate;
  dynamic reason;
  dynamic createdBy;
  dynamic userPassword;
  dynamic password;
  DateTime createdDate;
  dynamic dealerUserId;
  int dealerId;
  dynamic loginDealer;
  dynamic logActivity;
  dynamic errorMessage;
  int requestFrom;
  dynamic userIpAddress;
  dynamic noEfTracked;

  Customer({
    this.prospectId,
    this.iCustomer,
    this.url,
    this.id,
    this.salutation,
    this.firstName,
    this.lastName,
    this.middleInitial,
    this.emailAddress,
    this.mobilePhone,
    this.homePhone,
    this.tin,
    this.address,
    this.dateOfBirth,
    this.anniversary,
    this.primaryContact,
    this.gender,
    this.nextOfKin,
    this.spouseName,
    this.office,
    this.contactMethod,
    this.block,
    this.creditLimit,
    this.creditLimitSpecified,
    this.temporaryCreditLimmit,
    this.creationDate,
    this.billStatus,
    this.accounts,
    this.portaBillingCreditable,
    this.customerCategory,
    this.customerClass,
    this.balance,
    this.customerServiceType,
    this.customerName,
    this.operatorCode,
    this.notepad,
    this.emailUnsubscribe,
    this.smsUnsubscribe,
    this.accountOfficer,
    this.kycStatus,
    this.isDealer,
    this.airTimeCommission,
    this.shareCategory,
    this.defaultProduct,
    this.batchNo,
    this.referralActivationCode,
    this.referralCode,
    this.followUp,
    this.billingBalance,
    this.session,
    this.referreeICustomer,
    this.newKycStatus,
    this.customerKycStatus,
    this.approvedBy,
    this.approvedDate,
    this.reason,
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

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    prospectId: json["ProspectID"],
    iCustomer: json["i_customer"],
    url: json["Url"],
    id: json["ID"],
    salutation: json["Salutation"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    middleInitial: json["MiddleInitial"],
    emailAddress: json["EmailAddress"],
    mobilePhone: json["MobilePhone"],
    homePhone: json["HomePhone"],
    tin: json["TIN"],
    address: Address.fromJson(json["Address"]),
    dateOfBirth: json["DateOfBirth"],
    anniversary: json["Anniversary"],
    primaryContact: json["PrimaryContact"],
    gender: json["Gender"],
    nextOfKin: json["NextOfKin"],
    spouseName: json["SpouseName"],
    office: Office.fromJson(json["Office"]),
    contactMethod: json["ContactMethod"],
    block: json["block"],
    creditLimit: json["CreditLimit"].toDouble(),
    creditLimitSpecified: json["CreditLimitSpecified"],
    temporaryCreditLimmit: json["TemporaryCreditLimmit"],
    creationDate: DateTime.parse(json["CreationDate"]),
    billStatus: json["BillStatus"],
    accounts: json["Accounts"],
    portaBillingCreditable: json["PortaBillingCreditable"],
    customerCategory: json["CustomerCategory"],
    customerClass: json["CustomerClass"],
    balance: json["Balance"].toDouble(),
    customerServiceType: json["CustomerServiceType"],
    customerName: json["CustomerName"],
    operatorCode: json["OperatorCode"],
    notepad: json["notepad"],
    emailUnsubscribe: json["EmailUnsubscribe"],
    smsUnsubscribe: json["SMSUnsubscribe"],
    accountOfficer: json["AccountOfficer"],
    kycStatus: json["KYCStatus"],
    isDealer: json["isDealer"],
    airTimeCommission: json["AirTimeCommission"],
    shareCategory: json["ShareCategory"],
    defaultProduct: json["DefaultProduct"],
    batchNo: json["BatchNo"],
    referralActivationCode: json["ReferralActivationCode"],
    referralCode: json["ReferralCode"],
    followUp: json["FollowUp"],
    billingBalance: json["BillingBalance"].toDouble(),
    session: json["Session"],
    referreeICustomer: json["Referree_i_customer"],
    newKycStatus: json["new_KYCStatus"],
    customerKycStatus: json["KycStatus"],
    approvedBy: json["ApprovedBy"],
    approvedDate: json["ApprovedDate"],
    reason: json["Reason"],
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
    "ProspectID": prospectId,
    "i_customer": iCustomer,
    "Url": url,
    "ID": id,
    "Salutation": salutation,
    "FirstName": firstName,
    "LastName": lastName,
    "MiddleInitial": middleInitial,
    "EmailAddress": emailAddress,
    "MobilePhone": mobilePhone,
    "HomePhone": homePhone,
    "TIN": tin,
    "Address": address.toJson(),
    "DateOfBirth": dateOfBirth,
    "Anniversary": anniversary,
    "PrimaryContact": primaryContact,
    "Gender": gender,
    "NextOfKin": nextOfKin,
    "SpouseName": spouseName,
    "Office": office.toJson(),
    "ContactMethod": contactMethod,
    "block": block,
    "CreditLimit": creditLimit,
    "CreditLimitSpecified": creditLimitSpecified,
    "TemporaryCreditLimmit": temporaryCreditLimmit,
    "CreationDate": creationDate.toIso8601String(),
    "BillStatus": billStatus,
    "Accounts": accounts,
    "PortaBillingCreditable": portaBillingCreditable,
    "CustomerCategory": customerCategory,
    "CustomerClass": customerClass,
    "Balance": balance,
    "CustomerServiceType": customerServiceType,
    "CustomerName": customerName,
    "OperatorCode": operatorCode,
    "notepad": notepad,
    "EmailUnsubscribe": emailUnsubscribe,
    "SMSUnsubscribe": smsUnsubscribe,
    "AccountOfficer": accountOfficer,
    "KYCStatus": kycStatus,
    "isDealer": isDealer,
    "AirTimeCommission": airTimeCommission,
    "ShareCategory": shareCategory,
    "DefaultProduct": defaultProduct,
    "BatchNo": batchNo,
    "ReferralActivationCode": referralActivationCode,
    "ReferralCode": referralCode,
    "FollowUp": followUp,
    "BillingBalance": billingBalance,
    "Session": session,
    "Referree_i_customer": referreeICustomer,
    "new_KYCStatus": newKycStatus,
    "KycStatus": customerKycStatus,
    "ApprovedBy": approvedBy,
    "ApprovedDate": approvedDate,
    "Reason": reason,
    "CreatedBy": createdBy,
    "UserPassword": userPassword,
    "Password": password,
//    "CreatedDate": createdDate.toIso8601String(),
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

class Address {
  String street;
  String area;
  String city;
  String state;
  String country;
  String zip;

  Address({
    this.street,
    this.area,
    this.city,
    this.state,
    this.country,
    this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["Street"] == null ? null : json["Street"],
    area: json["Area"] == null ? null : json["Area"],
    city: json["City"] == null ? null : json["City"],
    state: json["State"] == null ? null : json["State"],
    country: json["Country"] == null ? null : json["Country"],
    zip: json["Zip"] == null ? null : json["Zip"],
  );

  Map<String, dynamic> toJson() => {
    "Street": street == null ? null : street,
    "Area": area == null ? null : area,
    "City": city == null ? null : city,
    "State": state == null ? null : state,
    "Country": country == null ? null : country,
    "Zip": zip == null ? null : zip,
  };
}

class Office {
  dynamic occupation;
  dynamic company;
  dynamic address;
  dynamic telephone;

  Office({
    this.occupation,
    this.company,
    this.address,
    this.telephone,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    occupation: json["Occupation"],
    company: json["Company"],
    address: json["Address"],
    telephone: json["Telephone"],
  );

  Map<String, dynamic> toJson() => {
    "Occupation": occupation,
    "Company": company,
    "Address": address,
    "Telephone": telephone,
  };
}

class PortaoneAccountCredential {
  String portaoneUsername;
  String portaonePassword;
  String servicePassword;

  PortaoneAccountCredential({
    this.portaoneUsername,
    this.portaonePassword,
    this.servicePassword,
  });

  factory PortaoneAccountCredential.fromJson(Map<String, dynamic> json) => PortaoneAccountCredential(
    portaoneUsername: json["PortaoneUsername"] == null ? null : json["PortaoneUsername"],
    portaonePassword: json["PortaonePassword"] == null ? null : json["PortaonePassword"],
    servicePassword: json["ServicePassword"] == null ? null : json["ServicePassword"],
  );

  Map<String, dynamic> toJson() => {
    "PortaoneUsername": portaoneUsername == null ? null : portaoneUsername,
    "PortaonePassword": portaonePassword == null ? null : portaonePassword,
    "ServicePassword": servicePassword == null ? null : servicePassword,
  };
}

class Product {
  int iProduct;
  String name;
  dynamic productName;
  String caption;
  double price;
  double fundPrice;
  int validity;
  dynamic subscriptions;
  dynamic maintenanceFee;
  Display display;
  dynamic devices;
  int category;
  dynamic extraDataBundle;
  String weekdayPeriod;
  String weekendPeriod;
  dynamic isReady;
  int operatorId;
  dynamic navPostingGroup;
  int productType;
  int iAccountRole;
  int voipIdTariff;
  int staticIpIProduct;
  dynamic createdBy;
  dynamic userPassword;
  dynamic password;
  DateTime createdDate;
  dynamic dealerUserId;
  dynamic dealerId;
  dynamic loginDealer;
  dynamic logActivity;
  dynamic errorMessage;
  int requestFrom;
  dynamic userIpAddress;
  dynamic noEfTracked;

  Product({
    this.iProduct,
    this.name,
    this.productName,
    this.caption,
    this.price,
    this.fundPrice,
    this.validity,
    this.subscriptions,
    this.maintenanceFee,
    this.display,
    this.devices,
    this.category,
    this.extraDataBundle,
    this.weekdayPeriod,
    this.weekendPeriod,
    this.isReady,
    this.operatorId,
    this.navPostingGroup,
    this.productType,
    this.iAccountRole,
    this.voipIdTariff,
    this.staticIpIProduct,
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    iProduct: json["i_product"],
    name: json["Name"],
    productName: json["ProductName"],
    caption: json["Caption"],
    price: json["Price"].toDouble(),
    fundPrice: json["FundPrice"].toDouble(),
    validity: json["Validity"],
    subscriptions: json["Subscriptions"],
    maintenanceFee: json["MaintenanceFee"],
    display: Display.fromJson(json["Display"]),
    devices: json["Devices"],
    category: json["Category"],
    extraDataBundle: json["ExtraDataBundle"],
    weekdayPeriod: json["WeekdayPeriod"],
    weekendPeriod: json["WeekendPeriod"],
    isReady: json["IsReady"],
    operatorId: json["OperatorID"],
    navPostingGroup: json["NAVPostingGroup"],
    productType: json["ProductType"],
    iAccountRole: json["i_account_role"],
    voipIdTariff: json["voip_id_tariff"],
    staticIpIProduct: json["StaticIP_i_product"],
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
    "i_product": iProduct,
    "Name": name,
    "ProductName": productName,
    "Caption": caption,
    "Price": price,
    "FundPrice": fundPrice,
    "Validity": validity,
    "Subscriptions": subscriptions,
    "MaintenanceFee": maintenanceFee,
    "Display": display.toJson(),
    "Devices": devices,
    "Category": category,
    "ExtraDataBundle": extraDataBundle,
    "WeekdayPeriod": weekdayPeriod,
    "WeekendPeriod": weekendPeriod,
    "IsReady": isReady,
    "OperatorID": operatorId,
    "NAVPostingGroup": navPostingGroup,
    "ProductType": productType,
    "i_account_role": iAccountRole,
    "voip_id_tariff": voipIdTariff,
    "StaticIP_i_product": staticIpIProduct,
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

class Display {
  String timeSlot;
  String bustableSpeed;
  DataCapacity dataCapacity;
  int validityPeriod;
  String connectableDeviceCount;
  dynamic targetCustomerClass;
  int noofAllowedModems;
  bool showonSelfcare;
  bool canRenew;
  dynamic freeDomainRegistration;
  dynamic freeEmails;
  dynamic freeBrowsingPeriod;

  Display({
    this.timeSlot,
    this.bustableSpeed,
    this.dataCapacity,
    this.validityPeriod,
    this.connectableDeviceCount,
    this.targetCustomerClass,
    this.noofAllowedModems,
    this.showonSelfcare,
    this.canRenew,
    this.freeDomainRegistration,
    this.freeEmails,
    this.freeBrowsingPeriod,
  });

  factory Display.fromJson(Map<String, dynamic> json) => Display(
    timeSlot: json["TimeSlot"],
    bustableSpeed: json["BustableSpeed"],
    dataCapacity: DataCapacity.fromJson(json["DataCapacity"]),
    validityPeriod: json["ValidityPeriod"],
    connectableDeviceCount: json["ConnectableDeviceCount"],
    targetCustomerClass: json["TargetCustomerClass"],
    noofAllowedModems: json["NoofAllowedModems"],
    showonSelfcare: json["ShowonSelfcare"],
    canRenew: json["CanRenew"],
    freeDomainRegistration: json["FreeDomainRegistration"],
    freeEmails: json["FreeEmails"],
    freeBrowsingPeriod: json["FreeBrowsingPeriod"],
  );

  Map<String, dynamic> toJson() => {
    "TimeSlot": timeSlot,
    "BustableSpeed": bustableSpeed,
    "DataCapacity": dataCapacity.toJson(),
    "ValidityPeriod": validityPeriod,
    "ConnectableDeviceCount": connectableDeviceCount,
    "TargetCustomerClass": targetCustomerClass,
    "NoofAllowedModems": noofAllowedModems,
    "ShowonSelfcare": showonSelfcare,
    "CanRenew": canRenew,
    "FreeDomainRegistration": freeDomainRegistration,
    "FreeEmails": freeEmails,
    "FreeBrowsingPeriod": freeBrowsingPeriod,
  };
}

enum BustableSpeed { NOT_AVAILABLE }

final bustableSpeedValues = EnumValues({
  "Not Available": BustableSpeed.NOT_AVAILABLE
});

class DataCapacity {
  double capacity;
  int unitofMeasure;

  DataCapacity({
    this.capacity,
    this.unitofMeasure,
  });

  factory DataCapacity.fromJson(Map<String, dynamic> json) => DataCapacity(
    capacity: json["Capacity"].toDouble(),
    unitofMeasure: json["UnitofMeasure"],
  );

  Map<String, dynamic> toJson() => {
    "Capacity": capacity,
    "UnitofMeasure": unitofMeasure,
  };
}

class ServiceType {
  int id;
  String name;

  ServiceType({
    this.id,
    this.name,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    id: json["ID"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
  };
}

class Subscriber {
  String salutation;
  String firstName;
  String lastName;
  String middleInitial;
  String emailAddress;
  String mobilePhone;
  String homePhone;
  Address address;
  String primaryContact;
  String contactMethod;

  Subscriber({
    this.salutation,
    this.firstName,
    this.lastName,
    this.middleInitial,
    this.emailAddress,
    this.mobilePhone,
    this.homePhone,
    this.address,
    this.primaryContact,
    this.contactMethod,
  });

  factory Subscriber.fromJson(Map<String, dynamic> json) => Subscriber(
    salutation: json["Salutation"] == null ? null : json["Salutation"],
    firstName: json["FirstName"] == null ? null : json["FirstName"],
    lastName: json["LastName"] == null ? null : json["LastName"],
    middleInitial: json["MiddleInitial"],
    emailAddress: json["EmailAddress"] == null ? null : json["EmailAddress"],
    mobilePhone: json["MobilePhone"] == null ? null : json["MobilePhone"],
    homePhone: json["HomePhone"] == null ? null : json["HomePhone"],
    address: Address.fromJson(json["Address"]),
    primaryContact: json["PrimaryContact"],
    contactMethod: json["ContactMethod"],
  );

  Map<String, dynamic> toJson() => {
    "Salutation": salutation == null ? null : salutation,
    "FirstName": firstName == null ? null : firstName,
    "LastName": lastName == null ? null : lastName,
    "MiddleInitial": middleInitial,
    "EmailAddress": emailAddress == null ? null : emailAddress,
    "MobilePhone": mobilePhone == null ? null : mobilePhone,
    "HomePhone": homePhone == null ? null : homePhone,
    "Address": address.toJson(),
    "PrimaryContact": primaryContact,
    "ContactMethod": contactMethod,
  };
}

class User {
  String id;
  String firstName;
  String lastName;
  String salutation;
  String mobilePhone;
  String emailAddress;
  double balance;
  bool rememberMe;
  String vat;
  int userId;
  String userName;
  String passwordHash;
  dynamic securityStamp;
  dynamic discriminator;
  String iCustomer;
  String iAccount;
  dynamic accountId;
  bool defaultPassword;
  int operatorId;
  DateTime entryDate;
  int userType;
  List<dynamic> roles;
  dynamic pages;
  dynamic mikrotikLoginUrl;
  String createdBy;
  dynamic userPassword;
  String password;
  DateTime createdDate;
  dynamic dealerUserId;
  dynamic dealerId;
  dynamic loginDealer;
  dynamic logActivity;
  dynamic errorMessage;
  int requestFrom;
  dynamic userIpAddress;
  dynamic noEfTracked;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.salutation,
    this.mobilePhone,
    this.emailAddress,
    this.balance,
    this.rememberMe,
    this.vat,
    this.userId,
    this.userName,
    this.passwordHash,
    this.securityStamp,
    this.discriminator,
    this.iCustomer,
    this.iAccount,
    this.accountId,
    this.defaultPassword,
    this.operatorId,
    this.entryDate,
    this.userType,
    this.roles,
    this.pages,
    this.mikrotikLoginUrl,
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["Id"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    salutation: json["Salutation"],
    mobilePhone: json["MobilePhone"],
    emailAddress: json["EmailAddress"],
    balance: json["Balance"].toDouble(),
    rememberMe: json["RememberMe"],
    vat: json["Vat"],
    userId: json["UserID"],
    userName: json["UserName"],
    passwordHash: json["PasswordHash"],
    securityStamp: json["SecurityStamp"],
    discriminator: json["Discriminator"],
    iCustomer: json["i_Customer"],
    iAccount: json["i_Account"],
    accountId: json["AccountID"],
    defaultPassword: json["DefaultPassword"],
    operatorId: json["OperatorID"],
    entryDate: DateTime.parse(json["EntryDate"]),
    userType: json["UserType"],
    roles: List<dynamic>.from(json["Roles"].map((x) => x)),
    pages: json["Pages"],
    mikrotikLoginUrl: json["MikrotikLoginURL"],
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
    "Id": id,
    "FirstName": firstName,
    "LastName": lastName,
    "Salutation": salutation,
    "MobilePhone": mobilePhone,
    "EmailAddress": emailAddress,
    "Balance": balance,
    "RememberMe": rememberMe,
    "Vat": vat,
    "UserID": userId,
    "UserName": userName,
    "PasswordHash": passwordHash,
    "SecurityStamp": securityStamp,
    "Discriminator": discriminator,
    "i_Customer": iCustomer,
    "i_Account": iAccount,
    "AccountID": accountId,
    "DefaultPassword": defaultPassword,
    "OperatorID": operatorId,
    "EntryDate": entryDate.toIso8601String(),
    "UserType": userType,
    "Roles": List<dynamic>.from(roles.map((x) => x)),
    "Pages": pages,
    "MikrotikLoginURL": mikrotikLoginUrl,
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
