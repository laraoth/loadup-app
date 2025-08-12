// To parse this JSON data, do
//
//     final complaintsModel = complaintsModelFromJson(jsonString);

import 'dart:convert';

ComplaintsModel complaintsModelFromJson(String str) =>
    ComplaintsModel.fromJson(json.decode(str));

String complaintsModelToJson(ComplaintsModel data) =>
    json.encode(data.toJson());

class ComplaintsModel {
  bool success;
  String message;
  List<Datum> data;
  Meta meta;

  ComplaintsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ComplaintsModel.fromJson(Map<String, dynamic> json) =>
      ComplaintsModel(
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
  int shipmentId;
  int customerId;
  String description;

  Datum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.shipmentId,
    required this.customerId,
    required this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shipmentId: json["shipment_id"],
        customerId: json["customer_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shipment_id": shipmentId,
        "customer_id": customerId,
        "description": description,
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
