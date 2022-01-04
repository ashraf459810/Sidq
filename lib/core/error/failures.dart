import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? error;

  const Failure([this.error]);

  String? getError() {
    return error;
  }

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([String? error]) : super(error);
}

class NetWorkFailure extends Failure {
  const NetWorkFailure([String? error]) : super(error);
}
