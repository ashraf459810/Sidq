part of 'home_page_bloc.dart';

abstract class NavigationBarBlocState extends Equatable {
  const NavigationBarBlocState();

  @override
  List<Object> get props => [];
}

class NavigationBarBlocInitial extends NavigationBarBlocState {}

class GetCategoriesState extends NavigationBarBlocState {
  final CategoryModel categoryModel;

  const GetCategoriesState(this.categoryModel);
}

class GetNewsState extends NavigationBarBlocState {
  final List<News> newsmodel;

  const GetNewsState(this.newsmodel);
}

class LoadingCategory extends NavigationBarBlocState {}

class LoadingNews extends NavigationBarBlocState {}

class Error extends NavigationBarBlocState {
  final String error;

  const Error(this.error);
}
