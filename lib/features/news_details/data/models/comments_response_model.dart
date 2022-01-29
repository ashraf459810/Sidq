// To parse this JSON data, do
//
//     final commentsResponseModel = commentsResponseModelFromJson(jsonString);

import 'dart:convert';

CommentsResponseModel commentsResponseModelFromJson(String str) => CommentsResponseModel.fromJson(json.decode(str));

String commentsResponseModelToJson(CommentsResponseModel data) => json.encode(data.toJson());

class CommentsResponseModel {
    CommentsResponseModel({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    List<String>? result;
    dynamic targetUrl;
    bool? success;
    dynamic error;
    bool ?unAuthorizedRequest;
    bool? abp;

    factory CommentsResponseModel.fromJson(Map<String, dynamic> json) => CommentsResponseModel(
        result: List<String>.from(json["result"].map((x) => x)),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x)),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
    };
}
