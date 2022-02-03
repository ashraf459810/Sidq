import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class NetworkFunctions {
  Future<dynamic> getMethod({required String url, required String baseurl});
  Future<dynamic> postMethod(
      {required String url, required String baseurl, dynamic body});
}

class NetworkFunctionsImp implements NetworkFunctions {
  http.Client client = http.Client();

  @override
  Future<dynamic> getMethod(
      {required String url, required String baseurl}) async {
           final shared = await SharedPreferences.getInstance();
         var token=   shared.getString(Con.token);
          var fcmToken=  shared.getString(Con.fcmToken);
          log(token!);
          log(fcmToken!);

    log('here from htttp');
    final response = await client.get(
      Uri.parse(baseurl + url),
      headers: {
                 'DeviceToken' : token,
          'FCMToken' : fcmToken,
        'Content-Type': 'application/json',
        'Accept-Language':'ar-sy'
      },
    );
    log(response.toString());
    log(baseurl + url);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
    if (response.statusCode == 500) {
      var res = json.decode(response.body);
     
      log("500 here");
      throw ServerException(
        res['error']["message"],
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future postMethod(
      {required String url, required String baseurl, body}) async {
            final shared = await SharedPreferences.getInstance();
         String? token=   shared.getString(Con.token);
          String? fcmToken=  shared.getString(Con.fcmToken);
          log(token!);
          log(fcmToken!);
    final response = await client.post(Uri.parse(baseurl + url),
        headers: {
          'DeviceToken' : token,
          'FCMToken' : fcmToken,
            'Accept-Language':'ar-sy',
          'Content-Type': 'application/json',
        },
        body: body);

    log(baseurl + url);
    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
    if (response.statusCode == 500) {
      var res = json.decode(response.body);
      log(res["message"]);
      log("500 here");
      throw ServerException(
        res["message"],
      );
    } else {
      throw ServerException();
    }
  }
}
