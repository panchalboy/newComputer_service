// To parse this JSON data, do
//
//     final myProductModel = myProductModelFromJson(jsonString);

import 'dart:convert';

MyProductModel myProductModelFromJson(String str) =>
    MyProductModel.fromJson(json.decode(str));

String myProductModelToJson(MyProductModel data) => json.encode(data.toJson());

class MyProductModel {
  MyProductModel({
    this.error,
    this.message,
    this.result,
  });

  bool error;
  String message;
  List<Result> result;

  factory MyProductModel.fromJson(Map<String, dynamic> json) => MyProductModel(
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
    this.productId,
    this.productPrice,
    this.productDiscount,
    this.productQty,
    this.totalProductPrice,
    this.expDate,
    this.createdAt,
    this.updatedAt,
    this.sale,
    this.product,
  });

  int id;
  int saleId;
  int productId;
  String productPrice;
  dynamic productDiscount;
  String productQty;
  String totalProductPrice;
  String expDate;
  String createdAt;
  DateTime updatedAt;
  Sale sale;
  Product product;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        saleId: json["sale_id"],
        productId: json["product_id"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productQty: json["product_qty"],
        totalProductPrice: json["total_product_price"],
        expDate: json["exp_date"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        sale: Sale.fromJson(json["sale"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sale_id": saleId,
        "product_id": productId,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_qty": productQty,
        "total_product_price": totalProductPrice,
        "exp_date": expDate,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "sale": sale.toJson(),
        "product": product.toJson(),
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        validityId: json["validity_id"],
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
        "validity_id": validityId,
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
  DateTime createdAt;
  DateTime updatedAt;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        customerId: json["customer_id"],
        gstNo: json["gst_no"],
        status: json["status"],
        deliveryDate: json["delivery_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "gst_no": gstNo,
        "status": status,
        "delivery_date": deliveryDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
