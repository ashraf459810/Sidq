part of 'reverse_serach_bloc.dart';

abstract class ReverseSerachState extends Equatable {
  const ReverseSerachState();

  @override
  List<Object> get props => [];
}

class ReverseSerachInitial extends ReverseSerachState {}

class UploadImageState extends ReverseSerachState {
  final String result;

  const UploadImageState(this.result);
}

class Error extends ReverseSerachState {
  final String result;

  const Error(this.result);
}

class Loading extends ReverseSerachState {}


class TinyEyeState extends ReverseSerachState {
 final TinyEyeModel tinyEyeModel ;

 const TinyEyeState(this.tinyEyeModel);
}