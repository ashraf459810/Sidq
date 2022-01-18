// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';
import 'package:sidq/features/home/data/models/category_model.dart';


abstract class GetCategoryRepository {
  Future<Either<Failure, CategoryModel>> getCategoryFromRepo(
      int page, int size);
}
