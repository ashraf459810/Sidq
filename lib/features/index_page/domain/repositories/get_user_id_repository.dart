import 'package:dartz/dartz.dart';
import 'package:sidq/core/error/failures.dart';

abstract class GetUserIdRepository{
  Future<Either<Failure,String> >getUserIdRepostiroy (String deviceToken, String fcmToken);
}