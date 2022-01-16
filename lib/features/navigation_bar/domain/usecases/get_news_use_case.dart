import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/navigation_bar/data/models/news_model.dart';
import 'package:sidq/features/navigation_bar/data/models/search_params_model.dart';
import 'package:sidq/features/navigation_bar/domain/repositories/get_news_repository.dart';

abstract class GetNewsUseCase {
  Future<Either<Failure, List<NewsModel>>> getMixedNewsUseCase(
      SearchParamsModel searchParamsModel);
}

class GetNewsUseCaseImp implements GetNewsUseCase {
  final GetNewsRepository getNewsRepository;

  GetNewsUseCaseImp(this.getNewsRepository);

  @override
  Future<Either<Failure, List<NewsModel>>> getMixedNewsUseCase(
      SearchParamsModel searchParamsModel) async {
    return await getNewsRepository.getNewsFromRepository(searchParamsModel);
  }
}
