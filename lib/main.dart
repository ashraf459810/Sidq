

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';





import 'package:sidq/App/app.dart';

import 'core/consts.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);


  await di.init();
   SharedPreferences sharedPreferences = sl<SharedPreferences>();
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
     
               sharedPreferences.setString('fcmToken', fcmToken!);

  runApp(const MyApp());
  // });
      
      

  


}
