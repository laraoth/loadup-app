part of 'sent_shipments_cubit.dart';

abstract class SentShipmentsState {}

class SentShipmentsInitial extends SentShipmentsState {}

class SentShipmentsLoading extends SentShipmentsState {}

class SentShipmentsSuccess extends SentShipmentsState {
  final String message;
  final ShipmentsModel shipmentsModel;
  SentShipmentsSuccess(this.message, this.shipmentsModel);
}

class SentShipmentsError extends SentShipmentsState {
  final String error;
  SentShipmentsError(this.error);
}
