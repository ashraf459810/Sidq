import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';

abstract class GetNewsRepository {
  Future<Either<Failure, NewsModel>> getNewsFromRepository(
      SearchParamsModel searchParamsModel);
}
