import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/index_page/data/datasources/get_user_d_remote_data.dart';
import 'package:sidq/features/index_page/domain/repositories/get_user_id_repository.dart';

class GetUserIdRepostiroyImp implements GetUserIdRepository {
  final NetworkInf networkInf ;
  final GetUserIdRemoteData getUserIdRemoteData;

  GetUserIdRepostiroyImp(this.networkInf, this.getUserIdRemoteData);

  @override
  Future<Either<Failure, String>> getUserIdRepostiroy(String deviceToken, String fcmToken) async {
   
        if (await networkInf.isConnected!) {
      try {
        final id = await getUserIdRemoteData.getUserId(deviceToken,fcmToken);

        return Right(id);
       } on ServerException {
        return const Left(ServerFailure("تعذر الاتصال"));
      }
    } else {
      return const Left(NetWorkFailure('تحقق من الاتصال بالانترنت'));
    }
  }}