import 'dart:convert';
import 'dart:developer';

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
    log('here from htttp');
    final response = await client.get(
      Uri.parse(baseurl + url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response);
    log(baseurl + url);
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

  @override
  Future postMethod(
      {required String url, required String baseurl, body}) async {
    final response = await client.post(Uri.parse(baseurl + url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);

    log(baseurl + url);
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
