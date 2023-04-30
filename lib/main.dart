// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:math';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sessions/bloc/session/session_bloc.dart';
import 'package:sessions/callback.dart';
import 'package:sessions/repositories/session_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/repositories/message_repository.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/repositories/room_repository.dart';
import 'package:sessions/repositories/user_repository.dart';
import 'package:sessions/screens/blogScreens/blog_screen.dart';
import 'package:sessions/screens/blogScreens/createblog_screen.dart';
import 'package:sessions/screens/chatScreens/chat_entry.dart';
import 'package:sessions/screens/chatScreens/chat_screen.dart';
import 'package:sessions/screens/chatScreens/chats_display.dart';
import 'package:sessions/screens/entryPoint/entry_point.dart';
import 'package:sessions/screens/home/home_screen.dart';
import 'package:sessions/screens/login/login_screen.dart';
import 'package:sessions/screens/profile/bottom_sheet.dart';
import 'package:sessions/screens/profile/components/profile_details.dart';
import 'package:sessions/screens/profile/create_profile.dart';
import 'package:sessions/screens/profile/view_profile.dart';
import 'package:sessions/screens/signup/signup_screen.dart';
import 'package:sessions/screens/welcome/welcome_screen.dart';
import 'package:sessions/socket/socket_client.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'bloc/message/message_bloc.dart';
import 'bloc/room/room_bloc.dart';
import 'bloc/user/user_bloc.dart';

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

  // try {
  //   final rooms = await RoomRepository().getRoomsOfType(roomType: "private");
  //   print(rooms);
  // } catch (err) {
  //   print(err);
  // }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Widget currentScreen = WelcomeScreen();
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor,
    ));
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
        RepositoryProvider(
          create: (context) => RoomRepository(),
        ),
        RepositoryProvider(
          create: (context) => SessionRepository(),
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
          BlocProvider(
            create: (context) => RoomBloc(
              RepositoryProvider.of<RoomRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => RoomBloc(
              RepositoryProvider.of<RoomRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SessionBloc(
              RepositoryProvider.of<SessionRepository>(context),
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
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            MonthYearPickerLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
          ],
          home: Builder(builder: (BuildContext context) {
            ProfileState profileState =
                BlocProvider.of<ProfileBloc>(context).state;
            UserState userState = BlocProvider.of<UserBloc>(context).state;
            if (profileState is ProfileCreatedState) {
              currentScreen = EntryPoint();
            } else if (userState is UserSignedInState) {
              currentScreen = CreateProfile();
            } else if (userState is UserSignedUpState) {
              currentScreen = Loginscreen();
            }

            return currentScreen;
          }),
        ),
      ),
    );
  }
}

class ScreenChanger extends StatefulWidget {
  const ScreenChanger({super.key});

  @override
  State<ScreenChanger> createState() => _ScreenChangerState();
}

class _ScreenChangerState extends State<ScreenChanger> {
  Widget currenScreen = EntryPoint();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserInitialState) {
              currenScreen = WelcomeScreen();
              setState(() {
                currenScreen;
              });
            }
            if (state is UserSignedInState) {
              currenScreen = CreateProfile();
              setState(() {});
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {},
        ),
      ],
      child: currenScreen,
    );
  }
}
// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit/zego_uikit.dart';

// // Dart imports:
// import 'dart:math' as math;

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   final navigatorKey = GlobalKey<NavigatorState>();
//   ZegoUIKit().initLog().then((value) {
//     runApp(MyApp(
//       navigatorKey: navigatorKey,
//     ));
//   });
// }

// class MyApp extends StatefulWidget {
//   final GlobalKey<NavigatorState> navigatorKey;

//   const MyApp({
//     required this.navigatorKey,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//       navigatorKey: widget.navigatorKey,
//       builder: (BuildContext context, Widget? child) {
//         return Stack(
//           children: [
//             child!,

//             /// support minimizing
//             ZegoUIKitPrebuiltCallMiniOverlayPage(
//               contextQuery: () {
//                 return widget.navigatorKey.currentState!.context;
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   /// Users who use the same callID can in the same call.
//   final callIDTextCtrl = TextEditingController(text: "call_id");

//   HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: callIDTextCtrl,
//                   decoration:
//                       const InputDecoration(labelText: "join a call by id"),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (ZegoUIKitPrebuiltCallMiniOverlayMachine().isMinimizing) {
//                     /// when the application is minimized (in a minimized state),
//                     /// disable button clicks to prevent multiple PrebuiltCall components from being created.
//                     return;
//                   }

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) {
//                       return CallPage(callID: callIDTextCtrl.text);
//                     }),
//                   );
//                 },
//                 child: const Text("join"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Note that the userID needs to be globally unique,
// final String localUserID = math.Random().nextInt(10000).toString();

// class CallPage extends StatelessWidget {
//   final String callID;

//   const CallPage({
//     Key? key,
//     required this.callID,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltCall(
//         appID: 986122463 /*input your AppID*/,
//         appSign:
//             "9f715aac3a5f82878d2f1b168f21e0309d9300451c792f69ea4b93779dc0c189" /*input your AppSign*/,
//         userID: localUserID,
//         userName: "user_$localUserID",
//         callID: callID,
//         config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()
//           ..onOnlySelfInRoom = (context) {
//             if (PrebuiltCallMiniOverlayPageState.idle !=
//                 ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
//               /// in minimizing
//               ZegoUIKitPrebuiltCallMiniOverlayMachine()
//                   .changeState(PrebuiltCallMiniOverlayPageState.idle);
//             } else {
//               Navigator.of(context).pop();
//             }
//           }

//           /// support minimizing
//           ..topMenuBarConfig.isVisible = true
//           ..topMenuBarConfig.buttons = [
//             ZegoMenuBarButtonName.minimizingButton,
//             ZegoMenuBarButtonName.showMemberListButton,
//           ],
//       ),
//     );
//   }
// }
