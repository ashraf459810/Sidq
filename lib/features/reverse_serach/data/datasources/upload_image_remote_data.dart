
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/network/network_info.dart';

import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:http/http.dart' as http;
import 'package:sidq/features/reverse_serach/data/model.dart/upload_image_response.dart';

abstract class UploadImageRemoteData {
  Future<dynamic> uploadImage(File image);
}

class UploadImageRemoteDataImp implements UploadImageRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  UploadImageRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<dynamic> uploadImage(File image) async {
    final String url = networkInf.baseUrl + '/Common/File/Upload';
    final uri = Uri.parse(url);

    var request = http.MultipartRequest('post', uri,);

    var pic = await http.MultipartFile.fromPath("file", image.path);
    request.files.add(pic);
    request.headers.addAll({'Accept-Language':'ar-sy' });

    var response = await request.send();
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      var jsonn = await http.Response.fromStream(response);

      final uploadImage = jsonn.body;
     

      return uploadImageResponseFromJson(uploadImage);
    }
    if (response.statusCode == 500) {

    var jsonn = await http.Response.fromStream(response);

      final uploadImage = jsonn.body;
      final error = json.decode(uploadImage);

      print(error);

      throw ServerException(error['error']['message']);
    }

    return 'null';
  }
}
