import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';
import 'package:sidq/features/report_fake_news/data/remote_data/add_ticket.dart';
import 'package:sidq/features/report_fake_news/domain/repository/add_ticket_repository.dart';

class AddTicketRepositoryImp implements AddTicketRepository {
  final AddTicketRemoteData addTicketRemoteData;
  final NetworkInf networkInf;

  AddTicketRepositoryImp(this.addTicketRemoteData, this.networkInf);

  @override
  Future<Either<Failure, void>> addTicketRepo(TicketRequestBody ticketRequestBody) async {


        if (await networkInf.isConnected!) {
      try {
        final news = await addTicketRemoteData.addTicket(ticketRequestBody);

        return Right(news);
      } on ServerException {
        return const Left(ServerFailure("Error"));
      }
    } else {
      return const Left(NetWorkFailure('please check your connection'));
    }
  }
}