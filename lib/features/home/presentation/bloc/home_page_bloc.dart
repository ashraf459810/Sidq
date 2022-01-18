import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/domain/usecases/get_category_use_case.dart';
import 'package:sidq/features/home/domain/usecases/get_news_use_case.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class NavigationBarBloc
    extends Bloc<NavigationBarBlocEvent, NavigationBarBlocState> {
  List<NewsModel> news = [];
  final GetNewsUseCase getNewsUseCase;
  final GetCategroyUseCase getCategroyUseCase;
  NavigationBarBloc(this.getNewsUseCase, this.getCategroyUseCase)
      : super(NavigationBarBlocInitial()) {
    on<NavigationBarBlocEvent>((event, emit) async {
      if (event is GetCategoriesEvent) {
        log('here');
        emit(LoadingCategory());
        final response = await getCategroyUseCase.getCategoriesUseCase(
            event.page, event.size);
        response.fold(
            (l) => emit(Error(l.error!)), (r) => emit(GetCategoriesState(r)));
      }
      if (event is GetNewsEvent) {
        emit(LoadingNews());
        final response =
            await getNewsUseCase.getMixedNewsUseCase(event.searchParamsModel);
        response.fold((l) => emit(Error(l.error!)), (r) {
          if (news.isNotEmpty) {
            news = r;
          } else {
            news.addAll(r);
            emit(GetNewsState(news));
          }
        });
      }
    });
  }
}
