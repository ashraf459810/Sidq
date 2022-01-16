import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/navigation_bar/data/models/news_model.dart';
import 'package:sidq/features/navigation_bar/data/models/search_params_model.dart';

abstract class GetNewsRepository {
  Future<Either<Failure, List<NewsModel>>> getNewsRepository(
      SearchParamsModel searchParamsModel);
}
