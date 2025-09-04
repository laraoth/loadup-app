// في pending_shipments_state.dart
part of 'pending_shipments_cubit.dart';

abstract class PendingShipmentsState {}

class PendingShipmentsInitial extends PendingShipmentsState {}

class PendingShipmentsLoading extends PendingShipmentsState {}

class PendingShipmentsSuccess extends PendingShipmentsState {
  final String message;
  final ShipmentsModel shipmentsModel;
  PendingShipmentsSuccess(this.message, this.shipmentsModel);
}

class PendingShipmentsError extends PendingShipmentsState {
  final String error;
  PendingShipmentsError(this.error);
}
