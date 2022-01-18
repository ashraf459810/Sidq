import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class NavigationBarBloc
    extends Bloc<NavigationBarBlocEvent, NavigationBarBlocState> {
  NavigationBarBloc() : super(NavigationBarBlocInitial()) {
    on<NavigationBarBlocEvent>((event, emit) {});
  }
}
