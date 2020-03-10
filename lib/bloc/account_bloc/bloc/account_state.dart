part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  ActiveSessionModel activeSession;

  AccountState(this.activeSession, [List props = const []]);
}

class InitialAccountState extends AccountState {
  InitialAccountState(ActiveSessionModel activeSession) : super(activeSession);
}


class AccountUpdated extends AccountState {
  final ActiveSessionModel activeSessionModel;
  AccountUpdated(this.activeSessionModel) : super(activeSessionModel);

}

class AccountLoading extends AccountState{
  AccountLoading(ActiveSessionModel activeSession) : super(activeSession);
}
class TransactionUpdated extends AccountState {
  final ActiveSessionModel activeSession;

  TransactionUpdated(this.activeSession) : super(activeSession);
}

class AccountFailure extends AccountState{
  final String error;
  AccountFailure({ActiveSessionModel activeSession, this.error}) : super(activeSession);

  @override
  String toString() {
    return 'LoginFailure { error: $error}';
  }
}

class AccountSuccessful extends AccountState{
  final ActiveSessionModel transactionResponse;

  AccountSuccessful({this.transactionResponse, ActiveSessionModel activeSession}) : super(activeSession);

  @override
  String toString() =>
      'BookingFormSaveSuccess { Reference: $transactionResponse }';
}

class AccountSuccessFully extends AccountState{
  final ActiveSessionResponse activeSessionResponse;

  AccountSuccessFully({this.activeSessionResponse, ActiveSessionModel activeSession}) : super(activeSession);

  @override
  String toString() =>
      'TransactionSuccessFully { Reference: $activeSessionResponse }';
}