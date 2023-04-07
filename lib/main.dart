// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
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
import 'package:sessions/screens/profile/components/profile_details.dart';
import 'package:sessions/screens/profile/create_profile.dart';
import 'package:sessions/screens/profile/bottom_sheet.dart';
import 'package:sessions/screens/profile/view_profile.dart';
import 'package:sessions/screens/signup/signup_screen.dart';
import 'package:sessions/screens/welcome/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sessions/utils/classes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sessions/utils/navigations.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  HydratedBloc.storage = storage;
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
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => UserBloc(
          RepositoryProvider.of<UserRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CommunityApp',
          theme: ThemeData(
            fontFamily: "Intel",
            primarySwatch: kPrimarySwatch,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitialState) {
                return WelcomeScreen();
              }
              return CreateProfile();
            },
          ),
        ),
      ),
    );
  }
}
