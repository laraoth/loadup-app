// To parse this JSON data, do
//
//     final governoratesModel = governoratesModelFromJson(jsonString);

import 'dart:convert';

GovernoratesModel governoratesModelFromJson(String str) =>
    GovernoratesModel.fromJson(json.decode(str));

String governoratesModelToJson(GovernoratesModel data) =>
    json.encode(data.toJson());

class GovernoratesModel {
  bool success;
  String message;
  List<GovernorateDatum> data;
  Meta meta;

  GovernoratesModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory GovernoratesModel.fromJson(Map<String, dynamic> json) =>
      GovernoratesModel(
        success: json["success"],
        message: json["message"],
        data: List<GovernorateDatum>.from(
            json["data"].map((x) => GovernorateDatum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class GovernorateDatum {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  GovernorateDatum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory GovernorateDatum.fromJson(Map<String, dynamic> json) =>
      GovernorateDatum(
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
