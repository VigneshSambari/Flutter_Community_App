// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, prefer_const_literals_to_create_immutables, prefer_final_fields

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
import 'package:sessions/callback.dart';
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

import 'bloc/message/message_bloc.dart';
import 'bloc/room/room_bloc.dart';
import 'bloc/user/user_bloc.dart';

const appId = "7090c1e8707b4289afad5e49fd0f4f61";
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late CachedVideoPlayerController controller;
//   @override
//   void initState() {
//     controller = CachedVideoPlayerController.network(
//         "https://res.cloudinary.com/drx5qtqvh/video/upload/v1682424320/communityapplication/kyut26dq2ivpaqtiywnn.mp4");
//     controller.initialize().then((value) {
//       controller.play();
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: CachedVideoPlayer(controller))
//               : const CircularProgressIndicator()), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> onJoin() async {
    // setState(() {
    //   myController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
  }

  final myController = TextEditingController();
  bool _validateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agora Group Video Call'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 100)),
            Image(
              image: NetworkImage(
                  'https://www.agora.io/en/wp-content/uploads/2019/07/agora-symbol-vertical.png'),
              height: 100,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              'Agora Group Video Call Demo',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Channel Name',
                  labelStyle: TextStyle(color: Colors.blue),
                  hintText: 'test',
                  hintStyle: TextStyle(color: Colors.black45),
                  errorText:
                      _validateError ? 'Channel name is mandatory' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 30)),
            SizedBox(
              width: 90,
              child: MaterialButton(
                onPressed: onJoin,
                height: 40,
                color: Colors.blueAccent,
                child: GestureDetector(
                  onTap: () {
                    navigatorPush(CallBack(input: myController.text), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Join', style: TextStyle(color: Colors.white)),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            )
          ],
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

// import 'dart:async';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// const appId = "7090c1e8707b4289afad5e49fd0f4f61";
// const token = "<-- Insert Token -->";
// const channel = "<-- Insert Channel Name -->";

// void main() => runApp(const MaterialApp(home: MyApp()));

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: appId,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );

//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();

//     await _engine.joinChannel(
//       token: token,
//       channelId: channel,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SizedBox(
//               width: 100,
//               height: 150,
//               child: Center(
//                 child: _localUserJoined
//                     ? AgoraVideoView(
//                         controller: VideoViewController(
//                           rtcEngine: _engine,
//                           canvas: const VideoCanvas(uid: 0),
//                         ),
//                       )
//                     : const CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: const RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }
