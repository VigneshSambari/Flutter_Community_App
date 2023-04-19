// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/repositories/profile_repository.dart';
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
import 'package:sessions/socket/socket_client.dart';
import 'package:sessions/utils/classes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sessions/utils/navigations.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() async {
  //Dotenv initialization asynchronous
  await dotenv.load();

  //Native calling
  WidgetsFlutterBinding.ensureInitialized();

  //Hydrated bloc storage initialization
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBloc.storage = storage;

  //Orientation setup
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  //Initialize socket client
  SocketService socketService = SocketService(query: {
    'userid': '64311af926e4ea69bd38063f',
  });

  socketService.fetchRoomMessages();

  socketService.setOnline();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  SocketService socketService = SocketService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      socketService.disconnect();
    }
    if (state == AppLifecycleState.resumed) {
      socketService.setOnline();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CommunityApp',
          theme: ThemeData(
            fontFamily: "Intel",
            primarySwatch: kPrimarySwatch,
            scaffoldBackgroundColor: Colors.white,
          ),
          //home: ChatScreen(),
          home: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final ProfileBloc profileBloc = context.read<ProfileBloc>();
              final ProfileState profileState = profileBloc.state;
              if (profileState is ProfileCreatedState) {
                return EntryPoint();
              }
              if (state is UserSignedInState &&
                  profileState is ProfileInitialState) {
                return CreateProfile();
              }

              if (state is UserSignedUpState) {
                return Loginscreen();
              }
              return WelcomeScreen();
            },
          ),
        ),
      ),
    );
  }
}

// class ScreenChanger extends StatefulWidget {
//   const ScreenChanger({super.key});

//   @override
//   State<ScreenChanger> createState() => _ScreenChangerState();
// }

// class _ScreenChangerState extends State<ScreenChanger> {
//   Widget currenScreen = EntryPoint();
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<UserBloc, UserState>(
//           listener: (context, state) {
//             if (state is UserInitialState) {
//               print("initial state");
//               currenScreen = WelcomeScreen();
//               setState(() {
//                 currenScreen;
//               });
//             }
//             if (state is UserSignedInState) {
//               currenScreen = CreateProfile();
//               setState(() {});
//             }
//           },
//         ),
//         BlocListener<ProfileBloc, ProfileState>(
//           listener: (context, state) {},
//         ),
//       ],
//       child: currenScreen,
//     );
//   }
// }
