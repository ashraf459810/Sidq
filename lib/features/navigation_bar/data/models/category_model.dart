// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  List<Result>? result;
  dynamic targetUrl;
  bool? success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class Result {
  Result({
    this.name,
    this.newsCount,
    this.id,
  });

  String? name;
  int? newsCount;
  String? id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        newsCount: json["newsCount"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "newsCount": newsCount,
        "id": id,
      };
}
