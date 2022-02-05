// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    NewsModel({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    List<News> ?result;
    dynamic targetUrl;
    bool? success;
    dynamic error;
    bool? unAuthorizedRequest;
    bool? abp;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        result: List<News>.from(json["result"].map((x) => News.fromJson(x))),
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

class News {
    News({
      this.views,
        this.title,
        this.briefDescription,
        this.isTrue,
        this.isPublic,
        this.isVotable,
        this.categoryId,
        this.categoryName,
        this.fileId,
        this.fileLink,
        this.id,
        this.date
      
    });
    int ? views;
    String?title;
    String ?briefDescription;
    bool ?isTrue;
    bool? isPublic;
    bool? isVotable;
    String? categoryId;
    String? categoryName;
    String? fileId;
    String ?fileLink;
    String ? date;
    String? id;


    factory News.fromJson(Map<String, dynamic> json) => News(
      views :json['viewsCount'],
      date: json['date'],
        title: json["title"],
        briefDescription: json["briefDescription"],
        isTrue: json["isTrue"],
        isPublic: json["isPublic"],
        isVotable: json["isVotable"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        fileId: json["fileId"],
        fileLink: json["fileLink"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "briefDescription": briefDescription,
        "isTrue": isTrue,
        "isPublic": isPublic,
        "isVotable": isVotable,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "fileId": fileId,
        "fileLink": fileLink,
        "id": id,
    };
}
