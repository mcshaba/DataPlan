part of 'login_bloc.dart';
@immutable
abstract class LoginState extends Equatable{
  final Login login;
  LoginState(this.login, [List props = const []]);
}

class InitialLoginStatusState extends LoginState{
  InitialLoginStatusState(Login login) : super(login);
}

class UsernameSelected extends LoginState {
  final String username;

  UsernameSelected(this.username, Login login) : super(login, [username]);
}

class LoginLoading extends LoginState{
  LoginLoading(Login login) : super(login);
}

class LoginStatusFailure extends LoginState{
  final String error;

  LoginStatusFailure({@required this.error, Login login})
  : super (login);

  @override
  String toString() {
    return 'LoginFailure { error: $error}';
  }

}

class LoginUpdated extends LoginState {
  final Login login;

  LoginUpdated(this.login) : super(login);
}

class LoginStateSuccess extends LoginState {
  final LoginResponse loginResponse;
  LoginStateSuccess(
      { this.loginResponse, Login login}): super(login, [loginResponse]);

  @override
  String toString() =>
      'BookingFormSaveSuccess { Reference: $loginResponse }';
}
