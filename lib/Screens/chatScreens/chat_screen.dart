// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/user/user_bloc.dart';

import 'package:sessions/components/circle_avatars.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/swipers.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/message.model.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/models/room.model.dart';
import 'package:sessions/repositories/message_repository.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/repositories/room_repository.dart';

import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/screens/chatScreens/room_details.dart';
import 'package:sessions/socket/socket_client.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';
import 'package:sessions/utils/util_methods.dart';

List<EventClip> events = [
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
];

class ChatScreen extends StatefulWidget {
  final RoomModel roomData;
  final bool isSession;
  final Widget? overLayDrap;
  ChatScreen({
    super.key,
    required this.roomData,
    this.overLayDrap,
    this.isSession = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isDisposed = false;

  late SocketService socketService;
  bool sendIconShow = false;
  bool isLoading = false, sendLoading = false;
  late ScrollController _scrollController;
  TextEditingController messageController = TextEditingController();
  double _scrollPosition = 0.0;
  int pageCounter = 1;
  List<IdObject> messageIds = [];
  List<MessageModel> messageList = [];
  List<String> msgUserIds = [];
  List<ProfileModel> msgUserProfiles = [];
  int limit = 20;
  String? errorString;
  bool endReached = false;
  RoomRepository _roomRepository = RoomRepository();
  MessageRepository _messageRepository = MessageRepository();
  ProfileRepository _profileRepository = ProfileRepository();
  String? userId;
  Map<String, ProfileModel> mapIdProfile = {};

  @override
  void initState() {
    final ProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileCreatedState) {
      userId = profileState.profile.userId!;
    }
    fetchData();
    socketService = SocketService(query: {
      'userid': userId,
    }, fetchMessages: fetchData);
    _scrollController = ScrollController();
    messageController.addListener(() {
      if (_isDisposed || !mounted) {
        return;
      }
      if (messageController.text.trim().isNotEmpty) {
        setState(() {
          sendIconShow = true;
        });
      } else {
        setState(() {
          sendIconShow = false;
        });
      }
    });

    socketService.enterRoom(roomId: widget.roomData.roomId!);
    super.initState();
  }

  @override
  void dispose() {
    _isDisposed = true;
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollPosition);
    });
  }

  Future<void> fetchData() async {
    if (_isDisposed || !mounted) {
      return;
    }
    setState(() {
      isLoading = true;
      endReached = true;
    });
    int newMsgsLength = 0;
    try {
      final List<IdObject> currMessageIds =
          await _roomRepository.getRoomMessages(
              fetchQuery: FetchMessagesRoom(
                  roomId: widget.roomData.roomId,
                  page: pageCounter,
                  limit: limit - messageIds.length));
      for (IdObject id in currMessageIds) {
        messageIds.add(id);
      }
      newMsgsLength = currMessageIds.length;
      if (currMessageIds.isNotEmpty) {
        final List<MessageModel> messagesNew = await _messageRepository
            .getListedMessages(messageIds: IdList(ids: currMessageIds));

        for (MessageModel message in messagesNew) {
          msgUserIds.add(message.sentBy!);
          String id = message.sentBy!;
          if (!mapIdProfile.containsKey(id)) {
            final ProfileModel? profile =
                await _profileRepository.loadProfile(userId: id);
            mapIdProfile.putIfAbsent(id, () => profile!);
          }
          messageList.add(message);
        }
      }
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
    //print(msgUserProfiles.length);
    if (messageIds.length == limit) {
      pageCounter++;
      messageIds = [];
      msgUserIds = [];
    }
    if (_isDisposed || !mounted) {
      return;
    }

    if (newMsgsLength != 0) {
      endReached = false;
    } else {
      endReached = true;
    }

    setState(() {
      isLoading = false;
      messageList;
      errorString;
      msgUserIds;
    });
  }

  Future<void> sendMessage({required CreateMessageSend messageBody}) async {
    try {
      await _roomRepository.createRoomMessage(messageBody: messageBody);
      await fetchData();
      socketService.fetchRoomMessages(
          roomId: widget.roomData.roomId!, fetchMessages: fetchData);
      scrollToPositionFun(
        scrollPosition: _scrollController.position.maxScrollExtent + 150,
      );
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
  }

  Future<void> sendMsgButtonFunction({
    required String? content,
    required String? type,
    String? sentBy,
    String? sentTo,
  }) async {
    final String? roomId = widget.roomData.roomId;
    setState(() {
      sendLoading = true;
    });
    try {
      await sendMessage(
        messageBody: CreateMessageSend(
          content: content!,
          messageId: "",
          roomId: roomId!,
          sentBy: userId!,
          sentTo: roomId,
          type: type!,
        ),
      );
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
    if (_isDisposed || !mounted) {
      return;
    }
    setState(() {
      sendLoading = false;
    });
  }

  void scrollToPositionFun({required double scrollPosition}) {
    scrollToPosition.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onSelectFun({required int value}) {}
  List<PairPopMenu> popUpOptions = [
    PairPopMenu(value: 0, option: "Clear Chat"),
    PairPopMenu(value: 1, option: "Leave Room"),
    PairPopMenu(value: 2, option: "Search Messages"),
    PairPopMenu(value: 3, option: "Report Room"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // width: size.width,
        height: size.height,
        color: kPrimaryColor,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      color: kPrimaryColor,
                      child: ListTile(
                        tileColor: kPrimaryColor,
                        title: GestureDetector(
                          onTap: () {
                            navigatorPush(
                                RoomDetails(
                                  room: widget.roomData,
                                  isSession: widget.isSession,
                                ),
                                context);
                          },
                          child: Text(
                            widget.roomData.name!,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            navigatorPush(
                                RoomDetails(room: widget.roomData), context);
                          },
                          child: Text(
                            widget.roomData.description!,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: kPrimaryLightColor,
                            ),
                          ),
                        ),
                        leading: Wrap(
                          children: [
                            BackButtonNav(),
                            CircleNetworkPicture(
                              url: (widget.roomData.coverPic == null)
                                  ? ""
                                  : widget.roomData.coverPic!.secureUrl,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (!isLoading &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                fetchData();
                              }
                              return true;
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: messageList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == messageList.length) {
                                  return Column(
                                    children: [
                                      isLoading
                                          ? Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 500,
                                      )
                                    ],
                                  );
                                } else {
                                  return RoomMessageTile(
                                    userName: (mapIdProfile.containsKey(
                                                messageList[index].sentBy!) &&
                                            ((index - 1) >= 0) &&
                                            mapIdProfile.containsKey(
                                                messageList[index - 1]
                                                    .sentBy!) &&
                                            mapIdProfile[messageList[index].sentBy!]!
                                                    .userName ==
                                                mapIdProfile[
                                                        messageList[index - 1]
                                                            .sentBy!]!
                                                    .userName)
                                        ? ""
                                        : mapIdProfile.containsKey(
                                                messageList[index].sentBy!)
                                            ? mapIdProfile[
                                                    messageList[index].sentBy!]!
                                                .userName!
                                            : "UserName",
                                    message: messageList[index].content!,
                                    dateTime: messageList[index].createdAt!,
                                    repliesExist: true,
                                    position:
                                        userId == messageList[index].sentBy,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        widget.overLayDrap ?? SwipeDownRow(events: events),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  !endReached
                      ? GestureDetector(
                          onTap: () {
                            scrollToPositionFun(
                              scrollPosition:
                                  _scrollController.position.maxScrollExtent +
                                      150,
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      kPrimaryColor.withOpacity(0.9),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      kPrimaryDarkColor.withOpacity(0.7),
                                  radius: 10,
                                  child: Text(
                                    "?",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  TypeMessageTile(
                    size: size,
                    messageController: messageController,
                    sendIconShow: sendIconShow,
                    sendLoading: sendLoading,
                    sendMessageFun: sendMsgButtonFunction,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ScrollController get scrollToPosition => _scrollController;
}

class TypeMessageTile extends StatelessWidget {
  const TypeMessageTile({
    super.key,
    required this.size,
    required this.messageController,
    required this.sendIconShow,
    required this.sendLoading,
    required this.sendMessageFun,
  });

  final Size size;
  final TextEditingController messageController;
  final bool sendIconShow, sendLoading;
  final Function({
    required String? content,
    String? sentBy,
    String? sentTo,
    required String? type,
  }) sendMessageFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: size.width,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.85),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.emoji_emotions_rounded,
                      color: kPrimaryColor.withOpacity(0.85),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: InputBorder.none,
                        hintText: "Type here...",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.attachment,
                      color: kPrimaryColor.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          sendLoading
              ? CircleAvatar(
                  backgroundColor: kPrimaryColor.withOpacity(0.5),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                )
              : sendIconShow
                  ? GestureDetector(
                      onTap: () async {
                        try {
                          if (messageController.text.trim().isEmpty) {
                            return;
                          }
                          await sendMessageFun(
                              content: messageController.text.trim(),
                              type: "text");
                          messageController.clear();
                        } catch (error) {
                          showMySnackBar(context, error.toString());
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: kPrimaryColor.withOpacity(0.5),
                        child: Center(
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: kPrimaryColor.withOpacity(0.5),
                      child: Center(
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

class RoomMessageTile extends StatelessWidget {
  RoomMessageTile({
    super.key,
    this.position = false,
    required this.userName,
    required this.message,
    required this.dateTime,
    this.repliesExist = false,
  });
  final bool position, repliesExist;
  final String userName, message;
  final DateTime dateTime;

  bool differenceOne = true;

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    Duration difference = currentDate.difference(dateTime);

    if (difference.inDays >= 1) {
      differenceOne = true;
    } else {
      differenceOne = false;
    }
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: position ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.9,
        ),
        decoration: BoxDecoration(
            color:
                position ? kPrimaryLightColor : kPrimaryColor.withOpacity(0.4),
            border: Border.all(
              width: 0.5,
              color: kPrimaryColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.only(
              topLeft: position ? Radius.circular(15) : Radius.circular(0),
              topRight: position ? Radius.circular(0) : Radius.circular(15),
              bottomLeft: position ? Radius.circular(15) : Radius.circular(15),
              bottomRight: position ? Radius.circular(15) : Radius.circular(15),
            )),
        padding: EdgeInsets.all(7.5),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userName != ""
                    ? Text(
                        userName,
                        style: TextStyle(
                          color: backgroundColor2,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(),
                Wrap(
                  runSpacing: 7,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 20,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        children: [
                          differenceOne == true
                              ? Text(
                                  formatDate(date: dateTime),
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: Color.fromARGB(255, 72, 40, 100),
                                  ),
                                )
                              : Text(
                                  formatTime(time: currentDate),
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: Color.fromARGB(255, 72, 40, 100),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            repliesExist
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Wrap(
                        children: [
                          Text(
                            "Replies...",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 34, 128),
                            ),
                          ),
                          // Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   size: 12,
                          //   color: Colors.blueGrey,
                          // )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class OwnMessageCard extends StatelessWidget {
  OwnMessageCard({required this.message, required this.time});
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Color(0xffdcf8c6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "userName",
                    style: TextStyle(
                      color: backgroundColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // true
              //     ? Column(
              //         children: [
              //           Divider(),
              //           GestureDetector(
              //             onTap: () {},
              //             child: Row(
              //               // mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 Expanded(
              //                   child: Text(
              //                     "Replies...",
              //                     style: TextStyle(
              //                       color: Color.fromARGB(255, 85, 34, 128),
              //                     ),
              //                   ),
              //                 ),
              //                 Icon(
              //                   Icons.arrow_forward_ios_rounded,
              //                   size: 14,
              //                   color: Colors.blueGrey,
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       )
              //     : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
