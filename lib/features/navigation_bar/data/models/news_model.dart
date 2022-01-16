// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.briefDescription,
    this.isTrue,
    this.isPublic,
    this.isVotable,
    this.categoryId,
    this.categoryName,
    this.fileId,
    this.fileLink,
  });

  String? id;
  String? title;
  String? briefDescription;
  bool? isTrue;
  bool? isPublic;
  bool? isVotable;
  String? categoryId;
  String? categoryName;
  String? fileId;
  String? fileLink;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: json["title"],
        briefDescription: json["briefDescription"],
        isTrue: json["isTrue"],
        isPublic: json["isPublic"],
        isVotable: json["isVotable"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        fileId: json["fileId"],
        fileLink: json["fileLink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "briefDescription": briefDescription,
        "isTrue": isTrue,
        "isPublic": isPublic,
        "isVotable": isVotable,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "fileId": fileId,
        "fileLink": fileLink,
      };
}
