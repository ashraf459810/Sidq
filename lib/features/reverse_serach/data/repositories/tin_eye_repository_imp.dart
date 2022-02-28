import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/reverse_serach/data/datasources/tin_eye_remote_data.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/tiny_eye_repositroy.dart';

class TinyEyeRepositoryImp implements  TinyEyeRepository {

  final TinEyeRemoteData tinEyeRemoteData;
  final NetworkInf networkInf ;

  TinyEyeRepositoryImp(this.tinEyeRemoteData, this.networkInf);

  @override
  Future<Either<Failure, TinyEyeModel>> tinyEyeRepository(String imageUrl, int limit) async {
      if (await networkInf.isConnected!) {
      try {
        final result = await tinEyeRemoteData.tinEyeRemoteData(imageUrl,limit);

        return Right(result);
      
       } on ServerException {
        return const Left(ServerFailure("تعذر الاتصال"));
      }
    } else {
      return const Left(NetWorkFailure('تحقق من الاتصال بالانترنت'));
    }
  } 
}