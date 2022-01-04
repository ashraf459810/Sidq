import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/core/consts.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is IsVerfiyEvent) {
      final shared = await SharedPreferences.getInstance();
      bool isverfoy = shared.getBool(Con.isverify!) ?? false;
      // ignore: invalid_use_of_visible_for_testing_member
      emit(IsVerfitState(isverfoy));
    }
  }
}
