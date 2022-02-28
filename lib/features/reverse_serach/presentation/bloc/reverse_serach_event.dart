part of 'reverse_serach_bloc.dart';

abstract class ReverseSerachEvent extends Equatable {
  const ReverseSerachEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends ReverseSerachEvent {
  final File imageLink;

  const UploadImageEvent(this.imageLink);
}


class TinyEyeEvent extends ReverseSerachEvent {

  final String imageUrl ;

  const TinyEyeEvent(this.imageUrl);

}