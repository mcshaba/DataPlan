import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfcare/apis/self_care_api.dart';
import 'package:selfcare/model/ForgotPassword/forgot_password_request.dart';
import 'package:selfcare/model/ForgotPassword/forgot_response.dart';
import 'package:selfcare/model/LoginModel/LoginRequest.dart';
import 'package:selfcare/repository/login_repository.dart';
import 'package:selfcare/util/secure_storage.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPassBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  LoginRepository repository;
  ForgotModel forgotModel;

  ForgotPassBloc({ ForgotModel forgotModel, LoginRepository repository})
      : forgotModel = forgotModel,
        repository = repository ?? LoginRepository.getInstance(SelfCareApi());

  @override
  ForgotPasswordState get initialState => InitialStatusState(forgotModel);

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordStarted) {
      forgotModel = ForgotModel(userName: '');
      yield ForgotPasswordUpdated(forgotModel);
    } else if (event is EmailChange) {
      yield* _mapUserNameChangedToState(event.username);
    } else if (event is ForgotPasswordEventPressed) {
      yield* _mapLoginWithUsernamePressedToState(event.forgotModel);
    }
  }

  Stream<ForgotPasswordState> _mapUserNameChangedToState(String username) async* {
    currentState.forgotModel.userName = username;
    yield ForgotPasswordUpdated(
      currentState.forgotModel,
    );
  }

  Stream<ForgotPasswordState> _mapLoginWithUsernamePressedToState( ForgotModel forgotModel) async* {
    yield ForgotPasswordLoading(forgotModel);
    try {
      ForgotModel forgotModel = ForgotModel(
          userName: currentState.forgotModel.userName);

      var forgotPasswordResponse = await repository.postForgotPassword(forgotModel);

      if (forgotPasswordResponse.status == 1 ) {

        yield ForgotPasswordSuccess(forgotResponse: forgotPasswordResponse);
      } else {
        yield ForgotPasswordFailure(
            error: forgotPasswordResponse.message.toString(), forgotModel: forgotModel);
      }
    } catch (error) {
      yield ForgotPasswordFailure(error: error.toString(), forgotModel: forgotModel);
    }
  }
}
