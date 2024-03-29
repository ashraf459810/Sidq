import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/App/app.dart';
import 'core/consts.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  await FirebaseMessaging.instance
      .getToken()
      .then((value) => sharedPreferences.setString('fcmToken', value!));

  try {
    await PlatformDeviceId.getDeviceId
        .then((value) => sharedPreferences.setString(Con.token, value!));
  } on PlatformException {
    log('Failed to get deviceId.');
  }

  runApp(const MyApp());
  // });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
