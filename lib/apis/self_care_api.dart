import 'package:dio/dio.dart';
import 'package:selfcare/apis/endpoint.dart';
import 'package:selfcare/model/ActiveSession/activeSessionResponse.dart';
import 'package:selfcare/model/DataModel/CompleteTransactionResponse.dart';
import 'package:selfcare/model/DataModel/accountResponse.dart';
import 'package:selfcare/model/DataModel/transactionResponse.dart';
import 'package:selfcare/model/ForgotPassword/forgot_response.dart';
import 'package:selfcare/model/LoginModel/LoginFailureResponse.dart';
import 'package:selfcare/model/LoginModel/LoginResponse.dart';
import 'package:selfcare/util/exceptions.dart';

class SelfCareApi{
  Future<LoginResponse> postLogin(String encodedJson, String token) async {
    Response response;
    Dio dio = Dio();
    try{
      response = await dio.post(EndPoint.postLoginValidate(), data: encodedJson);

      if (response.statusCode == 200) {
        print('${response.data}');
        String message = LoginFailureResponse.fromJson(response.data).message;
        if(message == "Invalid Username or Password"){
          throw CleanerException(message);
        }
        return LoginResponse.fromJson(response.data);

      }else {
        return LoginResponse.fromJson(response.data);
      }
    } catch(error){
      if(error is DioError){
        throw CleanerException(_handleError(error));
      }else{
        throw CleanerException(
            '$error');
      }

    }
  }

Future<ForgotResponse> postForgotPassword(String encodedJson) async {
    Response response;
    Dio dio = Dio();
    try{
      response = await dio.post(EndPoint.postForgotPassword(), data: encodedJson);

      if (response.statusCode == 200) {
        print('${response.data}');
        String message = ForgotResponse.fromJson(response.data).message;
        if(message == "Invalid Username or Password"){
          throw CleanerException(message);
        }
        return ForgotResponse.fromJson(response.data);

      }else {
        return ForgotResponse.fromJson(response.data);
      }
    } catch(error){
      if(error is DioError){
        throw CleanerException(_handleError(error));
      }else{
        throw CleanerException(
            '$error');
      }

    }
  }


  Future<CompleteTransactionResponse> completeTransaction(String reference, String token) async{
    Response response;
    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    try{
      response = await dio.get(EndPoint.getCompleteCyberPayNew(), queryParameters: {"Reference": reference});
      if(response.statusCode ==200){
        print('${response.data}');

        return CompleteTransactionResponse.fromJson(response.data);
      }else {
       return CompleteTransactionResponse.fromJson(response.data);
      }

    }catch(error){
      if(error is DioError){
        throw CleanerException(_handleError(error));
      }else
        throw CleanerException("$error We cant get this transaction at the moment");
    }
  }


  Future<ActiveSessionResponse> getSingleIAccount(String encodedJson, String token) async{
    Response response;
    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    try{
      response = await dio.post("${EndPoint.getSingleIAccount()}", data: encodedJson);
      if(response.statusCode ==200){
        print('${response.data}');

        return ActiveSessionResponse.fromJson(response.data);
      }else {
       return ActiveSessionResponse.fromJson(response.data);
      }

    }catch(error){
      if(error is DioError){
        throw CleanerException(_handleError(error));
      }else
        throw CleanerException("We cant get this transaction at the moment");
    }
  }

  Future<TransactionResponse> payWithCyberPay(String encodedJson, String token) async{
    print(encodedJson);
    Response response;
    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      response = await dio.post(EndPoint.postCyberPayModel(), data:  encodedJson);
      if(response.statusCode == 200){
        print('${response.data}');
        return TransactionResponse.fromJson(response.data);
      } else {
        return TransactionResponse.fromJson(response.data);
      }
    }catch(error){
      throw CleanerException(_handleError(error));
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription =
          "Request to API server was cancelled \n Kindly check your internet connection and try again";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription =
          "Connection timeout with API server \n Kindly check your internet connection and try again";
          break;

        case DioErrorType.SEND_TIMEOUT:
          errorDescription =
          "Send timeout in connection with API server \n Kindly check your internet connection and try again";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription =
          "Sorry, there are No Buses available on this route \n Kindly check your internet connection and try again";

          break;
        case DioErrorType.RESPONSE:
          if (error.response?.statusCode == 401) {
            errorDescription = "401. Session expired. Kindly login again.";
          } else {
            errorDescription =
            "Sorry, there are No Data available at this time";

          }
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Slow or no internet connection. Please check your internet settings and try again.";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

}