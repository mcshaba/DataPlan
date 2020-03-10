part of 'account_bloc.dart';


@immutable
abstract class AccountEvent extends Equatable {
  ActiveSessionModel account;

  AccountEvent([List props = const []]): super(props);
}

class AccountStarted extends AccountEvent{}

class UpdateAccountCustomer extends AccountEvent {
  ActiveSessionModel account;

  UpdateAccountCustomer({this.account}) : super([account]);

}

//*Notifies the bloc that the user has pressed the login with username and password
class GetAccountEvent extends AccountEvent {
  ActiveSessionModel account;

  GetAccountEvent({this.account}) : super([account]);

  @override
  String toString() => 'GetAcountEvent { iAccount : ${account.iAccount} , iCustomer : ${account.iCustomer}';
}
