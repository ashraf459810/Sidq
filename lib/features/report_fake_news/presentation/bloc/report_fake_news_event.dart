part of 'report_fake_news_bloc.dart';

abstract class ReportFakeNewsEvent extends Equatable {
  const ReportFakeNewsEvent();

  @override
  List<Object> get props => [];
}

class AddTicketEvent  extends ReportFakeNewsEvent {
  final TicketRequestBody ticketRequestBody ;

 const AddTicketEvent(this.ticketRequestBody);
}


class UploadPicEvent extends ReportFakeNewsEvent{
  final File image;

  const UploadPicEvent(this.image);
}