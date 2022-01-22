// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/domain/repositories/get_news_repository.dart';


abstract class GetNewsUseCase {
  Future<Either<Failure, NewsModel>> getMixedNewsUseCase(
      SearchParamsModel searchParamsModel);
}

class GetNewsUseCaseImp implements GetNewsUseCase {
  final GetNewsRepository getNewsRepository;

  GetNewsUseCaseImp(this.getNewsRepository);

  @override
  Future<Either<Failure, NewsModel>> getMixedNewsUseCase(
      SearchParamsModel searchParamsModel) async {
    return await getNewsRepository.getNewsFromRepository(searchParamsModel);
  }
}
