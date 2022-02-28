import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/tiny_eye_repositroy.dart';

abstract class TinyEyeUseCase  {

  Future <Either <Failure , TinyEyeModel> >tinyEyeUseCase (String imageUrl , int limit);

}

class TinyEyeUseCaseImp implements TinyEyeUseCase{

  final TinyEyeRepository tinyEyeRepository ;

  TinyEyeUseCaseImp(this.tinyEyeRepository);

  @override
  Future<Either<Failure, TinyEyeModel>> tinyEyeUseCase(String imageUrl, int limit) async {
   return await tinyEyeRepository.tinyEyeRepository(imageUrl, limit);
  } 
  

}