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