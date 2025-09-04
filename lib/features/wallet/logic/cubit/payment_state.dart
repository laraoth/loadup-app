import 'package:equatable/equatable.dart';
import 'package:loadup/features/wallet/data/models/payment_model.dart';

abstract class PaymentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsSuccess extends PaymentsState {
  final PaymentsModel payments;
  PaymentsSuccess(this.payments);

  @override
  List<Object?> get props => [payments];
}

class PaymentsError extends PaymentsState {
  final String error;
  PaymentsError(this.error);

  @override
  List<Object?> get props => [error];
}
