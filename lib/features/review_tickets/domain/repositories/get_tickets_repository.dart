import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';

abstract class GetTicketsRepository {
  Future <Either<Failure,TicketsResponseModel>> getTickets (int ? type);
}