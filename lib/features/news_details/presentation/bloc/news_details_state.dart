part of 'news_details_bloc.dart';

abstract class NewsDetailsState extends Equatable {
  const NewsDetailsState();  

  @override
  List<Object> get props => [];
}
class NewsDetailsInitial extends NewsDetailsState {}




class Loading  extends NewsDetailsState{}


class Error extends NewsDetailsState{
  Error(String? error);
}

class GetnewsDetailsState extends NewsDetailsState {
  final NewsDetailsModel newsDetailsModel;

  const GetnewsDetailsState(this.newsDetailsModel);
}