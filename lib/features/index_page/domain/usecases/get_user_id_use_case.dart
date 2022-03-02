import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/index_page/domain/repositories/get_user_id_repository.dart';

abstract class GetUserIdUseCase {
  Future<Either<Failure,String>> getUserIdUsecase ( String deviceToken , String fcmToken);

}


class GetUserIdUseCaseImp implements GetUserIdUseCase {
  final GetUserIdRepository getUserIdRepository ;

  GetUserIdUseCaseImp(this.getUserIdRepository);

  @override
  Future<Either<Failure, String>> getUserIdUsecase(String deviceToken, String fcmToken) async {
    return await getUserIdRepository.getUserIdRepostiroy(deviceToken, fcmToken);
  }

}