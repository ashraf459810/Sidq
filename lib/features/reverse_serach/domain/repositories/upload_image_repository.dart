import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';

abstract class UploadImageRepostiry {
  Future<Either<Failure, String>> uploadImageFromRepo(File file);
}
