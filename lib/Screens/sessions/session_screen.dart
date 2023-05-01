// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:sessions/assets.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/room/room_bloc.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/models/room.model.dart';
import 'package:sessions/models/session.model.dart';
import 'package:sessions/repositories/session_repository.dart';
import 'package:sessions/screens/chatScreens/chat_screen.dart';
import 'package:sessions/screens/profile/components/utils.dart';
import 'package:sessions/screens/sessions/components/date_pickers.dart';
import 'package:sessions/screens/sessions/create_session.dart';
import 'package:sessions/screens/sessions/search_sessions.dart';
import 'package:sessions/screens/sessions/video_callpage.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';
import 'package:sessions/utils/util_methods.dart';

import '../../bloc/session/session_bloc.dart';

List<ExpandItem> expandedStatus = [];
List<RoomModel> newRooms = [];
List<SessionModel> newSession = [];
ProfileModel? globalProfile;

void setExpandedStatus(BuildContext context, DateTime selectedDate) {
  int index = 0;
  List<RoomModel> tempRooms = [];
  newRooms = [];
  newSession = [];
  RoomState roomState = BlocProvider.of<RoomBloc>(context).state;
  SessionState sessionState = BlocProvider.of<SessionBloc>(context).state;
  if (roomState is RoomLoadedState) {
    for (RoomModel room in roomState.rooms) {
      tempRooms.add(room);
    }
    if (sessionState is SessionLoadedState) {
      for (SessionModel session in sessionState.sessions) {
        // String sessionDate = formatDate(date: session.startDate!);
        // String todayDate = formatDate(date: selectedDate);
        Duration difference = session.startDate!.difference(selectedDate);
        int days = difference.inDays;
        int exists = session.endDate!.difference(selectedDate).inDays;
        if ((exists >= 0 && days <= 0) &&
            (days == 0 ||
                (session.repeat == "Daily") ||
                (session.repeat == "Weekly" && days % 7 == 0) ||
                (session.repeat == "Monthly" && days % 30 == 0))) {
          newSession.add(session);
          newRooms.add(tempRooms[index]);
        }

        index++;
      }
    }
  }

  expandedStatus = generateItems(newSession.length);
}

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
    ProfileState profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileCreatedState) {
      globalProfile = profileState.profile;
    }
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

      BlocProvider.of<RoomBloc>(context).add(
        LoadListedRoomsEvent(
          ids: IdList(ids: idList),
        ),
      );
    }
  }

  void dateSelectCallBack({required DateTime date}) {
    setState(() {
      currentDate = date;
      loadProfile();
      setExpandedStatus(context, currentDate);
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
        child: BlocListener<RoomBloc, RoomState>(
          listener: (context, state) {
            if (state is RoomLoadedState) {
              setExpandedStatus(context, currentDate);
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
                  CustomDraggableSheet(
                    minHeight: size.height * 0.5,
                    selectedDate: currentDate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDraggableSheet extends StatefulWidget {
  final double minHeight;
  final DateTime selectedDate;
  const CustomDraggableSheet({
    super.key,
    required this.minHeight,
    required this.selectedDate,
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
                        "${formatDate(date: widget.selectedDate)}, ${formatDay(day: widget.selectedDate)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _currentHeight,
                      child: MyExpansionPanelList(
                        selectedDate: widget.selectedDate,
                      ),
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
  final DateTime selectedDate;

  const MyExpansionPanelList({super.key, required this.selectedDate});
  @override
  MyExpansionPanelListState createState() => MyExpansionPanelListState();
}

class MyExpansionPanelListState extends State<MyExpansionPanelList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<RoomBloc, RoomState>(
      listener: (context, state) {
        setState(() {});
      },
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, sessionState) {
          if (sessionState is SessionLoadedState) {
            return BlocBuilder<RoomBloc, RoomState>(
              builder: (context, roomState) {
                if (roomState is RoomLoadedState) {
                  return newSession.isEmpty
                      ? Center(
                          child: Text(
                          "No session to go!",
                          style: TextStyle(
                            color: kPrimaryDarkColor,
                          ),
                        ))
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
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
                                              overLayDrap:
                                                  SwipeVideoSessionInfo(
                                                session: newSession[
                                                    expandItem.index],
                                                startTime: DateTime(
                                                    newSession[expandItem.index]
                                                        .startDate!
                                                        .year,
                                                    newSession[expandItem.index]
                                                        .startDate!
                                                        .month,
                                                    newSession[expandItem.index]
                                                        .startDate!
                                                        .day,
                                                    newSession[expandItem.index]
                                                        .startTime!
                                                        .hour,
                                                    newSession[expandItem.index]
                                                        .startTime!
                                                        .minute,
                                                    newSession[expandItem.index]
                                                        .startTime!
                                                        .second),
                                              ),
                                              roomData:
                                                  newRooms[expandItem.index],
                                            ),
                                            context);
                                      },
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(5),
                                        leading: CircleAvatar(
                                          backgroundColor: kPrimaryLightColor,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: CircleImageTile(
                                                url: newRooms[expandItem.index]
                                                            .coverPic ==
                                                        null
                                                    ? ""
                                                    : newRooms[expandItem.index]
                                                        .coverPic!
                                                        .secureUrl),
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
                                                newRooms[expandItem.index]
                                                    .name!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Wrap(
                                                children: [
                                                  Text(
                                                    "${newSession[expandItem.index].field!} ",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  body: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.all(5),
                                          leading: Column(
                                            children: [
                                              SessionSubTitle(
                                                text: formatDate(
                                                    date: newSession[
                                                            expandItem.index]
                                                        .startDate!),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    "to",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              SessionSubTitle(
                                                text: formatDate(
                                                    date: newSession[
                                                            expandItem.index]
                                                        .endDate!),
                                              ),
                                            ],
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Wrap(
                                                children: [
                                                  SessionListSubTitle(
                                                    title: "Description",
                                                  ),
                                                  Text(
                                                    "${newRooms[expandItem.index].description}",
                                                  ),
                                                ],
                                              ),
                                              // Wrap(
                                              //   children: [
                                              //     SessionListSubTitle(
                                              //       title: "Domain",
                                              //     ),
                                              //     Text(
                                              //       "${newSession[expandItem.index].field}",
                                              //     ),
                                              //   ],
                                              // ),
                                              Wrap(
                                                children: [
                                                  SessionListSubTitle(
                                                    title: "Pay amount",
                                                  ),
                                                  Text(
                                                    "${newSession[expandItem.index].payAmount}",
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  SessionListSubTitle(
                                                    title: "Session type",
                                                  ),
                                                  Text(
                                                    "${newRooms[expandItem.index].type}",
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  SessionListSubTitle(
                                                    title: "Created by",
                                                  ),
                                                  Text(
                                                    "???????",
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            children: [
                                              SessionSubTitle(
                                                text: formatTime(
                                                    time: newSession[
                                                            expandItem.index]
                                                        .startTime!),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "to",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              SessionSubTitle(
                                                text: formatTime(
                                                    time: newSession[
                                                            expandItem.index]
                                                        .endTime!),
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

class SessionListSubTitle extends StatelessWidget {
  final String title;
  const SessionListSubTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title: ",
      style: TextStyle(
        color: kPrimaryDarkColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SessionSubTitle extends StatelessWidget {
  final String text;
  const SessionSubTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: kPrimaryDarkColor),
    );
  }
}

List<ExpandItem> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return ExpandItem(status: false, index: index);
  });
}

class SwipeVideoSessionInfo extends StatefulWidget {
  final DateTime startTime;
  final SessionModel session;
  const SwipeVideoSessionInfo({
    super.key,
    required this.startTime,
    required this.session,
  });
  @override
  State<SwipeVideoSessionInfo> createState() => _SwipeVideoSessionInfoState();
}

class _SwipeVideoSessionInfoState extends State<SwipeVideoSessionInfo> {
  bool _isOpen1 = false, panelOpen = false;
  bool startSession = false, isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime today = DateTime.now(), calcTime = widget.startTime;
    Duration difference = widget.session.startDate!.difference(today);
    int days = difference.inDays;
    print(today);
    print(widget.startTime);
    print(days);
    if (widget.session.endDate!.difference(today).inSeconds > 0) {
      if (widget.session.repeat == "Daily") {
        calcTime = DateTime(
          today.year,
          today.month,
          today.day,
          widget.startTime.hour,
          widget.startTime.minute,
          widget.startTime.second,
        );
      } else if (widget.session.repeat == "Weekly") {
        calcTime = DateTime(
          today.year,
          today.month,
          today.day + days % 7,
          widget.startTime.hour,
          widget.startTime.minute,
          widget.startTime.second,
        );
      } else if (widget.session.repeat == "Monthly") {
        calcTime = DateTime(
          today.year,
          today.month,
          today.day + days % 30,
          widget.startTime.hour,
          widget.startTime.minute,
          widget.startTime.second,
        );
      }
    }
    //print(calcTime);
    //print(today);
    final int endTimeMillis = calcTime.millisecondsSinceEpoch;
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            _isOpen1 = true;
            setState(() {
              _isOpen1;
            });
            await Future.delayed(Duration(milliseconds: 200));
            setState(() {
              panelOpen = true;
            });
          },
          onVerticalDragUpdate: (details) {
            if (!_isOpen1 && details.primaryDelta! > 0) {
              setState(() {
                _isOpen1 = true;
              });
            }
          },
          onVerticalDragEnd: (details) {
            if (_isOpen1 && details.primaryVelocity! < 0) {
              setState(() {
                _isOpen1 = false;
              });
            }
          },
          child: Container(
            height: 5,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(5),
            ),
            width: size.width,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _isOpen1 ? size.height * 0.225 : 0,
          width: size.width,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Stack(
            children: [
              !panelOpen
                  ? SizedBox()
                  : JoinVideoPanel(
                      widget: widget, endTimeMillis: endTimeMillis),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      Icons.arrow_drop_up_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isOpen1 = false;
                      panelOpen = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class JoinVideoPanel extends StatelessWidget {
  const JoinVideoPanel({
    super.key,
    required this.widget,
    required this.endTimeMillis,
  });

  final SwipeVideoSessionInfo widget;
  final int endTimeMillis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Upcoming session:",
                    style: TextStyle(
                      color: kPrimaryDarkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CountdownTimer(
                    endWidget: Column(
                      children: [
                        Text(
                          "The Session has started!",
                          style: TextStyle(
                            color: kPrimaryDarkColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigatorPush(
                                VideoCallPage(
                                  session: widget.session,
                                  profile: globalProfile!,
                                ),
                                context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(12.5),
                            ),
                            child: Center(
                              child: Text(
                                "Join Video",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    endTime: endTimeMillis,
                    textStyle:
                        TextStyle(fontSize: 25, color: kPrimaryDarkColor),
                    onEnd: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
