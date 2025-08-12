part of 'received_shipments_cubit.dart';

abstract class ReceivedShipmentsState {}

class ReceivedShipmentsInitial extends ReceivedShipmentsState {}

class ReceivedShipmentsLoading extends ReceivedShipmentsState {}

class ReceivedShipmentsSuccess extends ReceivedShipmentsState {
  final String message;
  final ShipmentsModel shipmentsModel;
  ReceivedShipmentsSuccess(this.message, this.shipmentsModel);
}

class ReceivedShipmentsError extends ReceivedShipmentsState {
  final String error;
  ReceivedShipmentsError(this.error);
}
