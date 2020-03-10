import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfcare/apis/self_care_api.dart';
import 'package:selfcare/model/DataModel/CompleteTransactionResponse.dart';
import 'package:selfcare/model/DataModel/transaction.dart';
import 'package:selfcare/model/DataModel/transactionResponse.dart';
import 'package:selfcare/repository/data_repository.dart';

part 'dataplan_event.dart';

part 'dataplan_state.dart';

class DataplanBloc extends Bloc<DataplanEvent, DataplanState> {
  DataRepository dataRepository;
  TransactionRequest transactionRequest;

  DataplanBloc(
      {TransactionRequest transactionRequest, DataRepository dataRepository})
      : transactionRequest = transactionRequest,
        dataRepository =
            dataRepository ?? DataRepository.getInstance(SelfCareApi());

  @override
  DataplanState get initialState => DataplanInitial(transactionRequest);

  @override
  Stream<DataplanState> mapEventToState(DataplanEvent event,) async* {
    if (event is TransactionStarted) {
      _mapTransactRequest(event.transactionRequest);
      yield TransactionUpdated(event.transactionRequest);
    }
    else if (event is DataplanClickEvent) {
      yield* _mapTrasactionToState(event.transactionRequest);
    }
    else if (event is ReferenceConfirmClickEvent){
      yield* _mapTrasactionToReferenceState(event.reference);
    }
  }

  Stream<DataplanState> _mapTrasactionToState(
      TransactionRequest transactionRequest) async* {
    yield TransactionLoading(transactionRequest);
    try {
      var transactionResponse = await dataRepository.payWithCyberPay(
          transactionRequest);
      yield TransactionSuccessFul(transactionResponse: transactionResponse);
    } catch (error) {
      yield TransactionFailure(transactionRequest, error);
    }
  }

  Stream<DataplanState> _mapTrasactionToReferenceState(
      String reference) async* {
    yield TransactionLoading(transactionRequest);
    try {
      var transactionResponse = await dataRepository.getTransactionResponse(
          reference);
      yield TransactionSuccessFully(completeTransactionResponse: transactionResponse);
    } catch (error) {
      yield TransactionFailure(transactionRequest, error);
    }
  }

  Stream<DataplanState> _mapTransactRequest(
      TransactionRequest transactionRequest) async* {
    currentState.transactionRequest = transactionRequest;

    yield TransactionUpdated(currentState.transactionRequest);
  }

}


