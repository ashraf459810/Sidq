// To parse this JSON data, do
//
//     final ticketRequestBody = ticketRequestBodyFromJson(jsonString);

import 'dart:convert';

TicketRequestBody ticketRequestBodyFromJson(String str) => TicketRequestBody.fromJson(json.decode(str));

String ticketRequestBodyToJson(TicketRequestBody data) => json.encode(data.toJson());

class TicketRequestBody {
    TicketRequestBody({
        this.type,
        this.text,
        this.truth,
        this.falseLinks,
        this.truthLinks,
        this.name,
    });

    int? type;
    String ?text;
    String ?truth;
    String ?falseLinks;
    String ?truthLinks;
    String ?name;

    factory TicketRequestBody.fromJson(Map<String, dynamic> json) => TicketRequestBody(
        type: json["type"],
        text: json["text"],
        truth: json["truth"],
        falseLinks: json["falseLinks"],
        truthLinks: json["truthLinks"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "truth": truth,
        "falseLinks": falseLinks,
        "truthLinks": truthLinks,
        "name": name,
    };
}
