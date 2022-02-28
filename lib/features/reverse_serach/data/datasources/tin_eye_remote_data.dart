

import 'dart:math';

import 'package:http/http.dart';
import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';

abstract class TinEyeRemoteData {
  Future <dynamic> tinEyeRemoteData (String imageUrl , int limit );
}


class TinEyeRemoteDataImp implements TinEyeRemoteData {
  final NetworkInf networkInf ;
  final Client client ;

  TinEyeRemoteDataImp(this.networkInf , this.client);

  @override
  Future tinEyeRemoteData(String imageUrl, int limit) async {

    print('here from remote data');
print(imageUrl);

   final result  = await client.get(Uri.parse('https://api.tineye.com/rest/search/?image_url=$imageUrl&limit=$limit'),headers: {
     "x-api-key" : "rl9-JYTGhdISxMcTWBTi=tqQQyZK.sbK+N1zB6bk"}


  );

  print(result.body);
    print(result.statusCode);
   if (result.statusCode==200){
     print('200');
     return tinyEyeFromJson(result.body);
   }

   else {
     throw ServerException('خطآ في المخدم');
   }
    
  }
  
}