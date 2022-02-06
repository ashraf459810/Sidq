import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';
import 'package:sidq/features/report_fake_news/domain/use_case/add_ticket_use_case.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/upload_image_use_case.dart';


part 'report_fake_news_event.dart';
part 'report_fake_news_state.dart';

class ReportFakeNewsBloc
    extends Bloc<ReportFakeNewsEvent, ReportFakeNewsState> {
      final AddTicketUseCase addTicketUseCase;
      final UploadImageUseCase uploadImageUseCase;
   

  ReportFakeNewsBloc(this.addTicketUseCase, this.uploadImageUseCase, ) : super(ReportFakeNewsInitial()) {
    on<ReportFakeNewsEvent>((event, emit) async {
      if (event is AddTicketEvent){
        emit (Loading());
        
var response = await addTicketUseCase.addTicketUseCase(event.ticketRequestBody);

response.fold((l) => emit(Error(l.error!)), (r) => emit(AddTicketState()));

      }
if (event is UploadPicEvent){
  emit(LoadingImage());
  var response = await uploadImageUseCase.uploadImageUseCase(event.image);
  response.fold((l) => emit(Error(l.error!)), (r) => emit(UploadPicState(r.result!.id!)));

}

  
    });
  }
}
