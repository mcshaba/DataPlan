import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfcare/apis/self_care_api.dart';
import 'package:selfcare/model/LoginModel/LoginRequest.dart';
import 'package:selfcare/model/LoginModel/LoginResponse.dart';
import 'package:selfcare/repository/login_repository.dart';
import 'package:selfcare/util/secure_storage.dart';
import 'package:selfcare/util/validator.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository repository;
  Login login;

  LoginBloc({Login login, LoginRepository repository})
      : login = login,
        repository = repository ?? LoginRepository.getInstance(SelfCareApi());

  @override
  LoginState get initialState => InitialLoginStatusState(login);

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginStarted) {
      login = Login(username: '', password: '');
      yield LoginUpdated(login);
    } else if (event is UsernameChange) {
      yield* _mapUserNameChangedToState(event.username);
    } else if (event is PasswordChange) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithUsernamePressed) {
      yield* _mapLoginWithUsernamePressedToState(event.login);
    }
  }

  Stream<LoginState> _mapUserNameChangedToState(String username) async* {
    currentState.login.username = username;
    yield LoginUpdated(
      currentState.login,
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    currentState.login.password = password;
    yield LoginUpdated(currentState.login);
  }

  Stream<LoginState> _mapLoginWithUsernamePressedToState(Login login) async* {
    yield LoginLoading(login);
    try {
      Login login = Login(
          username: currentState.login.username,
          password: currentState.login.password);
//      String header = '${currentState.login.password}96FEF48D6AT';
//      var key = utf8.encode(header);
//
//      String token = sha512.convert(key).toString();
//      print("SHABA $token");
      var token = await SecureStorage.getToken();

      var loginResponse = await repository.getLogin(login, token);

      if (loginResponse.status == 1 || loginResponse.message == 'login successful' ) {
        await SecureStorage.saveAccountInformation(
            loginResponse?.data?.accessToken,
            loginResponse?.data?.user?.firstName,
            loginResponse?.data?.accounts[0]?.id,
            loginResponse?.data?.user?.vat,
            loginResponse?.data?.user?.iAccount,
            loginResponse?.data?.accounts[0]?.iCustomer);
        yield LoginStateSuccess(loginResponse: loginResponse);
      } else {
        yield LoginStatusFailure(
            error: loginResponse.message.toString(), login: login);
      }
    } catch (error) {
      yield LoginStatusFailure(error: error.toString(), login: login);
    }
  }
}
