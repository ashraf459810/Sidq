import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';
import 'package:sidq/features/review_tickets/domain/repositories/get_tickets_repository.dart';

abstract class GetTicketsUseCase {
  Future<Either<Failure,TicketsResponseModel>> getTickets(int ? type);
}

class GetTicketsUseCaseImp implements GetTicketsUseCase {
  final GetTicketsRepository getTicketsRepository ;

  GetTicketsUseCaseImp(this.getTicketsRepository);

  @override
  Future<Either<Failure, TicketsResponseModel>> getTickets(int ? type) async {
   return await getTicketsRepository.getTickets(type);
  }
  
}