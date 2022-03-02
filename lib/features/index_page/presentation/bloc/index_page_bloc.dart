import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/features/index_page/domain/usecases/get_user_id_use_case.dart';

import '../../../../injection_container.dart';

part 'index_page_event.dart';
part 'index_page_state.dart';

class IndexPageBloc extends Bloc<IndexPageEvent, IndexPageState> {
    final GetUserIdUseCase getUserIdUseCase ;
    
  IndexPageBloc(this.getUserIdUseCase) : super(IndexPageInitial()) {
    on<IndexPageEvent>((event, emit) async {
    
    if (event is GetUserIdEvent){
        SharedPreferences sharedPreferences= sl <SharedPreferences> ();
        var deviceToken = sharedPreferences.getString("token");
        var fcmToken = sharedPreferences.getString("fcmToken");
        
      var response = await getUserIdUseCase.getUserIdUsecase(deviceToken!, fcmToken!);
      response.fold((l) => emit(Error(l.error!)), (r) {
        emit(GetUserIdState(r));
        sharedPreferences.setString('id', r);
        });

    }

    });}
  
}
