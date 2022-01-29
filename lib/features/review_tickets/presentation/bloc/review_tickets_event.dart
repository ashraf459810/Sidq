part of 'review_tickets_bloc.dart';

abstract class ReviewTicketsEvent extends Equatable {
  const ReviewTicketsEvent();

  @override
  List<Object> get props => [];
}



class GetTicketsEvent extends ReviewTicketsEvent {}