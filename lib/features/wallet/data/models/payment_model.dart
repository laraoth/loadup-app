import 'dart:convert';

PaymentsModel paymentsModelFromJson(String str) =>
    PaymentsModel.fromJson(json.decode(str));

class PaymentsModel {
  final bool success;
  final String message;
  final List<Payment> data;
  final Meta meta;

  PaymentsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        success: json["success"],
        message: json["message"],
        data: List<Payment>.from(json["data"].map((x) => Payment.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );
}

class Payment {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int shipmentId;
  final double amount;
  final String paymentMethod;
  final DateTime paymentDate;

  Payment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.shipmentId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shipmentId: json["shipment_id"],
        amount: (json["amount"] as num).toDouble(),
        paymentMethod: json["payment_method"],
        paymentDate: DateTime.parse(json["payment_date"]),
      );
}

class Meta {
  final Pagination pagination;

  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;

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
}
