import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/upload_image_repository.dart';

abstract class UploadImageUseCase {
  Future<Either<Failure, String>> uploadImageUseCase(File file);
}

class UploadImageUseCaseImp implements UploadImageUseCase {
  final UploadImageRepostiry uploadImageRepostiry;

  UploadImageUseCaseImp(this.uploadImageRepostiry);

  @override
  Future<Either<Failure, String>> uploadImageUseCase(File file) async {
    return await uploadImageRepostiry.uploadImageFromRepo(file);
  }
}
