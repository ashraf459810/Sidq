// To parse this JSON data, do
//
//     final newsDetailsModel = newsDetailsModelFromJson(jsonString);

import 'dart:convert';

NewsDetailsModel newsDetailsModelFromJson(String str) => NewsDetailsModel.fromJson(json.decode(str));

String newsDetailsModelToJson(NewsDetailsModel data) => json.encode(data.toJson());

class NewsDetailsModel {
    NewsDetailsModel({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    Result ?result;
    dynamic targetUrl;
    bool ?success;
    dynamic error;
    bool ?unAuthorizedRequest;
    bool? abp;

    factory NewsDetailsModel.fromJson(Map<String, dynamic> json) => NewsDetailsModel(
        result: Result.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
    );

    Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
    };
}

class Result {
    Result({
      this.views,
        this.description,
        this.trueLinks,
        this.falseLinks,
        this.trueVotesCount,
        this.falseVotesCount,
        this.comments,
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

    String ? description;
    List<dynamic> ?trueLinks;
    List<String> ? falseLinks;
    int ?trueVotesCount;
    int ?falseVotesCount;
    List<String>? comments;
    String ?title;
    String? briefDescription;
    bool ?isTrue;
    bool ?isPublic;
    bool ?isVotable;
    String ?categoryId;
    String ?categoryName;
    String ?fileId;
    String ?fileLink;
    String? id;
    String ? date;
    int ? views;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
      views: json['viewsCount'],
      date: json['date'],
        description: json["description"],
        trueLinks: List<dynamic>.from(json["trueLinks"].map((x) => x)),
        falseLinks: List<String>.from(json["falseLinks"].map((x) => x)),
        trueVotesCount: json["trueVotesCount"],
        falseVotesCount: json["falseVotesCount"],
        comments: List<String>.from(json["comments"].map((x) => x)),
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
        "description": description,
        "trueLinks": List<dynamic>.from(trueLinks!.map((x) => x)),
        "falseLinks": List<dynamic>.from(falseLinks!.map((x) => x)),
        "trueVotesCount": trueVotesCount,
        "falseVotesCount": falseVotesCount,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
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
