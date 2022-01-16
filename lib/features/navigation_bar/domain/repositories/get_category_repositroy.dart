import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/navigation_bar/data/models/category_model.dart';

abstract class GetCategoryRepository {
  Future<Either<Failure, CategoryModel>> getCategoryFromRepo(
      int page, int size);
}
