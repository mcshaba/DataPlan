import 'package:selfcare/apis/self_care_api.dart';
import 'package:selfcare/model/ForgotPassword/forgot_password_request.dart';
import 'package:selfcare/model/ForgotPassword/forgot_response.dart';
import 'package:selfcare/model/LoginModel/LoginRequest.dart';
import 'package:selfcare/model/LoginModel/LoginResponse.dart';
import 'package:selfcare/util/secure_storage.dart';

class LoginRepository{
  static SelfCareApi _api;
  static LoginRepository _instance;

  static LoginRepository getInstance(SelfCareApi api){
    if(_instance == null){
      _api = api ?? SelfCareApi();
      _instance = LoginRepository();
    }
    return _instance;
  }


  Future<LoginResponse> getLogin(Login login, String token) async{

    try{

      return _api.postLogin(loginToJson(login), token);
    } catch(e){
      rethrow;
    }
  }

  Future<ForgotResponse> postForgotPassword(ForgotModel forgotModel) async{

    try{

      return _api.postForgotPassword(forgotModelToJson(forgotModel));
    } catch(e){
      rethrow;
    }
  }
}