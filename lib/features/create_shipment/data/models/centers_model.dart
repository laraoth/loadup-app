// To parse this JSON data, do
//
//     final centersModel = centersModelFromJson(jsonString);

import 'dart:convert';

CentersModel centersModelFromJson(String str) =>
    CentersModel.fromJson(json.decode(str));

String centersModelToJson(CentersModel data) => json.encode(data.toJson());

class CentersModel {
  bool success;
  String message;
  List<CenterDatum> data;

  CentersModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CentersModel.fromJson(Map<String, dynamic> json) => CentersModel(
        success: json["success"],
        message: json["message"],
        data: List<CenterDatum>.from(
            json["data"].map((x) => CenterDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CenterDatum {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String location;
  int governorateId;
  Governorate governorate;

  CenterDatum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.location,
    required this.governorateId,
    required this.governorate,
  });

  factory CenterDatum.fromJson(Map<String, dynamic> json) => CenterDatum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        location: json["location"],
        governorateId: json["governorate_id"],
        governorate: Governorate.fromJson(json["governorate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "location": location,
        "governorate_id": governorateId,
        "governorate": governorate.toJson(),
      };
}

class Governorate {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  Governorate({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
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
