// To parse this JSON data, do
//
//     final voteRequestModel = voteRequestModelFromJson(jsonString);

import 'dart:convert';

VoteRequestModel voteRequestModelFromJson(String str) => VoteRequestModel.fromJson(json.decode(str));

String voteRequestModelToJson(VoteRequestModel data) => json.encode(data.toJson());

class VoteRequestModel {
    VoteRequestModel({
        this.newsId,
        this.isTrue,
    });

    String? newsId;
    bool? isTrue;

    factory VoteRequestModel.fromJson(Map<String, dynamic> json) => VoteRequestModel(
        newsId: json["newsId"],
        isTrue: json["isTrue"],
    );

    Map<String, dynamic> toJson() => {
        "newsId": newsId,
        "isTrue": isTrue,
    };
}
