// To parse this JSON data, do
//
//     final shipmentRequestModel = shipmentRequestModelFromJson(jsonString);

import 'dart:convert';

ShipmentRequestModel shipmentRequestModelFromJson(String str) =>
    ShipmentRequestModel.fromJson(json.decode(str));

String shipmentRequestModelToJson(ShipmentRequestModel data) =>
    json.encode(data.toJson());

class ShipmentRequestModel {
  int receiverId;
  String typeOfCargo;
  double weight;
  String originAddress;
  String destinationAddress;
  String? specialHandlingInstructions;
  int originGovernorateId;
  int destinationGovernorateId;
  int originCenterId;
  int destinationCenterId;

  ShipmentRequestModel({
    required this.receiverId,
    required this.typeOfCargo,
    required this.weight,
    required this.originAddress,
    required this.destinationAddress,
    this.specialHandlingInstructions,
    required this.originGovernorateId,
    required this.destinationGovernorateId,
    required this.originCenterId,
    required this.destinationCenterId,
  });

  factory ShipmentRequestModel.fromJson(Map<String, dynamic> json) =>
      ShipmentRequestModel(
        receiverId: json["receiver_id"],
        typeOfCargo: json["type_of_cargo"],
        weight: json["weight"]?.toDouble(),
        originAddress: json["origin_address"],
        destinationAddress: json["destination_address"],
        specialHandlingInstructions: json["special_handling_instructions"],
        originGovernorateId: json["origin_governorate_id"],
        destinationGovernorateId: json["destination_governorate_id"],
        originCenterId: json["origin_center_id"],
        destinationCenterId: json["destination_center_id"],
      );

  Map<String, dynamic> toJson() => {
        "receiver_id": receiverId,
        "type_of_cargo": typeOfCargo,
        "weight": weight,
        "origin_address": originAddress,
        "destination_address": destinationAddress,
        "special_handling_instructions": specialHandlingInstructions,
        "origin_governorate_id": originGovernorateId,
        "destination_governorate_id": destinationGovernorateId,
        "origin_center_id": originCenterId,
        "destination_center_id": destinationCenterId,
      };
}
