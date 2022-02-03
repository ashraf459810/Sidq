import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/news_details/data/datasources/add_comment.dart';
import 'package:sidq/features/news_details/data/models/comments_response_model.dart';
import 'package:sidq/features/news_details/domain/repositories/add_comment_repository.dart';

class AddCommentRepositoryImp implements AddCommentRepository{
  final AddCommentRemoteData addCommentRemoteData;
  final NetworkInf networkInf ;

  AddCommentRepositoryImp(this.addCommentRemoteData, this.networkInf);

  @override
  Future<Either<Failure, CommentsResponseModel>> addCommentFromrepo(String newsId, String comment) async {
   if (await networkInf.isConnected!){
      try {
        final response = await addCommentRemoteData.addComment(newsId ,comment);

        return Right(response);
      } on ServerException {
        return const Left(ServerFailure("تعذر الاتصال"));
      }
    } else {
      return const Left(NetWorkFailure('تحقق من الاتصال بالانترنت'));
    }
  }
}