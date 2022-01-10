import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sidq/features/main_page/presentation/pages/main_page.dart';

import 'app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => MaterialApp(
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
}

double h(double h) {
  return ScreenUtil().setHeight(h);
}

double w(double w) {
  return ScreenUtil().setWidth(w);
}
