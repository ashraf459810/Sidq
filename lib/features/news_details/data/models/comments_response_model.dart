// To parse this JSON data, do
//
//     final commentsResponseModel = commentsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:sidq/features/news_details/data/models/news_details.dart';

CommentsResponseModel commentsResponseModelFromJson(String str) => CommentsResponseModel.fromJson(json.decode(str));

String commentsResponseModelToJson(CommentsResponseModel data) => json.encode(data.toJson());

class CommentsResponseModel {
    CommentsResponseModel({
        this.comments,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    List<Comment>? comments;
    dynamic targetUrl;
    bool ?success;
    dynamic error;
    bool ?unAuthorizedRequest;
    bool ?abp;

    factory CommentsResponseModel.fromJson(Map<String, dynamic> json) => CommentsResponseModel(
       comments:  json['result'] !=null? List<Comment>.from(json["result"]!.map((x) => Comment.fromJson(x))):null,
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
    };
}


