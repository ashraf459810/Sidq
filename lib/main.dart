import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:sidq/App/app.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  await di.init();

  runApp(const MyApp());
    
  
}
