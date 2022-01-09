import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_fake_news_event.dart';
part 'report_fake_news_state.dart';

class ReportFakeNewsBloc extends Bloc<ReportFakeNewsEvent, ReportFakeNewsState> {
  ReportFakeNewsBloc() : super(ReportFakeNewsInitial()) {
    on<ReportFakeNewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
