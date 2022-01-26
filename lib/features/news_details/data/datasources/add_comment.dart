import 'dart:convert';

import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';

abstract class AddCommentRemoteData {
  Future<List<String>> addComment(String newsId, String comment);
}


class AddCommentRemoteDataImp implements AddCommentRemoteData {
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions ;

  AddCommentRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future<List<String>> addComment(String newsId, String comment) async {
    Map<String , String>  body= {};
    body.addAll({"newsId":newsId,"text":comment});
   return await networkFunctions.postMethod(body: json.encode(body) ,
     url: '/Client/Comment/Create', baseurl: networkInf.baseUrl);
  }
}