import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';

import '../../../../injection_container.dart';

abstract class GetUserIdRemoteData {
  Future<String> getUserId (String deviceToken , String fcmToken);
}


class GetUserIdRemoteDataImp implements GetUserIdRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  GetUserIdRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<String> getUserId(String deviceToken, String fcmToken) async {

    log(networkInf.baseUrl+'/Client/Home/GetClientId' );
       SharedPreferences sharedPreferences = sl<SharedPreferences>();
    var token = sharedPreferences.getString("token");
    var fcmToken  = sharedPreferences.getString("fcmToken");
    var map  = {
       "deviceToken" : token,
        "fcmToken" : fcmToken


    };
    var data = json.encode(map);
    
 
   var response = await networkFunctions.postMethod(url: '/Client/Home/GetClientId', baseurl: networkInf.baseUrl,body: 
   data
   );
   var result   = json.decode(response);
    return result['result'];
  }
 
}