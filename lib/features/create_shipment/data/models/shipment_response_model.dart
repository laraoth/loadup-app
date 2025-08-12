// To parse this JSON data, do
//
//     final shipmentResponseModel = shipmentResponseModelFromJson(jsonString);

import 'dart:convert';

ShipmentResponseModel shipmentResponseModelFromJson(String str) => ShipmentResponseModel.fromJson(json.decode(str));

String shipmentResponseModelToJson(ShipmentResponseModel data) => json.encode(data.toJson());

class ShipmentResponseModel {
    bool success;
    String message;
    Data data;

    ShipmentResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ShipmentResponseModel.fromJson(Map<String, dynamic> json) => ShipmentResponseModel(
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
    int senderId;
    int receiverId;
    dynamic groupId;
    String typeOfCargo;
    double weight;
    String originAddress;
    String destinationAddress;
    String specialHandlingInstructions;
    int originGovernorateId;
    int destinationGovernorateId;
    int originCenterId;
    int destinationCenterId;
    String status;
    String qrCode;
    dynamic price;
    dynamic priceSetByAdminId;
    dynamic priceSetAt;
    dynamic assignedDeliveryPersonId;

    Data({
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.senderId,
        required this.receiverId,
        required this.groupId,
        required this.typeOfCargo,
        required this.weight,
        required this.originAddress,
        required this.destinationAddress,
        required this.specialHandlingInstructions,
        required this.originGovernorateId,
        required this.destinationGovernorateId,
        required this.originCenterId,
        required this.destinationCenterId,
        required this.status,
        required this.qrCode,
        required this.price,
        required this.priceSetByAdminId,
        required this.priceSetAt,
        required this.assignedDeliveryPersonId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        groupId: json["group_id"],
        typeOfCargo: json["type_of_cargo"],
        weight: json["weight"]?.toDouble(),
        originAddress: json["origin_address"],
        destinationAddress: json["destination_address"],
        specialHandlingInstructions: json["special_handling_instructions"],
        originGovernorateId: json["origin_governorate_id"],
        destinationGovernorateId: json["destination_governorate_id"],
        originCenterId: json["origin_center_id"],
        destinationCenterId: json["destination_center_id"],
        status: json["status"],
        qrCode: json["qr_code"],
        price: json["price"],
        priceSetByAdminId: json["price_set_by_admin_id"],
        priceSetAt: json["price_set_at"],
        assignedDeliveryPersonId: json["assigned_delivery_person_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sender_id": senderId,
        "receiver_id": receiverId,
        "group_id": groupId,
        "type_of_cargo": typeOfCargo,
        "weight": weight,
        "origin_address": originAddress,
        "destination_address": destinationAddress,
        "special_handling_instructions": specialHandlingInstructions,
        "origin_governorate_id": originGovernorateId,
        "destination_governorate_id": destinationGovernorateId,
        "origin_center_id": originCenterId,
        "destination_center_id": destinationCenterId,
        "status": status,
        "qr_code": qrCode,
        "price": price,
        "price_set_by_admin_id": priceSetByAdminId,
        "price_set_at": priceSetAt,
        "assigned_delivery_person_id": assignedDeliveryPersonId,
    };
}
