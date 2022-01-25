import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';

abstract class AddTicketRepository {
  Future<Either<Failure,void> > addTicketRepo (TicketRequestBody ticketRequestBody);
}



