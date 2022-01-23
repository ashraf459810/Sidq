import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/news_details/data/datasources/news_details_remote_data.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/domain/repositories/news_details_repositroy.dart';




class NewsDetailsRepositoryImp implements NewsDetailsRepository {
  final NewsDetailsRemoteData newsDetailsRemoteData;
  final NetworkInf networkInf ;

  NewsDetailsRepositoryImp(this.newsDetailsRemoteData, this.networkInf);

  @override
  Future<Either<Failure, NewsDetailsModel>> getNewsRepo(String newsId) async {

      if (await networkInf.isConnected!) {
      try {
        final news = await newsDetailsRemoteData.getNewsDetailsRemoteData(newsId);

        return Right(newsDetailsFromJson(news));
      } on ServerException {
        return const Left(ServerFailure("Error"));
      }
    } else {
      return const Left(NetWorkFailure());
    }

  }

}