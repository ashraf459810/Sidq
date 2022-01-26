import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/news_details/data/models/vote_response_model.dart';
import 'package:sidq/features/report_fake_news/data/remote_data/add_ticket.dart';
import 'package:sidq/features/news_details/data/datasources/add_vote.dart';
import 'package:sidq/features/news_details/domain/repositories/add_vote_repository.dart';

class AddVoteRepositoryImp implements AddVoteRepository {
  final AddVoteRemoteData addVoteRemoteData;
  final NetworkInf networkInf ;

  AddVoteRepositoryImp(this.addVoteRemoteData, this.networkInf);

  @override
  Future<Either<Failure, VoteResponseModel>> addVoteRepo(String newsId, bool vote) async {
     if (await networkInf.isConnected!) {
      try {
        final news = await addVoteRemoteData.addVote(newsId ,vote);

        return Right(news);
      } on ServerException {
        return const Left(ServerFailure("Error"));
      }
    } else {
      return const Left(NetWorkFailure());
    }
  }


}