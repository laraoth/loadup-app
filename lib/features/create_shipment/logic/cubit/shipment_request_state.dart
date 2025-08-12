part of 'shipment_request_cubit.dart';

abstract class ShipmentRequestState {}

class ShipmentRequestInitial extends ShipmentRequestState {}

class ShipmentRequestLoading extends ShipmentRequestState {}

class ShipmentRequestSuccess extends ShipmentRequestState {
  final String message;
  ShipmentRequestSuccess(this.message);
}

class ShipmentRequestError extends ShipmentRequestState {
  final String error;
  ShipmentRequestError(this.error);
}
