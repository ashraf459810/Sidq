

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version/new_version.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/App/bloc/app_bloc.dart';

import 'package:sidq/core/consts.dart';
import 'package:sidq/core/navigatuin_service/navigation.dart';

import 'package:sidq/features/index_page/presentation/pages/index_page.dart';
import 'package:sidq/features/news_details/presentation/pages/news_details.dart';
import 'package:sidq/features/review_tickets/presentation/pages/review_tickets.dart';

import '../injection_container.dart';
import 'app_localizations.dart';

final routeObserver = RouteObserver<PageRoute>();
const duration =  Duration(milliseconds: 400);

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  int? id;
  String? title;
  String? body;
  String? payload;
}

late String selectedNotificationPayload;

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print(message);
//   print('Handling a background message ${message.messageId}');
// }

late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ;
final NavigationService navigationService = sl<NavigationService>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}




class _MyAppState extends State<MyApp> {
  @override
void initState() {
    final newVersion = NewVersion(
      iOSId: 'com.example.sidq',
      androidId: 'com.example.sidq',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
    try{ 
   
        basicStatusCheck(newVersion);
    }
    catch (e){
      log('error');
    }
    }
    
log('here from app');
  
    
initializeNotifications();
onMessageListen();

super.initState();
}
  @override
  Widget build(BuildContext context) {
      sl<AppBloc>().add(GetTokensEvent());
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => MaterialApp(
           navigatorObservers: [routeObserver],
              navigatorKey: sl<NavigationService>().navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'AR'),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: const [
                // THIS CLASS WILL BE ADDED LATER
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                // If the locale of the device is not supported, use the first one
                // from the list (English, in this case).
                return supportedLocales.first;
              },

              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: TextStyle(fontSize: 16.sp)),
                ),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hourMinuteShape: const CircleBorder(),
                ),
                textTheme: TextTheme(button: TextStyle(fontSize: 41.sp)),
              ),

              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },

              home: const MainPage(),
            ));
  }



void basicStatusCheck(NewVersion newVersion) {
  
    newVersion.showAlertIfNecessary(context: context);
}

  initializeNotifications() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
            if (message!.data['type'] == 'NewNewsPublished') {
       var id = message.data['id'];
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            !.push(MaterialPageRoute(
                builder: (context) => NewsDetails(
                      news: id,
                    )));
      }
            if (message.data['type'] == 'TicketAnswered') {
       var id = message.data['id'];
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            !.push(MaterialPageRoute(
                builder: (context) => const ReviewTickets(
                   
                    )));
      }
        });
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int? id,
              String? title,
              String? body,
              String? payload,
            ) async {
              didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      String? token = await FirebaseMessaging.instance.getToken();
      log(token!);
      await SharedPreferences.getInstance()
          .then((value) => value.setString(Con.fcmToken, token));
    }
  }

  onMessageListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var payload = message.data.toString();

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,

                channelDescription: channel.description,

                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ),
            payload: payload);
      }


    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'NewNewsPublished') {
       var id = message.data['id'];
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            !.push(MaterialPageRoute(
                builder: (context) => NewsDetails(
                      news: id,
                    )));
      }
            if (message.data['type'] == 'TicketAnswered') {
       var id = message.data['id'];
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            !.push(MaterialPageRoute(
                builder: (context) => const ReviewTickets(
                   
                    )));
      }
    });
  }
 





  void onSelectNotification(String? payload) {
    if (payload!.contains('NewNewsPublished')){

     var id = payload.split(',').first.substring(5);
      sl<NavigationService>()
            .navigatorKey
            .currentState
            !.push(MaterialPageRoute(
                builder: (context) => NewsDetails(
                      news: id,
                    )));


    }
    if (payload.contains('TicketAnswered')){

     // ignore: unused_local_variable
     var id = payload.split(',').first.substring(5);
      sl<NavigationService>()
            .navigatorKey
            .currentState
            !.push(MaterialPageRoute(
                builder: (context) => const ReviewTickets (
                     
                    )));


    }

  }
}

double h(double h) {
  return ScreenUtil().setHeight(h);
}

double w(double w) {
  return ScreenUtil().setWidth(w);
}


