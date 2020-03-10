part of 'forgot_password_bloc.dart';
@immutable
abstract class ForgotPasswordState extends Equatable{
  final ForgotModel forgotModel;
  ForgotPasswordState(this.forgotModel, [List props = const []]);
}

class InitialStatusState extends ForgotPasswordState{
  InitialStatusState(ForgotModel forgotModel) : super(forgotModel);
}

class EmailSelected extends ForgotPasswordState {
  final String email;

  EmailSelected(this.email, ForgotModel forgotModel) : super(forgotModel, [email]);
}

class ForgotPasswordLoading extends ForgotPasswordState{
  ForgotPasswordLoading(ForgotModel forgotModel) : super(forgotModel);
}

class ForgotPasswordFailure extends ForgotPasswordState{
  final String error;

  ForgotPasswordFailure({@required this.error, ForgotModel forgotModel})
  : super (forgotModel);

  @override
  String toString() {
    return 'ForgotPasswordFailure { error: $error}';
  }

}

class ForgotPasswordUpdated extends ForgotPasswordState {
  final ForgotModel forgotModel;

  ForgotPasswordUpdated(this.forgotModel) : super(forgotModel);
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotResponse forgotResponse;
  ForgotPasswordSuccess(
      { this.forgotResponse, ForgotModel forgotModel}): super(forgotModel, [forgotResponse]);

  @override
  String toString() =>
      'ForgotPasswordSuccess { Reference: $forgotResponse }';
}
