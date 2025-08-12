// To parse this JSON data, do
//
//     final createComplaintsRequestModel = createComplaintsRequestModelFromJson(jsonString);

import 'dart:convert';

CreateComplaintsRequestModel createComplaintsRequestModelFromJson(String str) =>
    CreateComplaintsRequestModel.fromJson(json.decode(str));

String createComplaintsRequestModelToJson(CreateComplaintsRequestModel data) =>
    json.encode(data.toJson());

class CreateComplaintsRequestModel {
  int shipmentId;
  int customerId;
  String description;

  CreateComplaintsRequestModel({
    required this.shipmentId,
    required this.customerId,
    required this.description,
  });

  factory CreateComplaintsRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateComplaintsRequestModel(
        shipmentId: json["shipment_id"],
        customerId: json["customer_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "customer_id": customerId,
        "description": description,
      };
}
