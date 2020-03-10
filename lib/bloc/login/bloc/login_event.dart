part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
   LoginEvent([List props = const []]): super(props);
}

class LoginStarted extends LoginEvent{}

class UsernameChange extends LoginEvent {
  final String username;

  UsernameChange({this.username}) : super([username]);

}
class PasswordChange extends LoginEvent {
  final String password;

  PasswordChange({this.password}) : super([password]);
}

//*Notifies the bloc that the user has pressed the login with username and password
class LoginWithUsernamePressed extends LoginEvent {
  final Login login;

  LoginWithUsernamePressed({this.login}) : super([login]);

  @override
  String toString() => 'LoginWithUsernamePressed { username :${login.username} , password: ${login.password}';
}
