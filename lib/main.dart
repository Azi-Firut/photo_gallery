import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/constant.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: colorGray,
    systemNavigationBarDividerColor: Colors.black12,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: colorGray,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: colorGray,
      debugShowCheckedModeBanner: false,
      home: HomePageView(),
    );
  }
}
