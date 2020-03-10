import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String TOKEN_KEY = "TOKEN";
  static const String MDN = "MDN";
  static const String FIRST_NAME = "FIRST_NAME";
  static const String DATA_INITIALIZED_KEY = "DATAINITITIALIZED";
  static const String VAT = "VAT";
  static const String I_ACCOUNT = "IACCOUNT";
  static const String I_CUSTOMER = "ICUSTOMER";

  static Future saveAccountInformation(String token, String firstName,
      String mdn, String vat, String iAccount, int iCustomer) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: TOKEN_KEY, value: token);
    await storage.write(key: MDN, value: mdn);
    await storage.write(key: FIRST_NAME, value: firstName);
    await storage.write(key: VAT, value: vat);
    await storage.write(key: I_ACCOUNT, value: iAccount.toString());
    await storage.write(key: I_CUSTOMER, value: iCustomer.toString());
  }

  static Future setInitialDataLoaded() async {
    final storage = FlutterSecureStorage();
    await storage.write(key: DATA_INITIALIZED_KEY, value: 'Y');
  }

  static Future<String> getInitialDataLoaded() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: DATA_INITIALIZED_KEY);
  }

  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: TOKEN_KEY);
  }

  static Future<String> getIAccount() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: I_ACCOUNT);
  }

  static Future<String> getICustomer() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: I_CUSTOMER);
  }

  static Future<String> getMDN() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: MDN);
  }

  static Future<String> getFirstName() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: FIRST_NAME);
  }

  static Future<String> getVat() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: VAT);
  }

  static Future clearSecureInformation() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
