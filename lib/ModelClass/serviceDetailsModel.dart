class ServiceDetailsModel {
  ServiceDetailsModel({
    this.id,
    this.validityId,
    this.title,
    this.image,
    this.mrp,
    this.serviceCharge,
    this.description,
    this.fullDesc,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.relevantServices,
    this.validity,
  });

  int id;
  int validityId;
  String title;
  String image;
  String mrp;
  String serviceCharge;
  String description;
  String fullDesc;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<ServiceDetailsModel> relevantServices;
  Validity validity;

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsModel(
        id: json["id"],
        validityId: json["validity_id"],
        title: json["title"],
        image: json["image"],
        mrp: json["mrp"],
        serviceCharge: json["service_charge"],
        description: json["description"],
        fullDesc: json["full_desc"] == null ? null : json["full_desc"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        relevantServices: json["relevant_services"] == null
            ? null
            : List<ServiceDetailsModel>.from(json["relevant_services"]
                .map((x) => ServiceDetailsModel.fromJson(x))),
        validity: json["validity"] == null
            ? null
            : Validity.fromJson(json["validity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "validity_id": validityId,
        "title": title,
        "image": image,
        "mrp": mrp,
        "service_charge": serviceCharge,
        "description": description,
        "full_desc": fullDesc == null ? null : fullDesc,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "relevant_services": relevantServices == null
            ? null
            : List<dynamic>.from(relevantServices.map((x) => x.toJson())),
        "validity": validity == null ? null : validity.toJson(),
      };
}

class Validity {
  Validity({
    this.id,
    this.validity,
    this.months,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String validity;
  String months;
  DateTime createdAt;
  DateTime updatedAt;

  factory Validity.fromJson(Map<String, dynamic> json) => Validity(
        id: json["id"],
        validity: json["validity"],
        months: json["months"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "validity": validity,
        "months": months,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
