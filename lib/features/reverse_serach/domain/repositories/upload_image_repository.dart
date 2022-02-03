import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/UploadImageResponse.dart';

abstract class UploadImageRepostiry {
  Future<Either<Failure, UploadImageResponse
  >> uploadImageFromRepo(File file);
}
