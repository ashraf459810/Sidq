import 'package:sidq/core/error/exceptions.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/features/home/data/datasources/get_categroy_remote_data.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/domain/repositories/get_category_repositroy.dart';

class GetCategoryRepositroyImp implements GetCategoryRepository {
  final GetCategoryRemoteData getCategoryRemoteData;
  final NetworkInf networkInf;

  GetCategoryRepositroyImp(this.getCategoryRemoteData, this.networkInf);

  @override
  Future<Either<Failure, CategoryModel>> getCategoryFromRepo(
      int page, int size) async {
    if (await networkInf.isConnected!) {
      try {
        final categgories =
            await getCategoryRemoteData.getCategoriesRemoteData(page, size);

        return Right(categoryModelFromJson(categgories));
      } on ServerException {
        return const Left(ServerFailure("Error"));
      }
    } else {
      return const Left(NetWorkFailure('check internet connection'));
    }
  }
}
