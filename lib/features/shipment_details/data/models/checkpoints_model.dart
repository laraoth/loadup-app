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
  String message;
  List<Datum> data;
  Meta meta;

  CheckpointsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory CheckpointsModel.fromJson(Map<String, dynamic> json) =>
      CheckpointsModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  int governorateId;
  Governorate governorate;

  Datum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.governorateId,
    required this.governorate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        governorateId: json["governorate_id"],
        governorate: Governorate.fromJson(json["governorate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
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

class Meta {
  Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  int currentPage;
  int lastPage;
  int perPage;
  int total;
  int from;
  int to;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
        "from": from,
        "to": to,
      };
}
