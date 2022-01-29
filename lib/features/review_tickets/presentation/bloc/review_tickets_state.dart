part of 'review_tickets_bloc.dart';

abstract class ReviewTicketsState extends Equatable {
  const ReviewTicketsState();  

  @override
  List<Object> get props => [];
}
class ReviewTicketsInitial extends ReviewTicketsState {}


class Error extends ReviewTicketsState {
  final String error;

  const Error(this.error);
}


class Loading extends ReviewTicketsState{}

class GetTicketsState extends ReviewTicketsState{
  final TicketsResponseModel ticketsResponseModel ;

 const GetTicketsState(this.ticketsResponseModel);
}