import 'dart:io';

import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/reverse_serach/data/datasources/upload_image_remote_data.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/upload_image_response.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/upload_image_repository.dart';

class UploadImageRepositoryImp implements UploadImageRepostiry {
  final UploadImageRemoteData uploadImageRemoteData;
  final NetworkInf networkInf;

  UploadImageRepositoryImp(this.uploadImageRemoteData, this.networkInf);

  @override
  Future<Either<Failure, UploadImageResponse>> uploadImageFromRepo(File file) async {
    if (await networkInf.isConnected!) {
      try {
        final result = await uploadImageRemoteData.uploadImage(file);

        return Right(result);
      } on ServerException catch(e) {
        return  Left(ServerFailure(e.error));
      }
    } else {
      return const Left(NetWorkFailure('تحقق من الاتصال بالانترنت'));
    }
  }
}
