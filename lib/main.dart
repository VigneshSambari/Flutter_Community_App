import 'package:flutter/material.dart';
import 'package:sessions/components/side_menu.dart';
import 'package:sessions/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sessions',
      theme: ThemeData(
        fontFamily: "Intel",
        primarySwatch: kPrimarySwatch,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SideMenu(),
    );
  }
}
