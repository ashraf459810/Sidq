import 'dart:convert';

import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/news_details/data/models/comments_response_model.dart';

abstract class AddCommentRemoteData {
  Future<CommentsResponseModel> addComment(String newsId, String comment,String name);
}


class AddCommentRemoteDataImp implements AddCommentRemoteData {
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions ;

  AddCommentRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future<CommentsResponseModel> addComment(String newsId, String comment , String name) async {
    Map<String , String>  body= {};
    body.addAll({"newsId":newsId,"text":comment , "name" : name});
   var response =await networkFunctions.postMethod(body: json.encode(body) ,
     url: '/Client/Comment/Create', baseurl: networkInf.baseUrl);

     return commentsResponseModelFromJson(response);
  }
}