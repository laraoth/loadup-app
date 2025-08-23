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
  String description;

  CreateComplaintsRequestModel({
    required this.shipmentId,
    required this.description,
  });

  factory CreateComplaintsRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateComplaintsRequestModel(
        shipmentId: json["shipment_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "description": description,
      };
}
