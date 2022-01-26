// To parse this JSON data, do
//
//     final voteResponseModel = voteResponseModelFromJson(jsonString);

import 'dart:convert';

VoteResponseModel voteResponseModelFromJson(String str) => VoteResponseModel.fromJson(json.decode(str));

String voteResponseModelToJson(VoteResponseModel data) => json.encode(data.toJson());

class VoteResponseModel {
    VoteResponseModel({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    Result? result;
    dynamic? targetUrl;
    bool? success;
    dynamic error;
    bool? unAuthorizedRequest;
    bool? abp;

    factory VoteResponseModel.fromJson(Map<String, dynamic> json) => VoteResponseModel(
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
        this.trueVotesCounts,
        this.falseVotesCounts,
    });

    int ? trueVotesCounts;
    int ?falseVotesCounts;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        trueVotesCounts: json["trueVotesCounts"],
        falseVotesCounts: json["falseVotesCounts"],
    );

    Map<String, dynamic> toJson() => {
        "trueVotesCounts": trueVotesCounts,
        "falseVotesCounts": falseVotesCounts,
    };
}
