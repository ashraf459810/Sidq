
import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';
import 'package:sidq/features/report_fake_news/domain/repository/add_ticket_repository.dart';

abstract class AddTicketUseCase {
  Future<Either<Failure, void >> addTicketUseCase (TicketRequestBody ticketRequestBody);
}



class AddTicketUseCaseImp implements AddTicketUseCase{

  final AddTicketRepository addTicketRepository;

  AddTicketUseCaseImp(this.addTicketRepository);

  @override
  Future<Either<Failure, void>> addTicketUseCase(TicketRequestBody ticketRequestBody) async {
   return await addTicketRepository.addTicketRepo(ticketRequestBody);
  }
}