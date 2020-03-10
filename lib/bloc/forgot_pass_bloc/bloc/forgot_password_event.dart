part of 'forgot_password_bloc.dart';


@immutable
abstract class ForgotPasswordEvent extends Equatable {
  ForgotPasswordEvent([List props = const []]): super(props);
}

class ForgotPasswordStarted extends ForgotPasswordEvent{}

class EmailChange extends ForgotPasswordEvent {
  final String username;

  EmailChange({this.username}) : super([username]);

}

//*Notifies the bloc that the user has pressed the login with username and password
class ForgotPasswordEventPressed extends ForgotPasswordEvent {
  final ForgotModel forgotModel;

  ForgotPasswordEventPressed({this.forgotModel}) : super([forgotModel]);

  @override
  String toString() => 'ForgotPasswordEventPressed { Email :${forgotModel.userName} ';
}
