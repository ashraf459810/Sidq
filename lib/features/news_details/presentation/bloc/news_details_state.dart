part of 'news_details_bloc.dart';

abstract class NewsDetailsState extends Equatable {
  const NewsDetailsState();  

  @override
  List<Object> get props => [];
}
class NewsDetailsInitial extends NewsDetailsState {}




class Loading  extends NewsDetailsState{}


class Error extends NewsDetailsState{
  final String error;
  const Error(this. error);
}

class GetnewsDetailsState extends NewsDetailsState {
  final NewsDetailsModel newsDetailsModel;

  const GetnewsDetailsState(this.newsDetailsModel);
}


class AddVoteState extends NewsDetailsState {
 final VoteResponseModel voteResponseModel;

const  AddVoteState(this.voteResponseModel);
 
}

class LoadingVote extends NewsDetailsState{}


class AddCommentState extends NewsDetailsState {
  final List<String>comments;

 const AddCommentState(this.comments);
}