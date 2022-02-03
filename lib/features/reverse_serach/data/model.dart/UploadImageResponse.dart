// To parse this JSON data, do
//
//     final uploadImageResponse = uploadImageResponseFromJson(jsonString);

import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) => UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) => json.encode(data.toJson());

class UploadImageResponse {
    UploadImageResponse({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    Result ?result;
    dynamic targetUrl;
    bool? success;
    dynamic error;
    bool ?unAuthorizedRequest;
    bool ?abp;

    factory UploadImageResponse.fromJson(Map<String, dynamic> json) => UploadImageResponse(
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
        this.id,
        this.link,
    });

    String? id;
    String? link;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
    };
}
