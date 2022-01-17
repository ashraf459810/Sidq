import 'dart:developer';
import 'dart:io';

import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/network/network_info.dart';

import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:http/http.dart' as http;

abstract class UploadImageRemoteData {
  Future<String> uploadImage(File image);
}

class UploadImageRemoteDataImp implements UploadImageRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  UploadImageRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<String> uploadImage(File image) async {
    final String url = networkInf.baseUrl + '/Common/File/Upload';
    final uri = Uri.parse(url);

    var request = http.MultipartRequest('post', uri);

    var pic = await http.MultipartFile.fromPath("file", image.path);
    request.files.add(pic);

    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = await http.Response.fromStream(response);
      final uploadImage = json.body;

      return uploadImage;
    }
    if (response.statusCode == 500) {
      throw ServerException('error while downloading photo');
    }
    if (response.statusCode == 400) {
      log("400");
    }
    return 'null';
  }
}
