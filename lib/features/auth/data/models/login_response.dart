// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool success;
  String message;
  Data data;

  LoginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
  User user;
  String token;
  String tokenType;

  Data({
    required this.user,
    required this.token,
    required this.tokenType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "token_type": tokenType,
      };
}

class User {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String email;
  dynamic profile;
  String phone;
  String address;
  int age;
  Role role;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.email,
    required this.profile,
    required this.phone,
    required this.address,
    required this.age,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        email: json["email"],
        profile: json["profile"],
        phone: json["phone"],
        address: json["address"],
        age: json["age"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "email": email,
        "profile": profile,
        "phone": phone,
        "address": address,
        "age": age,
        "role": role.toJson(),
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
