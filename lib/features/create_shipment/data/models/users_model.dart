import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  bool success;
  String message;
  List<UserDatum> data;
  Meta meta;

  UsersModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        success: json["success"],
        message: json["message"],
        data: List<UserDatum>.from(
            json["data"].map((x) => UserDatum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class UserDatum {
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

  UserDatum({
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

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
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
  Value value;
  Name name;

  Role({
    required this.value,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        value: valueValues.map[json["value"]]!,
        name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "value": valueValues.reverse[value],
        "name": nameValues.reverse[name],
      };
}

enum Name { ADMIN }

final nameValues = EnumValues({"ADMIN": Name.ADMIN});

enum Value { ADMIN }

final valueValues = EnumValues({"admin": Value.ADMIN});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
