import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/data/models/comments_response_model.dart';
import 'package:sidq/features/news_details/domain/repositories/add_comment_repository.dart';


abstract class AddCommentUseCase {
  Future<Either<Failure, CommentsResponseModel>> addCommentUseCase (String newsId, String comment,String name);
}


class AddCommentUseCaseImp implements AddCommentUseCase {
  final AddCommentRepository addCommentRepository ;

  AddCommentUseCaseImp(this.addCommentRepository);





  @override
  Future<Either<Failure, CommentsResponseModel>> addCommentUseCase(String newsId, String comment,String name) async {
  return await addCommentRepository.addCommentFromrepo(newsId, comment,name);
   
  }
  
}