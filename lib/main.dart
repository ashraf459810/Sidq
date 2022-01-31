import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:sidq/App/app.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  await di.init();

     runApp(const MyApp());
    
  
}
