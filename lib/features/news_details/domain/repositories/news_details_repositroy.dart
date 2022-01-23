import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';


abstract class NewsDetailsRepository {

  Future<Either<Failure,NewsDetailsModel>> getNewsRepo (String newsId);
}

