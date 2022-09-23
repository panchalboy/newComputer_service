// To parse this JSON data, do
//
//     final darshboardModel = darshboardModelFromJson(jsonString);

import 'dart:convert';

DarshboardModel darshboardModelFromJson(String str) =>
    DarshboardModel.fromJson(json.decode(str));

String darshboardModelToJson(DarshboardModel data) =>
    json.encode(data.toJson());

class DarshboardModel {
  DarshboardModel({
    this.error,
    this.message,
    this.result,
  });

  bool error;
  String message;
  List<Result> result;

  factory DarshboardModel.fromJson(Map<String, dynamic> json) =>
      DarshboardModel(
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
    this.productCategoryId,
    this.productName,
    this.mrp,
    this.salePrice,
    this.shortDesc,
    this.fullDesc,
    this.minQty,
    this.dealerPrice,
    this.status,
    this.productImg,
    this.createdAt,
    this.updatedAt,
    this.validityId,
    this.productGallery,
    this.category,
    this.validity,
  });

  int id;
  int productCategoryId;
  String productName;
  String mrp;
  String salePrice;
  String shortDesc;
  String fullDesc;
  int minQty;
  String dealerPrice;
  int status;
  String productImg;
  DateTime createdAt;
  DateTime updatedAt;
  int validityId;
  List<ProductGallery> productGallery;
  Category category;
  Category validity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        productCategoryId: json["product_category_id"],
        productName: json["product_name"],
        mrp: json["mrp"],
        salePrice: json["sale_price"],
        shortDesc: json["short_desc"],
        fullDesc: json["full_desc"],
        minQty: json["min_qty"],
        dealerPrice: json["dealer_price"],
        status: json["status"],
        productImg: json["product_img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        validityId: json["validity_id"] == null ? null : json["validity_id"],
        productGallery: List<ProductGallery>.from(
            json["product_gallery"].map((x) => ProductGallery.fromJson(x))),
        category: Category.fromJson(json["category"]),
        validity: json["validity"] == null
            ? null
            : Category.fromJson(json["validity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_category_id": productCategoryId,
        "product_name": productName,
        "mrp": mrp,
        "sale_price": salePrice,
        "short_desc": shortDesc,
        "full_desc": fullDesc,
        "min_qty": minQty,
        "dealer_price": dealerPrice,
        "status": status,
        "product_img": productImg,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "validity_id": validityId == null ? null : validityId,
        "product_gallery":
            List<dynamic>.from(productGallery.map((x) => x.toJson())),
        "category": category.toJson(),
        "validity": validity == null ? null : validity.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
    this.validity,
  });

  int id;
  String categoryName;
  DateTime createdAt;
  DateTime updatedAt;
  String validity;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        validity: json["validity"] == null ? null : json["validity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName == null ? null : categoryName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "validity": validity == null ? null : validity,
      };
}

class ProductGallery {
  ProductGallery({
    this.id,
    this.productId,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int productId;
  String img;
  dynamic createdAt;
  dynamic updatedAt;

  factory ProductGallery.fromJson(Map<String, dynamic> json) => ProductGallery(
        id: json["id"],
        productId: json["product_id"],
        img: json["img"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "img": img,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
