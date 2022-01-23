import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
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
    extends HydratedBloc<NavigationBarBlocEvent, NavigationBarBlocState> {
  List<News> news = [];
  final GetNewsUseCase getNewsUseCase;
  final GetCategroyUseCase getCategroyUseCase;
  NavigationBarBloc(this.getNewsUseCase, this.getCategroyUseCase)
      : super(NavigationBarBlocInitial()) {
    on<NavigationBarBlocEvent>((event, emit) async {
      if (event is GetCategoriesEvent) {
        log('here  from bloc');
        emit(LoadingCategory());
        final response = await getCategroyUseCase.getCategoriesUseCase(
            event.page, event.size);
        response.fold((l) => emit(Error(l.error.toString())),
            (r) => emit(GetCategoriesState(r)));
      }
      if (event is GetNewsEvent) {
        emit(LoadingNews());
        final response =
            await getNewsUseCase.getMixedNewsUseCase(event.searchParamsModel);
        response.fold((l) => emit(Error(l.error!)), (r) {
          if (news.isEmpty) {
            news = r.result!;
            NewsModel newsModel = NewsModel(result: news);
              emit(GetNewsState(newsModel));
            
          } else {
            news.addAll(r.result!);
                NewsModel newsModel = NewsModel(result: news);
              emit(GetNewsState(newsModel));
       
          }
             
        });
      }
    });
  }

  @override
  NavigationBarBlocState? fromJson(Map<String, dynamic> json) {
   try {
      final news = NewsModel.fromJson(json);
      return GetNewsState(news);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(NavigationBarBlocState state) {
   if (state is GetNewsState){

    
    var result =     state.newsmodel.toJson();
   
    return result;
   }
   
   else {return null;}
  }



  }

