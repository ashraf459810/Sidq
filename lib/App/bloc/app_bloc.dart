import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/core/consts.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
 

  AppBloc() : super(AppInitial()) {
    on<AppEvent>((event, emit) async {

if (event is GetTokensEvent){
   final sharedPreferences =await SharedPreferences.getInstance();
  
 var token =  sharedPreferences.getString(Con.token);
 var fcmToken = sharedPreferences.getString(Con.fcmToken);
  if ( token ==null || fcmToken ==null){
    
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      log(fcmToken!);
      sharedPreferences.setString(Con.fcmToken, fcmToken);
       try {
     final deviceId = await PlatformDeviceId.getDeviceId;
     log(deviceId!);
     sharedPreferences.setString(Con.token, deviceId);
     
    } on PlatformException {
   log('Failed to get deviceId.');
    }
 }

}
     
    });
  }
}
