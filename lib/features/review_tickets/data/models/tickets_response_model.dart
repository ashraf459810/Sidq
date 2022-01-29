// To parse this JSON data, do
//
//     final ticketsResponseModel = ticketsResponseModelFromJson(jsonString);

import 'dart:convert';

TicketsResponseModel ticketsResponseModelFromJson(String str) => TicketsResponseModel.fromJson(json.decode(str));

String ticketsResponseModelToJson(TicketsResponseModel data) => json.encode(data.toJson());

class TicketsResponseModel {
    TicketsResponseModel({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    List<Result> ?result;
    dynamic targetUrl;
    bool? success;
    dynamic error;
    bool ?unAuthorizedRequest;
    bool ?abp;

    factory TicketsResponseModel.fromJson(Map<String, dynamic> json) => TicketsResponseModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
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

class Result {
    Result({
        this.type,
        this.text,
        this.answer,
        this.clientTokenId,
        this.clientTokenDeviceToken,
        this.answeredById,
        this.answeredBy,
        this.truth,
        this.falseLinks,
        this.truthLinks,
        this.name,
        this.id,
    });

    int ?type;
    String ?text;
    dynamic answer;
    String ?clientTokenId;
    dynamic clientTokenDeviceToken;
    dynamic answeredById;
    String ?answeredBy;
    String? truth;
    String ?falseLinks;
    String ?truthLinks;
    String ?name;
    String? id;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json["type"],
        text: json["text"],
        answer: json["answer"],
        clientTokenId: json["clientTokenId"],
        clientTokenDeviceToken: json["clientTokenDeviceToken"],
        answeredById: json["answeredById"],
        answeredBy: json["answeredBy"],
        truth: json["truth"],
        falseLinks: json["falseLinks"],
        truthLinks: json["truthLinks"],
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "answer": answer,
        "clientTokenId": clientTokenId,
        "clientTokenDeviceToken": clientTokenDeviceToken,
        "answeredById": answeredById,
        "answeredBy": answeredBy,
        "truth": truth,
        "falseLinks": falseLinks,
        "truthLinks": truthLinks,
        "name": name,
        "id": id,
    };
}
