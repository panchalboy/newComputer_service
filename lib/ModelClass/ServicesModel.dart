// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) =>
    ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

class ServicesModel {
  ServicesModel({
    this.error,
    this.message,
    this.result,
  });

  bool error;
  String message;
  List<Result> result;

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
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
    this.image,
    this.validityId,
    this.title,
    this.serviceCharge,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.validity,
  });

  int id;
  String image;
  int validityId;
  String title;
  String serviceCharge;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  Validity validity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        image: json['image'] == null ? "assets/m1.jpg" : json['image'],
        validityId: json["validity_id"],
        title: json["title"],
        serviceCharge: json["service_charge"],
        description: json["description"] ?? null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        validity: Validity.fromJson(json["validity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'image': image,
        "validity_id": validityId,
        "title": title,
        "service_charge": serviceCharge,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "validity": validity.toJson(),
      };
}

class Validity {
  Validity({
    this.id,
    this.validity,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String validity;
  DateTime createdAt;
  DateTime updatedAt;

  factory Validity.fromJson(Map<String, dynamic> json) => Validity(
        id: json["id"],
        validity: json["validity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "validity": validity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
