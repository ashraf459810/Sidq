import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/review_tickets/data/datasources/get_tickets_remote_data.dart';
import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';
import 'package:sidq/features/review_tickets/domain/repositories/get_tickets_repository.dart';

class GetTicketsRepositroyImp implements GetTicketsRepository {
  final GetTicketsRemoteData getTicketsRemoteData;
  final NetworkInf networkInf ;

  GetTicketsRepositroyImp(this.getTicketsRemoteData, this.networkInf);

  @override
  Future<Either<Failure, TicketsResponseModel>> getTickets(int ? type) async {
       if (await networkInf.isConnected!) {
      try {
        final result = await getTicketsRemoteData.getTickers(type);

        return Right(result);
       } on ServerException {
        return const Left(ServerFailure("تعذر الاتصال"));
      }
    } else {
      return const Left(NetWorkFailure('تحقق من الاتصال بالانترنت'));
    }
  }
}