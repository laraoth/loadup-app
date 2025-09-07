// To parse this JSON data, do
//
//     final checkpointsModel = checkpointsModelFromJson(jsonString);

import 'dart:convert';

CheckpointsModel checkpointsModelFromJson(String str) =>
    CheckpointsModel.fromJson(json.decode(str));

String checkpointsModelToJson(CheckpointsModel data) =>
    json.encode(data.toJson());

class CheckpointsModel {
  bool success;
  Data data;

  CheckpointsModel({
    required this.success,
    required this.data,
  });

  factory CheckpointsModel.fromJson(Map<String, dynamic> json) =>
      CheckpointsModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  ShipmentGroup shipmentGroup;
  List<Checkpoint> checkpoints;

  Data({
    required this.shipmentGroup,
    required this.checkpoints,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shipmentGroup: ShipmentGroup.fromJson(json["shipment_group"]),
        checkpoints: List<Checkpoint>.from(
            json["checkpoints"].map((x) => Checkpoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shipment_group": shipmentGroup.toJson(),
        "checkpoints": List<dynamic>.from(checkpoints.map((x) => x.toJson())),
      };
}

class Checkpoint {
  int id;
  int checkpointId;
  int order;
  FromCenter checkpoint;
  bool isChecked;
  dynamic arrivalTime;

  Checkpoint({
    required this.id,
    required this.checkpointId,
    required this.order,
    required this.checkpoint,
    required this.isChecked,
    required this.arrivalTime,
  });

  factory Checkpoint.fromJson(Map<String, dynamic> json) => Checkpoint(
        id: json["id"],
        checkpointId: json["checkpoint_id"],
        order: json["order"],
        checkpoint: FromCenter.fromJson(json["checkpoint"]),
        isChecked: json["is_checked"],
        arrivalTime: json["arrival_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checkpoint_id": checkpointId,
        "order": order,
        "checkpoint": checkpoint.toJson(),
        "is_checked": isChecked,
        "arrival_time": arrivalTime,
      };
}

class FromCenter {
  int id;
  String name;
  int? governorateId;
  DateTime createdAt;
  DateTime updatedAt;
  String? location;

  FromCenter({
    required this.id,
    required this.name,
    this.governorateId,
    required this.createdAt,
    required this.updatedAt,
    this.location,
  });

  factory FromCenter.fromJson(Map<String, dynamic> json) => FromCenter(
        id: json["id"],
        name: json["name"],
        governorateId: json["governorate_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "governorate_id": governorateId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "location": location,
      };
}

class ShipmentGroup {
  int id;
  int driverId;
  int createdByAdminId;
  int lastUpdatedByAdminId;
  int fromGovernorateId;
  int toGovernorateId;
  int fromCenterId;
  int toCenterId;
  String routeDescription;
  String status;
  String code;
  DateTime createdAt;
  DateTime updatedAt;
  Driver driver;
  CreatedByAdmin createdByAdmin;
  CreatedByAdmin lastUpdatedByAdmin;
  FromCenter fromGovernorate;
  FromCenter toGovernorate;
  FromCenter fromCenter;
  FromCenter toCenter;

  ShipmentGroup({
    required this.id,
    required this.driverId,
    required this.createdByAdminId,
    required this.lastUpdatedByAdminId,
    required this.fromGovernorateId,
    required this.toGovernorateId,
    required this.fromCenterId,
    required this.toCenterId,
    required this.routeDescription,
    required this.status,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.driver,
    required this.createdByAdmin,
    required this.lastUpdatedByAdmin,
    required this.fromGovernorate,
    required this.toGovernorate,
    required this.fromCenter,
    required this.toCenter,
  });

  factory ShipmentGroup.fromJson(Map<String, dynamic> json) => ShipmentGroup(
        id: json["id"],
        driverId: json["driver_id"],
        createdByAdminId: json["created_by_admin_id"],
        lastUpdatedByAdminId: json["last_updated_by_admin_id"],
        fromGovernorateId: json["from_governorate_id"],
        toGovernorateId: json["to_governorate_id"],
        fromCenterId: json["from_center_id"],
        toCenterId: json["to_center_id"],
        routeDescription: json["route_description"],
        status: json["status"],
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: Driver.fromJson(json["driver"]),
        createdByAdmin: CreatedByAdmin.fromJson(json["created_by_admin"]),
        lastUpdatedByAdmin:
            CreatedByAdmin.fromJson(json["last_updated_by_admin"]),
        fromGovernorate: FromCenter.fromJson(json["from_governorate"]),
        toGovernorate: FromCenter.fromJson(json["to_governorate"]),
        fromCenter: FromCenter.fromJson(json["from_center"]),
        toCenter: FromCenter.fromJson(json["to_center"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "created_by_admin_id": createdByAdminId,
        "last_updated_by_admin_id": lastUpdatedByAdminId,
        "from_governorate_id": fromGovernorateId,
        "to_governorate_id": toGovernorateId,
        "from_center_id": fromCenterId,
        "to_center_id": toCenterId,
        "route_description": routeDescription,
        "status": status,
        "code": code,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "driver": driver.toJson(),
        "created_by_admin": createdByAdmin.toJson(),
        "last_updated_by_admin": lastUpdatedByAdmin.toJson(),
        "from_governorate": fromGovernorate.toJson(),
        "to_governorate": toGovernorate.toJson(),
        "from_center": fromCenter.toJson(),
        "to_center": toCenter.toJson(),
      };
}

class CreatedByAdmin {
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  String phone;
  String address;
  int age;
  String role;
  dynamic profilePhoto;
  DateTime createdAt;
  DateTime updatedAt;

  CreatedByAdmin({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.address,
    required this.age,
    required this.role,
    required this.profilePhoto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedByAdmin.fromJson(Map<String, dynamic> json) => CreatedByAdmin(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        phone: json["phone"],
        address: json["address"],
        age: json["age"],
        role: json["role"],
        profilePhoto: json["profile_photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "phone": phone,
        "address": address,
        "age": age,
        "role": role,
        "profile_photo": profilePhoto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Driver {
  int id;
  int userId;
  String vehicleDescription;
  String drivingLicenseNumber;
  DateTime createdAt;
  DateTime updatedAt;
  CreatedByAdmin user;

  Driver({
    required this.id,
    required this.userId,
    required this.vehicleDescription,
    required this.drivingLicenseNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        userId: json["user_id"],
        vehicleDescription: json["vehicle_description"],
        drivingLicenseNumber: json["driving_license_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: CreatedByAdmin.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vehicle_description": vehicleDescription,
        "driving_license_number": drivingLicenseNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}
