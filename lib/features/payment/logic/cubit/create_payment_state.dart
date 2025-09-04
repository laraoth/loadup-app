import 'package:equatable/equatable.dart';
import 'package:loadup/features/payment/data/models/create_payment_response_model.dart';

abstract class ApprovePriceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApprovePriceInitial extends ApprovePriceState {}

class ApprovePriceLoading extends ApprovePriceState {}

class ApprovePriceSuccess extends ApprovePriceState {
  final ApprovePriceModel approvePriceModel;
  ApprovePriceSuccess(this.approvePriceModel);

  @override
  List<Object?> get props => [approvePriceModel];
}

class ApprovePriceError extends ApprovePriceState {
  final String error;
  ApprovePriceError(this.error);

  @override
  List<Object?> get props => [error];
}
