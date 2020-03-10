import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfcare/apis/self_care_api.dart';
import 'package:selfcare/model/ActiveSession/activeSessionModel.dart';
import 'package:selfcare/model/ActiveSession/activeSessionResponse.dart';
import 'package:selfcare/repository/data_repository.dart';
import 'package:selfcare/util/secure_storage.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  DataRepository repository;
  ActiveSessionModel activeSession;

  AccountBloc({ActiveSessionModel activeSession, DataRepository repository})
      : activeSession = activeSession,
        repository = repository ?? DataRepository.getInstance(SelfCareApi());

  @override
  AccountState get initialState => InitialAccountState(activeSession);

  @override
  Stream<AccountState> mapEventToState(
      AccountEvent event,
      ) async* {
    if (event is AccountStarted) {
      activeSession = ActiveSessionModel(iAccount: 0, iCustomer: 0);
      yield AccountUpdated(activeSession);
    } else if (event is UpdateAccountCustomer){
      yield* _mapAccountCustomerToState(event.account);
    }
    else if (event is GetAccountEvent) {
      yield* _mapLoginWithUsernamePressedToState(event.account);
    }
  }


  Stream<AccountState> _mapLoginWithUsernamePressedToState(ActiveSessionModel activeSessionModel) async* {
    yield AccountLoading(activeSession);
    try {
      ActiveSessionModel accountSession = ActiveSessionModel(
          iCustomer: currentState.activeSession.iCustomer,
          iAccount: currentState.activeSession.iAccount);

      var token = await SecureStorage.getToken();

      var activeSessionResponse = await repository.getSingleIAccount(accountSession, token);

      if (activeSessionResponse.status == 1) {
        yield AccountSuccessFully(activeSessionResponse: activeSessionResponse);
      } else {
        yield AccountFailure(activeSession: accountSession, error: activeSessionResponse.message.toString());
      }
    } catch (error) {
      yield AccountFailure(error: error.toString(), activeSession: activeSession);
    }
  }

  Stream<AccountState> _mapAccountCustomerToState(ActiveSessionModel account) async*{

    currentState.activeSession = account;
    yield AccountUpdated(currentState.activeSession);

  }
}
