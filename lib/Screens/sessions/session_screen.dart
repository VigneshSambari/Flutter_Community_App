// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sessions/assets.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/room/room_bloc.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/models/session.model.dart';
import 'package:sessions/repositories/session_repository.dart';
import 'package:sessions/screens/chatScreens/chat_screen.dart';
import 'package:sessions/screens/profile/components/utils.dart';
import 'package:sessions/screens/sessions/components/date_pickers.dart';
import 'package:sessions/screens/sessions/create_session.dart';
import 'package:sessions/screens/sessions/search_sessions.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';
import 'package:sessions/utils/util_methods.dart';

import '../../bloc/session/session_bloc.dart';

List<PairPopMenu> popUpOptions = [
  PairPopMenu(value: 0, option: "Create Session"),
  PairPopMenu(value: 1, option: "Search All Sessions"),
  PairPopMenu(value: 2, option: "View your Sessions"),
];

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  late DateTime currentDate;
  List<SessionModel> sessionList = [];

  @override
  void initState() {
    currentDate = DateTime.now();
    loadProfile();

    super.initState();
  }

  void loadProfile() {
    UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSignedInState) {
      BlocProvider.of<ProfileBloc>(context)
          .add(LoadProfileEvent(userId: userState.user.userId!));
    }
  }

  void fetchSessions() {
    ProfileState profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileCreatedState) {
      BlocProvider.of<SessionBloc>(context).add(
        LoadSessionsEvent(
          ids: IdList(ids: profileState.profile.sessions ?? []),
        ),
      );
    }
  }

  void fetchRoomData() {
    SessionState sessionState = BlocProvider.of<SessionBloc>(context).state;
    if (sessionState is SessionLoadedState) {
      List<IdObject> idList = [];
      for (var item in sessionState.sessions) {
        idList.add(IdObject(item.roomId));
      }

      BlocProvider.of<RoomBloc>(context)
          .add(LoadListedRoomsEvent(ids: IdList(ids: idList)));
    }
  }

  void dateSelectCallBack({required DateTime date}) {
    setState(() {
      currentDate = date;
    });
  }

  void onSelectFun({required int value}) {
    if (value == 0) {
      navigatorPush(CreateSession(), context);
    }
    if (value == 1) {
      navigatorPush(SearchSession(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileCreatedState) {
          fetchSessions();
        }
      },
      child: BlocListener<SessionBloc, SessionState>(
        listener: (context, state) {
          if (state is SessionLoadedState) {
            fetchRoomData();
          }
        },
        child: Scaffold(
          appBar: CurvedAppBar(
            title: "Sessions",
            actions: [
              IconButton(
                onPressed: () {
                  navigatorPush(SearchSession(), context);
                },
                icon: Icon(Icons.search),
                splashRadius: 25,
                splashColor: kPrimaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15, left: 5),
                child: PopUpMenuWidget(
                  options: popUpOptions,
                  onSelect: onSelectFun,
                ),
              ),
            ],
            leading: SizedBox(),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                CustomCalendarWidget(
                  size: size,
                  callback: dateSelectCallBack,
                ),
                CustomDraggableSheet(minHeight: size.height * 0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDraggableSheet extends StatefulWidget {
  final double minHeight;

  const CustomDraggableSheet({
    super.key,
    required this.minHeight,
  });
  @override
  CustomDraggableSheetState createState() => CustomDraggableSheetState();
}

class CustomDraggableSheetState extends State<CustomDraggableSheet> {
  late double _currentHeight;
  DraggableScrollableController controller = DraggableScrollableController();
  double maxHeight = 700;

  @override
  void initState() {
    _currentHeight = widget.minHeight - 20;

    controller.addListener(() {
      setState(() {
        _currentHeight = controller.pixels - 60;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    maxHeight = size.height;

    return DraggableScrollableSheet(
      controller: controller,
      minChildSize: 0.5,
      maxChildSize: 1,
      initialChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        //print(_currentHeight);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0.0, -2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.4,
                        right: size.width * 0.4,
                        bottom: 10,
                      ),
                      child: BlurDivider(size: size),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: size.width,
                      height: 35,
                      decoration: BoxDecoration(
                        color: kPrimaryDarkColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Date",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _currentHeight,
                      child: MyExpansionPanelList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExpandItem {
  bool status;
  int index;
  ExpandItem({
    required this.status,
    required this.index,
  });
}

class MyExpansionPanelList extends StatefulWidget {
  @override
  MyExpansionPanelListState createState() => MyExpansionPanelListState();
}

class MyExpansionPanelListState extends State<MyExpansionPanelList> {
  List<ExpandItem> expandedStatus = [];
  @override
  void initState() {
    setExpandedStatus();
    super.initState();
  }

  void setExpandedStatus() {
    SessionState sessionState = BlocProvider.of<SessionBloc>(context).state;
    if (sessionState is SessionLoadedState) {
      expandedStatus = generateItems(sessionState.sessions.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        setExpandedStatus();
      },
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, sessionState) {
          if (sessionState is SessionLoadedState) {
            return BlocBuilder<RoomBloc, RoomState>(
              builder: (context, roomState) {
                if (roomState is RoomLoadedState) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ExpansionPanelList(
                        dividerColor: kPrimaryColor,
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            expandedStatus[index].status = !isExpanded;
                          });
                        },
                        children: expandedStatus
                            .map<ExpansionPanel>((ExpandItem expandItem) {
                          return ExpansionPanel(
                            backgroundColor: kPrimaryLightColor,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return GestureDetector(
                                onTap: () {
                                  navigatorPush(
                                      ChatScreen(
                                          roomData: roomState
                                              .rooms[expandItem.index]),
                                      context);
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(5),
                                  leading: CircleAvatar(
                                    backgroundColor: kPrimaryLightColor,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                          Assets.assetsGlobalSessions),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          roomState
                                              .rooms[expandItem.index].name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              "${sessionState.sessions[expandItem.index].field!} ",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.all(5),
                                  leading: Column(
                                    children: [
                                      Text(
                                        formatDate(
                                            date: sessionState
                                                .sessions[expandItem.index]
                                                .startDate!),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "to",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        formatDate(
                                            date: sessionState
                                                .sessions[expandItem.index]
                                                .endDate!),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  title: Text(roomState
                                      .rooms[expandItem.index].description!),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        formatTime(
                                            time: sessionState
                                                .sessions[expandItem.index]
                                                .startTime!),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "to",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        formatTime(
                                            time: sessionState
                                                .sessions[expandItem.index]
                                                .endTime!),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Exit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isExpanded: expandItem.status,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
                if (roomState is RoomErrorState) {
                  return Center(
                    child: Text(
                      roomState.error,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return LoadingIndicator(
                  circularBlue: true,
                );
              },
            );
          }
          if (sessionState is SessionErrorState) {
            return Center(
              child: Text(
                sessionState.error,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return LoadingIndicator(
            circularBlue: true,
          );
        },
      ),
    );
  }
}

List<ExpandItem> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return ExpandItem(status: false, index: index);
  });
}
