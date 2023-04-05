// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/repositories/user_repository.dart';
import 'package:sessions/screens/blogScreens/blog_screen.dart';
import 'package:sessions/screens/blogScreens/createblog_screen.dart';
import 'package:sessions/screens/chatScreens/chat_entry.dart';
import 'package:sessions/screens/chatScreens/chat_screen.dart';
import 'package:sessions/screens/chatScreens/chats_display.dart';
import 'package:sessions/screens/entryPoint/entry_point.dart';
import 'package:sessions/screens/home/home_screen.dart';
import 'package:sessions/screens/login/login_screen.dart';
import 'package:sessions/screens/profile/create_profile.dart';
import 'package:sessions/screens/profile/bottom_sheet.dart';
import 'package:sessions/screens/profile/view_profile.dart';
import 'package:sessions/screens/signup/signup_screen.dart';
import 'package:sessions/screens/welcome/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  // try {
  //   final blogs = await BlogPostRepository().getAllBlogs();

  //   print(blogs);
  // } catch (err) {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CommunityApp',
      theme: ThemeData(
        fontFamily: "Intel",
        primarySwatch: kPrimarySwatch,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: EntryPoint(),
    );
  }
}
