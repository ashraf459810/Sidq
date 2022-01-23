// To parse this JSON data, do
//
//     final newsDetails = newsDetailsFromJson(jsonString);

import 'dart:convert';

NewsDetailsModel newsDetailsFromJson(String str) => NewsDetailsModel.fromJson(json.decode(str));

String newsDetailsToJson(NewsDetailsModel data) => json.encode(data.toJson());

class NewsDetailsModel {
    NewsDetailsModel({
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
        this.description,
        this.trueLinks,
        this.falseLinks,
        this.trueVotesCount,
        this.falseVotesCount,
        this.comments,
    });

    String ?id;
    String? title;
    String? briefDescription;
    bool ?isTrue;
    bool ?isPublic;
    bool ?isVotable;
    String? categoryId;
    String? categoryName;
    String? fileId;
    String? fileLink;
    String? description;
    List<String>? trueLinks;
    List<String>? falseLinks;
    int ?trueVotesCount;
    int? falseVotesCount;
    List<String>? comments;

    factory NewsDetailsModel.fromJson(Map<String, dynamic> json) => NewsDetailsModel(
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
        description: json["description"],
        trueLinks: List<String>.from(json["trueLinks"].map((x) => x)),
        falseLinks: List<String>.from(json["falseLinks"].map((x) => x)),
        trueVotesCount: json["trueVotesCount"],
        falseVotesCount: json["falseVotesCount"],
        comments: List<String>.from(json["comments"].map((x) => x)),
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
        "description": description,
        "trueLinks": List<dynamic>.from(trueLinks!.map((x) => x)),
        "falseLinks": List<dynamic>.from(falseLinks!.map((x) => x)),
        "trueVotesCount": trueVotesCount,
        "falseVotesCount": falseVotesCount,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
    };
}
