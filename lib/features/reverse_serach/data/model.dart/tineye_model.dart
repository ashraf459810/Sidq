// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TinyEyeModel tinyEyeFromJson(String str) => TinyEyeModel.fromJson(json.decode(str));

String welcomeToJson(TinyEyeModel data) => json.encode(data.toJson());

class TinyEyeModel {
    TinyEyeModel({
        required this.results,
        required this.stats,
        required this.code,
        required this.messages,
    });

    Results results;
    Stats stats;
    int code;
    List<dynamic> messages;

    factory TinyEyeModel.fromJson(Map<String, dynamic> json) => TinyEyeModel(
        results: Results.fromJson(json["results"]),
        stats: Stats.fromJson(json["stats"]),
        code: json["code"],
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "results": results.toJson(),
        "stats": stats.toJson(),
        "code": code,
        "messages": List<dynamic>.from(messages.map((x) => x)),
    };
}

class Results {
    Results({
        required this.matches,
    });

    List<Match> matches;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
    };
}

class Match {
    Match({
        required this.queryHash,
    required    this.score,
     required   this.backlinks,
     required   this.format,
    required    this.width,
    required    this.height,
    required    this.filesize,
    required    this.size,
    required    this.overlay,
    required    this.imageUrl,
    required    this.domain,
    required    this.domainUnavailable,
    required    this.tags,
    });

    String queryHash;
    double score;
    List<Backlink> backlinks;
    String format;
    int width;
    int height;
    int filesize;
    int size;
    String overlay;
    String imageUrl;
    String domain;
    bool domainUnavailable;
    List<String> tags;

    factory Match.fromJson(Map<String, dynamic> json) => Match(
        queryHash: json["query_hash"],
        score: json["score"].toDouble(),
        backlinks: List<Backlink>.from(json["backlinks"].map((x) => Backlink.fromJson(x))),
        format: json["format"],
        width: json["width"],
        height: json["height"],
        filesize: json["filesize"],
        size: json["size"],
        overlay: json["overlay"],
        imageUrl: json["image_url"],
        domain: json["domain"],
        domainUnavailable: json["domain_unavailable"],
        tags: List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "query_hash": queryHash,
        "score": score,
        "backlinks": List<dynamic>.from(backlinks.map((x) => x.toJson())),
        "format": format,
        "width": width,
        "height": height,
        "filesize": filesize,
        "size": size,
        "overlay": overlay,
        "image_url": imageUrl,
        "domain": domain,
        "domain_unavailable": domainUnavailable,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}

class Backlink {
    Backlink({
     required   this.backlink,
     required   this.crawlDate,

     required   this.url,
    });

    String backlink;
    DateTime crawlDate;

    String url;

    factory Backlink.fromJson(Map<String, dynamic> json) => Backlink(
        backlink: json["backlink"],
        crawlDate: DateTime.parse(json["crawl_date"]),
        // sourceId: json["source_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "backlink": backlink,
        "crawl_date": "${crawlDate.year.toString().padLeft(4, '0')}-${crawlDate.month.toString().padLeft(2, '0')}-${crawlDate.day.toString().padLeft(2, '0')}",
        // "source_id": sourceId,
        "url": url,
    };
}

class Stats {
    Stats({
     required   this.queryTime,
    required    this.timestamp,
    required    this.totalBacklinks,
    required    this.totalCollection,
    required    this.totalResults,
    required    this.totalFilteredResults,
    required    this.totalStock,
    });

    int queryTime;
    int timestamp;
    int totalBacklinks;
    int totalCollection;
    int totalResults;
    int totalFilteredResults;
    int totalStock;

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        queryTime: json["query_time"],
        timestamp: json["timestamp"],
        totalBacklinks: json["total_backlinks"],
        totalCollection: json["total_collection"],
        totalResults: json["total_results"],
        totalFilteredResults: json["total_filtered_results"],
        totalStock: json["total_stock"],
    );

    Map<String, dynamic> toJson() => {
        "query_time": queryTime,
        "timestamp": timestamp,
        "total_backlinks": totalBacklinks,
        "total_collection": totalCollection,
        "total_results": totalResults,
        "total_filtered_results": totalFilteredResults,
        "total_stock": totalStock,
    };
}
