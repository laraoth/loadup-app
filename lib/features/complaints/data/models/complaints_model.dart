import 'dart:convert';

ComplaintsModel complaintsModelFromJson(String str) =>
    ComplaintsModel.fromJson(json.decode(str));

String complaintsModelToJson(ComplaintsModel data) =>
    json.encode(data.toJson());

class ComplaintsModel {
  bool success;
  String message;
  List<Datum> data;

  ComplaintsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ComplaintsModel.fromJson(Map<String, dynamic> json) =>
      ComplaintsModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => Datum.fromJson(x as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int shipmentId;
  int customerId;
  String description;
  Shipment shipment;
  Customer customer;

  Datum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.shipmentId,
    required this.customerId,
    required this.description,
    required this.shipment,
    required this.customer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
        shipmentId: json["shipment_id"] ?? 0,
        customerId: json["customer_id"] ?? 0,
        description: json["description"] ?? "",
        shipment:
            Shipment.fromJson(json["shipment"] as Map<String, dynamic>? ?? {}),
        customer:
            Customer.fromJson(json["customer"] as Map<String, dynamic>? ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shipment_id": shipmentId,
        "customer_id": customerId,
        "description": description,
        "shipment": shipment.toJson(),
        "customer": customer.toJson(),
      };
}

class Customer {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String? name;
  String? email;
  String? phone;
  String? address;
  int? age;
  Role? role;
  dynamic profilePhotoUrl;

  Customer({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.age,
    this.role,
    this.profilePhotoUrl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] ?? 0,
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        age: json["age"],
        role: json["role"] != null ? Role.fromJson(json["role"]) : null,
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
        "role": role?.toJson(),
        "profile_photo_url": profilePhotoUrl,
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
        value: json["value"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };
}

class Shipment {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int senderId;
  int receiverId;
  dynamic groupId;
  String typeOfCargo;
  String code;
  double? weight;
  String originAddress;
  String destinationAddress;
  dynamic specialHandlingInstructions;
  int originGovernorateId;
  int destinationGovernorateId;
  int originCenterId;
  int destinationCenterId;
  String status;
  QrCode? qrCode;
  String? qrCodeString;
  dynamic price;
  dynamic priceSetByAdminId;
  dynamic priceSetAt;
  dynamic assignedDeliveryPersonId;

  Shipment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.senderId,
    required this.receiverId,
    this.groupId,
    required this.typeOfCargo,
    required this.code,
    this.weight,
    required this.originAddress,
    required this.destinationAddress,
    this.specialHandlingInstructions,
    required this.originGovernorateId,
    required this.destinationGovernorateId,
    required this.originCenterId,
    required this.destinationCenterId,
    required this.status,
    this.qrCode,
    this.qrCodeString,
    this.price,
    this.priceSetByAdminId,
    this.priceSetAt,
    this.assignedDeliveryPersonId,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    final qr = json["qr_code"];
    QrCode? qrCodeObj;
    String? qrString;

    if (qr != null) {
      if (qr is Map<String, dynamic>) {
        qrCodeObj = QrCode.fromJson(qr);
      } else if (qr is String) {
        qrString = qr;
      }
    }

    return Shipment(
      id: json["id"] ?? 0,
      createdAt: DateTime.parse(
          json["created_at"] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json["updated_at"] ?? DateTime.now().toIso8601String()),
      senderId: json["sender_id"] ?? 0,
      receiverId: json["receiver_id"] ?? 0,
      groupId: json["group_id"],
      typeOfCargo: json["type_of_cargo"] ?? "",
      code: json["code"] ?? "",
      weight: (json["weight"] as num?)?.toDouble(),
      originAddress: json["origin_address"] ?? "",
      destinationAddress: json["destination_address"] ?? "",
      specialHandlingInstructions: json["special_handling_instructions"],
      originGovernorateId: json["origin_governorate_id"] ?? 0,
      destinationGovernorateId: json["destination_governorate_id"] ?? 0,
      originCenterId: json["origin_center_id"] ?? 0,
      destinationCenterId: json["destination_center_id"] ?? 0,
      status: json["status"] ?? "",
      qrCode: qrCodeObj,
      qrCodeString: qrString,
      price: json["price"],
      priceSetByAdminId: json["price_set_by_admin_id"],
      priceSetAt: json["price_set_at"],
      assignedDeliveryPersonId: json["assigned_delivery_person_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
        "qr_code": qrCode?.toJson() ?? qrCodeString,
        "price": price,
        "price_set_by_admin_id": priceSetByAdminId,
        "price_set_at": priceSetAt,
        "assigned_delivery_person_id": assignedDeliveryPersonId,
      };
}

class QrCode {
  int senderId;
  int receiverId;
  String shipmentCode;
  int shipmentId;
  String randomString;

  QrCode({
    required this.senderId,
    required this.receiverId,
    required this.shipmentCode,
    required this.shipmentId,
    required this.randomString,
  });

  factory QrCode.fromJson(Map<String, dynamic> json) => QrCode(
        senderId: json["sender_id"] ?? 0,
        receiverId: json["receiver_id"] ?? 0,
        shipmentCode: json["shipment_code"] ?? "",
        shipmentId: json["shipment_id"] ?? 0,
        randomString: json["random_string"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "shipment_code": shipmentCode,
        "shipment_id": shipmentId,
        "random_string": randomString,
      };
}
