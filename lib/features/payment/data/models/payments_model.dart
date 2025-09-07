// To parse this JSON data, do
//
//     final paymentsModel = paymentsModelFromJson(jsonString);

import 'dart:convert';

PaymentsModel paymentsModelFromJson(String str) =>
    PaymentsModel.fromJson(json.decode(str));

String paymentsModelToJson(PaymentsModel data) => json.encode(data.toJson());

class PaymentsModel {
  bool? success;
  String? message;
  List<Datum>? data;

  PaymentsModel({
    this.success,
    this.message,
    this.data,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? shipmentId;
  double? amount;
  int? userId;
  Shipment? shipment;
  User? user;

  Datum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.shipmentId,
    this.amount,
    this.userId,
    this.shipment,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        shipmentId: json["shipment_id"],
        amount: json["amount"]?.toDouble(),
        userId: json["user_id"],
        shipment: json["shipment"] == null
            ? null
            : Shipment.fromJson(json["shipment"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "shipment_id": shipmentId,
        "amount": amount,
        "user_id": userId,
        "shipment": shipment?.toJson(),
        "user": user?.toJson(),
      };
}

class Shipment {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? senderId;
  int? receiverId;
  dynamic groupId;
  String? typeOfCargo;
  String? code;
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
  double? price;
  int? priceSetByAdminId;
  DateTime? priceSetAt;
  dynamic assignedDeliveryPersonId;
  User? sender;
  User? receiver;
  dynamic shipmentGroup;
  NGovernorate? originGovernorate;
  NGovernorate? destinationGovernorate;
  NCenter? originCenter;
  NCenter? destinationCenter;

  Shipment({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.senderId,
    this.receiverId,
    this.groupId,
    this.typeOfCargo,
    this.code,
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
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        priceSetAt: json["price_set_at"] == null
            ? null
            : DateTime.parse(json["price_set_at"]),
        assignedDeliveryPersonId: json["assigned_delivery_person_id"],
        sender: json["sender"] == null ? null : User.fromJson(json["sender"]),
        receiver:
            json["receiver"] == null ? null : User.fromJson(json["receiver"]),
        shipmentGroup: json["shipment_group"],
        originGovernorate: json["origin_governorate"] == null
            ? null
            : NGovernorate.fromJson(json["origin_governorate"]),
        destinationGovernorate: json["destination_governorate"] == null
            ? null
            : NGovernorate.fromJson(json["destination_governorate"]),
        originCenter: json["origin_center"] == null
            ? null
            : NCenter.fromJson(json["origin_center"]),
        destinationCenter: json["destination_center"] == null
            ? null
            : NCenter.fromJson(json["destination_center"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        "price_set_at": priceSetAt?.toIso8601String(),
        "assigned_delivery_person_id": assignedDeliveryPersonId,
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "shipment_group": shipmentGroup,
        "origin_governorate": originGovernorate?.toJson(),
        "destination_governorate": destinationGovernorate?.toJson(),
        "origin_center": originCenter?.toJson(),
        "destination_center": destinationCenter?.toJson(),
      };
}

class NCenter {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? location;
  int? governorateId;

  NCenter({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.location,
    this.governorateId,
  });

  factory NCenter.fromJson(Map<String, dynamic> json) => NCenter(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        location: json["location"],
        governorateId: json["governorate_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "location": location,
        "governorate_id": governorateId,
      };
}

class NGovernorate {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  NGovernorate({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory NGovernorate.fromJson(Map<String, dynamic> json) => NGovernorate(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}

class User {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? email;
  String? phone;
  String? address;
  int? age;
  Role? role;
  dynamic profilePhotoUrl;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.age,
    this.role,
    this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        age: json["age"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "age": age,
        "role": role?.toJson(),
        "profile_photo_url": profilePhotoUrl,
      };
}

class Role {
  String? value;
  String? name;

  Role({
    this.value,
    this.name,
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
