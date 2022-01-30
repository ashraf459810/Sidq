part of 'home_page_bloc.dart';

abstract class NavigationBarBlocEvent extends Equatable {
  const NavigationBarBlocEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends NavigationBarBlocEvent {
  final int page;
  final int size;

  const GetCategoriesEvent(this.page, this.size);
}

class GetNewsEvent extends NavigationBarBlocEvent {
  final SearchParamsModel searchParamsModel;
  final bool resetList;

  const GetNewsEvent(this.searchParamsModel, this.resetList);
}
