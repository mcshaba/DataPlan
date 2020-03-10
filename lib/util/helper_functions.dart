import 'package:selfcare/util/secure_storage.dart';

class Helper {

  static logout() async {
    await SecureStorage.clearSecureInformation();
  }
}