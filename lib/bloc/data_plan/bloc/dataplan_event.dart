part of 'dataplan_bloc.dart';

@immutable
abstract class DataplanEvent extends Equatable {
  DataplanEvent([List props = const<dynamic>[]]): super(props);
}

class TransactionStarted extends DataplanEvent{
  final TransactionRequest transactionRequest;

  TransactionStarted(this.transactionRequest): super([transactionRequest]);

}

class DataplanClickEvent extends DataplanEvent {
  TransactionRequest transactionRequest;

  DataplanClickEvent({this.transactionRequest}): super([transactionRequest]);

  @override
  String toString() {
    return super.toString();
  }
}

class ReferenceConfirmClickEvent extends DataplanEvent {
  String  reference;
  TransactionRequest transactionRequest;


  ReferenceConfirmClickEvent({this.reference}): super([reference]);

  @override
  String toString() {
    return super.toString();
  }
}


