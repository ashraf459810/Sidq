import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/domain/repositories/get_category_repositroy.dart';

abstract class GetCategroyUseCase {
  Future<Either<Failure, CategoryModel>> getCategoriesUseCase(
      int page, int size);
}

class GetCategoryUseCaseImp implements GetCategroyUseCase {
  final GetCategoryRepository getCategoryRepository;

  GetCategoryUseCaseImp(this.getCategoryRepository);

  @override
  Future<Either<Failure, CategoryModel>> getCategoriesUseCase(
      int page, int size) async {
    return await getCategoryRepository.getCategoryFromRepo(page, size);
  }
}
