// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  bool? success;
  String? message;
  List<UserDatum>? data;
  Meta? meta;

  UsersModel({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserDatum>.from(
                json["data"]!.map((x) => UserDatum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class UserDatum {
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

  UserDatum({
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

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
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

class Meta {
  Pagination? pagination;

  Meta({
    this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  int? from;
  int? to;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.from,
    this.to,
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
