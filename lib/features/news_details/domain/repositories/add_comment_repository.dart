import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';

abstract class AddCommentRepository {
  Future<Either<Failure,List<String>>> addCommentFromrepo(String newsId, String comment);
}