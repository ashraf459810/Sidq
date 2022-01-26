import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';

abstract class AddVoteRepository {
  Future<Either<Failure,void>> addVoteRepo (String newsId , bool vote);
}




