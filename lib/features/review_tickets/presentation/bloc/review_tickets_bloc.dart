import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';
import 'package:sidq/features/review_tickets/domain/usecases/get_tickets_use_case.dart';

part 'review_tickets_event.dart';
part 'review_tickets_state.dart';

class ReviewTicketsBloc extends Bloc<ReviewTicketsEvent, ReviewTicketsState> {
  final GetTicketsUseCase getTicketsUseCase;
  ReviewTicketsBloc(this.getTicketsUseCase) : super(ReviewTicketsInitial()) {

    on<ReviewTicketsEvent>((event, emit) async {
 if (event is GetTicketsEvent){
   emit (Loading());
   var response = await getTicketsUseCase.getTickets(event.type);
   response.fold((l) => emit(Error(l.error!)), (r) => emit(GetTicketsState(r)));
 }
    });
  }
}
