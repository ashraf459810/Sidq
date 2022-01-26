import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/data/models/vote_response_model.dart';

abstract class AddVoteRepository {
  Future<Either<Failure,VoteResponseModel
  >> addVoteRepo (String newsId , bool vote);
}




