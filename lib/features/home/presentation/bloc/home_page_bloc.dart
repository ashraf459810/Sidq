
import 'dart:developer';


import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/domain/usecases/get_category_use_case.dart';
import 'package:sidq/features/home/domain/usecases/get_news_use_case.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class NavigationBarBloc
    extends Bloc<NavigationBarBlocEvent, NavigationBarBlocState> {
 
  List<News> news = [];
  bool firstTime = true;
    String? categoryId;
  final GetNewsUseCase getNewsUseCase;
  final GetCategroyUseCase getCategroyUseCase;
  NavigationBarBloc(this.getNewsUseCase, this.getCategroyUseCase)
      : super(NavigationBarBlocInitial()) {
    on<NavigationBarBlocEvent>((event, emit) async {
      if (event is GetCategoriesEvent) {

        try {
        log('here  from bloc');
        emit(LoadingCategory());
        final response = await getCategroyUseCase.getCategoriesUseCase(
            event.page, event.size);
        response.fold((l) => emit(Error(l.error.toString())),
            (r) => emit(GetCategoriesState(r)));
      } catch (e){
        emit(Error(e.toString()));
      }
      }
      if (event is GetNewsEvent) {
        
        if (firstTime&& event.searchParamsModel.categoryId!=null){
        categoryId = event.searchParamsModel.categoryId;
        firstTime = false;
          news =[];
        }
        emit(LoadingNews());
        
       if  ( !firstTime &&event.searchParamsModel.categoryId !=null && categoryId != event.searchParamsModel.categoryId!){
         categoryId = event.searchParamsModel.categoryId;
         news =[];
       }
   
      

        final response =
            await getNewsUseCase.getMixedNewsUseCase(event.searchParamsModel);
        response.fold((l) => emit(Error(l.error!)), (r) {
          if (news.isEmpty) {
            news = r.result!;
            NewsModel newsModel = NewsModel(result: news);
              emit(GetNewsState(newsModel));
            
          } else if (!event.resetList){
            news.addAll(r.result!);
                NewsModel newsModel = NewsModel(result: news);
              emit(GetNewsState(newsModel));
       
          }
          else {
              news = r.result!;
            NewsModel newsModel = NewsModel(result: news);
              emit(GetNewsState(newsModel));

          }
             
        });
      }
      if (event is SearchNewsEvent){
        
        emit(LoadingNews());
        var response = await getNewsUseCase.getMixedNewsUseCase(event.query);
        response.fold((l) => emit(Error(l.error!)), (r) => emit(SearchNewsState(r)));
        
      }
    });
  }





  }

