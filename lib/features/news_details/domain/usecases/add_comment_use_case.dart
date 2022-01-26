import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/domain/repositories/add_comment_repository.dart';


abstract class AddCommentUseCase {
  Future<Either<Failure, List<String>>> addCommentUseCase (String newsId, String comment);
}


class AddCommentUseCaseImp implements AddCommentUseCase {
  final AddCommentRepository addCommentRepository ;

  AddCommentUseCaseImp(this.addCommentRepository);





  @override
  Future<Either<Failure, List<String>>> addCommentUseCase(String newsId, String comment) async {
  return await addCommentRepository.addCommentFromrepo(newsId, comment);
   
  }
  
}