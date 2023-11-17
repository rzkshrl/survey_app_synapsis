// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:survey_app_synapsis/app/theme/theme.dart';

import 'app/routes/app_pages.dart';

String? user = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  user = preferences.getString('email');
  await initializeDateFormatting().then((_) => runApp(SurveyApp()));
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(user);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: "Survey Synapsis",
        debugShowCheckedModeBanner: false,
        localeResolutionCallback: (locale, supportedLocales) {
          return locale;
        },
        theme: SurveyAppTheme.lightTheme,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('id', 'ID'),
        ],
        initialRoute: user == null ? Routes.LOGIN : Routes.HOME,
        getPages: AppPages.routes,
      );
    });
  }
}
