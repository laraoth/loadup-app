// To parse this JSON data, do
//
//     final sentShipmentsModel = sentShipmentsModelFromJson(jsonString);

import 'dart:convert';

ShipmentsModel sentShipmentsModelFromJson(String str) =>
    ShipmentsModel.fromJson(json.decode(str));

String sentShipmentsModelToJson(ShipmentsModel data) =>
    json.encode(data.toJson());

class ShipmentsModel {
  bool success;
  String message;
  List<ShipmentDatum> data;

  ShipmentsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ShipmentsModel.fromJson(Map<String, dynamic> json) => ShipmentsModel(
        success: json["success"],
        message: json["message"],
        data: List<ShipmentDatum>.from(
            json["data"].map((x) => ShipmentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShipmentDatum {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? senderId;
  int? receiverId;
  dynamic? groupId;
  String? typeOfCargo;
  double? weight;
  String? originAddress;
  String? destinationAddress;
  String? specialHandlingInstructions;
  int? originGovernorateId;
  int? destinationGovernorateId;
  int? originCenterId;
  int? destinationCenterId;
  String? status;
  String? qrCode;
  dynamic price;
  dynamic priceSetByAdminId;
  dynamic priceSetAt;
  dynamic assignedDeliveryPersonId;
  Receiver? sender;
  Receiver? receiver;
  dynamic shipmentGroup;
  NGovernorate? originGovernorate;
  NGovernorate? destinationGovernorate;
  NCenter? originCenter;
  NCenter? destinationCenter;
  dynamic? assignedDeliveryPerson;
  String? shipmentCode;

  ShipmentDatum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.senderId,
    this.receiverId,
    this.groupId,
    this.typeOfCargo,
    this.weight,
    this.originAddress,
    this.destinationAddress,
    this.specialHandlingInstructions,
    this.originGovernorateId,
    this.destinationGovernorateId,
    this.originCenterId,
    this.destinationCenterId,
    this.status,
    this.qrCode,
    this.price,
    this.priceSetByAdminId,
    this.priceSetAt,
    this.assignedDeliveryPersonId,
    this.sender,
    this.receiver,
    this.shipmentGroup,
    this.originGovernorate,
    this.destinationGovernorate,
    this.originCenter,
    this.destinationCenter,
    this.assignedDeliveryPerson,
    this.shipmentCode,
  });
  factory ShipmentDatum.fromJson(Map<String, dynamic> json) => ShipmentDatum(
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
        sender: Receiver.fromJson(json["sender"]),
        receiver: Receiver.fromJson(json["receiver"]),
        shipmentGroup: json["shipment_group"],
        originGovernorate: NGovernorate.fromJson(json["origin_governorate"]),
        destinationGovernorate:
            NGovernorate.fromJson(json["destination_governorate"]),
        originCenter: NCenter.fromJson(json["origin_center"]),
        destinationCenter: NCenter.fromJson(json["destination_center"]),
        assignedDeliveryPerson: json["assigned_delivery_person"],
        shipmentCode: json["qr_code"] != null
            ? jsonDecode(json["qr_code"])["shipment_code"]
            : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "shipment_group": shipmentGroup,
        "origin_governorate": originGovernorate?.toJson(),
        "destination_governorate": destinationGovernorate?.toJson(),
        "origin_center": originCenter?.toJson(),
        "destination_center": destinationCenter?.toJson(),
        "assigned_delivery_person": assignedDeliveryPerson,
        "shipment_code": shipmentCode,
      };
}

class NCenter {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String location;
  int governorateId;

  NCenter({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.location,
    required this.governorateId,
  });

  factory NCenter.fromJson(Map<String, dynamic> json) => NCenter(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        location: json["location"],
        governorateId: json["governorate_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "location": location,
        "governorate_id": governorateId,
      };
}

class NGovernorate {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  NGovernorate({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory NGovernorate.fromJson(Map<String, dynamic> json) => NGovernorate(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
      };
}

class Receiver {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String email;
  String phone;
  String address;
  int age;
  Role role;
  dynamic profilePhotoUrl;

  Receiver({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.age,
    required this.role,
    required this.profilePhotoUrl,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        age: json["age"],
        role: Role.fromJson(json["role"]),
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "age": age,
        "role": role.toJson(),
        "profile_photo_url": profilePhotoUrl,
      };
}

class Role {
  String value;
  String name;

  Role({
    required this.value,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        value: json["value"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };
}
