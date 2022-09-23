import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Routes/routes.dart';
import 'Utils/Color.dart';
import 'Utils/ConvertColor.dart';

void main() async {
  await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  renderInitialRoute() {
    final storage = GetStorage();
    bool isLoggedIn = storage.read("isLOGGEDIN") ?? false;

    if (isLoggedIn)
      return Routes.HOME;
    else
      return Routes.LOGIN;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color:
                      Color(ConvertHexToColor().hexCode(ColorCode.hmpBpText)),
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
      ),
      home: GetMaterialApp(
        initialRoute: renderInitialRoute(),
        title: 'Coumputer Sevice',
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
      ),
    );
  }
}
