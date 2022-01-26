part of 'news_details_bloc.dart';

abstract class NewsDetailsEvent extends Equatable {
  const NewsDetailsEvent();

  @override
  List<Object> get props => [];
}


class GetNewsDetailsEvent extends NewsDetailsEvent {
  final String newsId ;

 const GetNewsDetailsEvent(this.newsId);
}

class AddVoteEvent extends NewsDetailsEvent {
  final String newsId;
  final bool vote ;

const  AddVoteEvent(this.newsId, this.vote);
}

class AddCommentEvent extends NewsDetailsEvent{
 final String newsId;
 final String comment;

 const AddCommentEvent(this.newsId, this.comment);
  
}