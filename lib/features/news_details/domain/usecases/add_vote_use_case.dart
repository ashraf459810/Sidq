import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/news_details/domain/repositories/add_vote_repository.dart';

abstract class AddVoteUseCase {
  Future<Either<Failure,void>> addVoteUseCase(String newsId , bool vote);
}



class AddVoteUseCaseImp implements AddVoteUseCase{
  final AddVoteRepository addVoteRepository;

  AddVoteUseCaseImp(this.addVoteRepository);

  @override
  Future<Either<Failure, void>> addVoteUseCase(String newsId, bool vote) async {
   return await addVoteRepository.addVoteRepo(newsId, vote);
  }
  
}