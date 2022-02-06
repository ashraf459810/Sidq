part of 'report_fake_news_bloc.dart';

abstract class ReportFakeNewsState extends Equatable {
  const ReportFakeNewsState();  

  @override
  List<Object> get props => [];
}
class ReportFakeNewsInitial extends ReportFakeNewsState {}




class AddTicketState extends ReportFakeNewsState{}


class Error extends ReportFakeNewsState {
  final String error ;

  const Error(this.error);
}

class Loading extends ReportFakeNewsState{

}

class UploadPicState extends ReportFakeNewsState {
  final String id;

  const UploadPicState(this.id);
}

class LoadingImage extends ReportFakeNewsState {}