import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/domain/repositories/news_details_repositroy.dart';

abstract class NewsDetailsUseCase {

  Future<Either<Failure,NewsDetailsModel>> newsDetailsUseCase (String newsId);
}




class NewsDetailsUseCaseImp implements NewsDetailsUseCase {
  final NewsDetailsRepository newsDetailsRepository;

  NewsDetailsUseCaseImp(this.newsDetailsRepository);

  @override
  Future<Either<Failure, NewsDetailsModel>> newsDetailsUseCase(String newsId) async {
    return await newsDetailsRepository.getNewsRepo(newsId);
  }
  
}