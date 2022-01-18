import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/home/data/datasources/get_news_remote.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/domain/repositories/get_news_repository.dart';


class GetNewsRepositoryImp implements GetNewsRepository {
  final GetNewsRemoteData getNewsRemoteData;
  final NetworkInf networkInf;

  GetNewsRepositoryImp(
    this.getNewsRemoteData,
    this.networkInf,
  );

  @override
  Future<Either<Failure, List<NewsModel>>> getNewsFromRepository(
      SearchParamsModel searchParamsModel) async {
    if (await networkInf.isConnected!) {
      try {
        final news = await getNewsRemoteData.getMixedNews(searchParamsModel);

        return Right(newsModelFromJson(news));
      } on ServerException {
        return const Left(ServerFailure("Error"));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }
}
