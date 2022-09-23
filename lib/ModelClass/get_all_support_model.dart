// To parse this JSON data, do
//
//     final getAllSupport = getAllSupportFromJson(jsonString);

import 'dart:convert';

GetAllSupport getAllSupportFromJson(String str) =>
    GetAllSupport.fromJson(json.decode(str));

String getAllSupportToJson(GetAllSupport data) => json.encode(data.toJson());

class GetAllSupport {
  GetAllSupport({
    this.error,
    this.message,
    this.result,
  });

  bool error;
  String message;
  List<Result> result;

  factory GetAllSupport.fromJson(Map<String, dynamic> json) => GetAllSupport(
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
    this.userId,
    this.subject,
    this.fullDescription,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String subject;
  String fullDescription;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        subject: json["subject"],
        fullDescription: json["full_description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "subject": subject,
        "full_description": fullDescription,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
