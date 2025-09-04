// To parse this JSON data, do
//
//     final approvePriceModel = approvePriceModelFromJson(jsonString);

import 'dart:convert';

ApprovePriceModel approvePriceModelFromJson(String str) =>
    ApprovePriceModel.fromJson(json.decode(str));

String approvePriceModelToJson(ApprovePriceModel data) =>
    json.encode(data.toJson());

class ApprovePriceModel {
  bool success;
  String message;
  Data data;

  ApprovePriceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApprovePriceModel.fromJson(Map<String, dynamic> json) =>
      ApprovePriceModel(
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
  String code;
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
  double price;
  int priceSetByAdminId;
  DateTime priceSetAt;
  dynamic assignedDeliveryPersonId;
  Receiver sender;
  Receiver receiver;
  dynamic shipmentGroup;
  NGovernorate originGovernorate;
  NGovernorate destinationGovernorate;
  NCenter originCenter;
  NCenter destinationCenter;

  Data({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.senderId,
    required this.receiverId,
    required this.groupId,
    required this.typeOfCargo,
    required this.code,
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
    required this.sender,
    required this.receiver,
    required this.shipmentGroup,
    required this.originGovernorate,
    required this.destinationGovernorate,
    required this.originCenter,
    required this.destinationCenter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        groupId: json["group_id"],
        typeOfCargo: json["type_of_cargo"],
        code: json["code"],
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
        price: json["price"]?.toDouble(),
        priceSetByAdminId: json["price_set_by_admin_id"],
        priceSetAt: DateTime.parse(json["price_set_at"]),
        assignedDeliveryPersonId: json["assigned_delivery_person_id"],
        sender: Receiver.fromJson(json["sender"]),
        receiver: Receiver.fromJson(json["receiver"]),
        shipmentGroup: json["shipment_group"],
        originGovernorate: NGovernorate.fromJson(json["origin_governorate"]),
        destinationGovernorate:
            NGovernorate.fromJson(json["destination_governorate"]),
        originCenter: NCenter.fromJson(json["origin_center"]),
        destinationCenter: NCenter.fromJson(json["destination_center"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sender_id": senderId,
        "receiver_id": receiverId,
        "group_id": groupId,
        "type_of_cargo": typeOfCargo,
        "code": code,
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
        "price_set_at": priceSetAt.toIso8601String(),
        "assigned_delivery_person_id": assignedDeliveryPersonId,
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
        "shipment_group": shipmentGroup,
        "origin_governorate": originGovernorate.toJson(),
        "destination_governorate": destinationGovernorate.toJson(),
        "origin_center": originCenter.toJson(),
        "destination_center": destinationCenter.toJson(),
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
