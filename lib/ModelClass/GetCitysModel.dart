// To parse this JSON data, do
//
//     final getCitysModel = getCitysModelFromJson(jsonString);

import 'dart:convert';

GetCitysModel getCitysModelFromJson(String str) =>
    GetCitysModel.fromJson(json.decode(str));

String getCitysModelToJson(GetCitysModel data) => json.encode(data.toJson());

class GetCitysModel {
  GetCitysModel({
    this.error,
    this.message,
    this.result,
  });

  bool error;
  String message;
  List<Result> result;

  factory GetCitysModel.fromJson(Map<String, dynamic> json) => GetCitysModel(
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
    this.cityName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String cityName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        cityName: json["city_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
