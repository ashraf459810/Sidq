import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reverse_serach_event.dart';
part 'reverse_serach_state.dart';

class ReverseSerachBloc extends Bloc<ReverseSerachEvent, ReverseSerachState> {
  ReverseSerachBloc() : super(ReverseSerachInitial()) {
    on<ReverseSerachEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
