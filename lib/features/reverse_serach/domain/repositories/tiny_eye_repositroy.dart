import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';

abstract class TinyEyeRepository {
  Future <Either <Failure  , TinyEyeModel >> tinyEyeRepository (String imageUrl , int limit);
}



