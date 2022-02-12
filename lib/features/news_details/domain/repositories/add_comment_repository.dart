import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/data/models/comments_response_model.dart';

abstract class AddCommentRepository {
  Future<Either<Failure,CommentsResponseModel>> addCommentFromrepo(String newsId, String comment,String name);
}