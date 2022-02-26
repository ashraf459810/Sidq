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
 
        this.description,
        this.trueLinks,
        this.falseLinks,
        this.trueVotesCount,
        this.falseVotesCount,
        this.comments,
        this.shareableLink,
        this.title,
        this.briefDescription,
        this.isTrue,
        this.isPublic,
        this.isVotable,
        this.categoryId,
        // this.categoryName,
        this.fileId,
        this.fileLink,
        this.date,
        this.viewsCount,
        this.id,
             this.views,
    });
int ?views;
    String ?description;
    List<Links>? trueLinks;
    List<Links>? falseLinks;
    int ?trueVotesCount;
    int ?falseVotesCount;
    List<Comment> ?comments;
    String ?shareableLink;
    String ?title;
    String? briefDescription;
    bool ?isTrue;
    bool ?isPublic;
    bool ?isVotable;
    String ?categoryId;
    String ?fileId;
    String ?fileLink;
    String? date;
    dynamic  viewsCount;
    String ?id;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
      views: json['viewsCount'],
        description: json["description"],
        trueLinks: json['trueLinks'] !=null ?List<Links>.from(json["trueLinks"]!.map((x) => Links.fromJson(x))):null,
        falseLinks: json['falseLinks']!=null? List<Links>.from(json["falseLinks"]!.map((x) => Links.fromJson(x))):null,
        trueVotesCount: json["trueVotesCount"],
        falseVotesCount: json["falseVotesCount"],
        comments:  json['comments'] !=null? List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))):null,
        shareableLink: json["shareableLink"],
        title: json["title"],
        briefDescription: json["briefDescription"],
        isTrue: json["isTrue"],
        isPublic: json["isPublic"],
        isVotable: json["isVotable"],
        categoryId: json["categoryId"],
        // categoryName: json["categoryName"],
        fileId: json["fileId"],
        fileLink: json["fileLink"],
        date: json["date"],
        viewsCount: json["viewsCount"],
        id: json["id"],
    );

  

    Map<String, dynamic> toJson() => {
        "description": description,
        "trueLinks": List<dynamic>.from(trueLinks!.map((x) => x)),
        "falseLinks": List<dynamic>.from(falseLinks!.map((x) => x)),
        "trueVotesCount": trueVotesCount,
        "falseVotesCount": falseVotesCount,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "shareableLink": shareableLink,
        "title": title,
        "briefDescription": briefDescription,
        "isTrue": isTrue,
        "isPublic": isPublic,
        "isVotable": isVotable,
        "categoryId": categoryId,
        // "categoryName": categoryName!,
        "fileId": fileId,
        "fileLink": fileLink,
        // "date": date.toIso8601String(),
        "viewsCount": viewsCount,
        "id": id,
    };
}

class Comment {
    Comment({
        this.name,
        this.text,
    });

    String?  name;
    String? text;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        name: json["name"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "text": text,
    };
}


class Links {
    Links({
        this.name,
        this.link,
    });

    String?  name;
    String? link;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        name: json["name"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "text": link,
    };
}
