part of 'dataplan_bloc.dart';

abstract class DataplanState extends Equatable {
  TransactionRequest transactionRequest;

  DataplanState(this.transactionRequest, [List props = const []]);
}

class DataplanInitial extends DataplanState {
  DataplanInitial(TransactionRequest transactionRequest) : super(transactionRequest);
}

class TransactionLoading extends DataplanState{
  TransactionLoading(TransactionRequest transactionRequest) : super(transactionRequest);
}
class TransactionUpdated extends DataplanState {
  final TransactionRequest transactionRequest;

  TransactionUpdated(this.transactionRequest) : super(transactionRequest);
}

class TransactionFailure extends DataplanState{
  final String error;
  TransactionFailure(TransactionRequest transactionRequest, this.error) : super(transactionRequest);

  @override
  String toString() {
    return 'LoginFailure { error: $error}';
  }
}

class TransactionSuccessFul extends DataplanState{
  final TransactionResponse transactionResponse;

  TransactionSuccessFul({this.transactionResponse, TransactionRequest transactionRequest}) : super(transactionRequest);

  @override
  String toString() =>
      'BookingFormSaveSuccess { Reference: $transactionResponse }';
}

class TransactionSuccessFully extends DataplanState{
  final CompleteTransactionResponse completeTransactionResponse;

  TransactionSuccessFully({this.completeTransactionResponse, TransactionRequest transactionRequest}) : super(transactionRequest);

  @override
  String toString() =>
      'TransactionSuccessFully { Reference: $completeTransactionResponse }';
}