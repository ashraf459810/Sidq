// To parse this JSON data, do
//
//     final searchParamsModel = searchParamsModelFromJson(jsonString);

import 'dart:convert';

SearchParamsModel searchParamsModelFromJson(String str) =>
    SearchParamsModel.fromJson(json.decode(str));

String searchParamsModelToJson(SearchParamsModel data) =>
    json.encode(data.toJson());

class SearchParamsModel {
  SearchParamsModel({
    this.searchQuery,
    this.pageNumber,
    this.pageLength,
    this.orderDescending,
    this.isTrue,
    this.isVotable,
    this.categoryId,
  });

  String? searchQuery;
  int? pageNumber;
  int? pageLength;
  bool? orderDescending;
  bool? isTrue;

  bool? isVotable;
  String? categoryId;

  factory SearchParamsModel.fromJson(Map<String, dynamic> json) =>
      SearchParamsModel(
        searchQuery: json["searchQuery"],
        pageNumber: json["pageNumber"],
        pageLength: json["pageLength"],
        orderDescending: json["orderDescending"],
        isTrue: json["isTrue"],
        isVotable: json["isVotable"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "searchQuery": searchQuery,
        "pageNumber": pageNumber,
        "pageLength": pageLength,
        "orderDescending": orderDescending,
        "isTrue": isTrue,
        "isVotable": isVotable,
        "categoryId": categoryId,
      };
}
