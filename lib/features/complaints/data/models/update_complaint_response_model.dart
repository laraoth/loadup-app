// To parse this JSON data, do
//
//     final updateComplaintsResponseModel = updateComplaintsResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateComplaintsResponseModel updateComplaintsResponseModelFromJson(
        String str) =>
    UpdateComplaintsResponseModel.fromJson(json.decode(str));

String updateComplaintsResponseModelToJson(
        UpdateComplaintsResponseModel data) =>
    json.encode(data.toJson());

class UpdateComplaintsResponseModel {
  bool success;
  String message;
  Data data;

  UpdateComplaintsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateComplaintsResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateComplaintsResponseModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int shipmentId;
  int customerId;
  String description;

  Data({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.shipmentId,
    required this.customerId,
    required this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shipmentId: json["shipment_id"],
        customerId: json["customer_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shipment_id": shipmentId,
        "customer_id": customerId,
        "description": description,
      };
}
