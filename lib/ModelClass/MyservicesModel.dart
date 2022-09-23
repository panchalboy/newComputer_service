// To parse this JSON data, do
//
//     final myServicesModel = myServicesModelFromJson(jsonString);

import 'dart:convert';

MyServicesModel myServicesModelFromJson(String str) =>
    MyServicesModel.fromJson(json.decode(str));

String myServicesModelToJson(MyServicesModel data) =>
    json.encode(data.toJson());

class MyServicesModel {
  MyServicesModel({
    this.error,
    this.message,
    this.result,
  });

  bool error;
  String message;
  List<Result> result;

  factory MyServicesModel.fromJson(Map<String, dynamic> json) =>
      MyServicesModel(
        error: json["error"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.saleId,
    this.serviceId,
    this.servicePrice,
    this.serviceDiscount,
    this.totalServicePrice,
    this.expDate,
    this.createdAt,
    this.updatedAt,
    this.sale,
    this.service,
  });

  int id;
  int saleId;
  int serviceId;
  String servicePrice;
  dynamic serviceDiscount;
  String totalServicePrice;
  String expDate;
  String createdAt;
  DateTime updatedAt;
  Sale sale;
  Service service;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        saleId: json["sale_id"],
        serviceId: json["service_id"],
        servicePrice: json["service_price"],
        serviceDiscount: json["service_discount"],
        totalServicePrice: json["total_service_price"],
        expDate: json["exp_date"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        sale: Sale.fromJson(json["sale"]),
        service: Service.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sale_id": saleId,
        "service_id": serviceId,
        "service_price": servicePrice,
        "service_discount": serviceDiscount,
        "total_service_price": totalServicePrice,
        "exp_date": expDate,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "sale": sale.toJson(),
        "service": service.toJson(),
      };
}

class Sale {
  Sale({
    this.id,
    this.customerId,
    this.gstNo,
    this.status,
    this.deliveryDate,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int customerId;
  dynamic gstNo;
  String status;
  String deliveryDate;
  String createdAt;
  DateTime updatedAt;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        customerId: json["customer_id"],
        gstNo: json["gst_no"],
        status: json["status"],
        deliveryDate: json["delivery_date"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "gst_no": gstNo,
        "status": status,
        "delivery_date": deliveryDate,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Service {
  Service({
    this.id,
    this.validityId,
    this.title,
    this.serviceCharge,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int validityId;
  String title;
  String serviceCharge;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        validityId: json["validity_id"],
        title: json["title"],
        serviceCharge: json["service_charge"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "validity_id": validityId,
        "title": title,
        "service_charge": serviceCharge,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
