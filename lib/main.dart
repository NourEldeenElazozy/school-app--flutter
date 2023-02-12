



import 'package:students_mobile/HomeScreen/dawer_home.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/text_font_family.dart';

import 'firebase_options.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async  {


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(DoctorApp()));
}

class DoctorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: ColorResources.green009),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
      ),
      home: HomeScreen(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
