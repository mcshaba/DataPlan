import 'package:selfcare/apis/self_care_api.dart';
import 'package:selfcare/model/ActiveSession/activeSessionModel.dart';
import 'package:selfcare/model/ActiveSession/activeSessionResponse.dart';
import 'package:selfcare/model/DataModel/CompleteTransactionResponse.dart';
import 'package:selfcare/model/DataModel/accountResponse.dart';
import 'package:selfcare/model/DataModel/transaction.dart';
import 'package:selfcare/model/DataModel/transactionResponse.dart';
import 'package:selfcare/util/secure_storage.dart';

class DataRepository{
  static SelfCareApi _api;
  static DataRepository _instance;

  static DataRepository getInstance(SelfCareApi api){
    if(_instance == null){
      _api = api ?? SelfCareApi();
      _instance = DataRepository();
    }
    return _instance;
  }

  Future<CompleteTransactionResponse> getTransactionResponse(String reference) async{
    try{
      var token = await SecureStorage.getToken();

      return _api.completeTransaction(reference, token);
    }catch(e){
      rethrow;
    }
  }

  Future<ActiveSessionResponse> getSingleIAccount(ActiveSessionModel activeSessionModel, String token) async{
    try{
//      var token = await SecureStorage.getToken();

      return _api.getSingleIAccount(activeSessionModelToJson(activeSessionModel), token);
    }catch(e){
      rethrow;
    }
  }

  Future<TransactionResponse> payWithCyberPay(TransactionRequest encoded) async{
    try{
      var token = await SecureStorage.getToken();

      return _api.payWithCyberPay(transactionRequestToJson(encoded), token);
    }catch(e){
      rethrow;
    }
  }
}