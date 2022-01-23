import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/domain/usecases/news_details_use_case.dart';

part 'news_details_event.dart';
part 'news_details_state.dart';

class NewsDetailsBloc extends Bloc<NewsDetailsEvent, NewsDetailsState> {
  final NewsDetailsUseCase newsDetailsUseCase;
  NewsDetailsBloc(this.newsDetailsUseCase) : super(NewsDetailsInitial()) {
   
    on<NewsDetailsEvent>((event, emit) async {
      if (event is GetNewsDetailsEvent){
        emit(Loading());
        var response = await newsDetailsUseCase.newsDetailsUseCase(event.newsId);
        response.fold((l) => emit(Error(l.error)), (r) => emit(GetnewsDetailsState(r)));
        


      }
    });
  }
}
