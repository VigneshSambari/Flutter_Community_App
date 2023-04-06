// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

import 'package:sessions/components/circle_avatars.dart';
import 'package:sessions/components/swipers.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';

import 'package:sessions/screens/chatScreens/components/clips.dart';

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
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SafeArea(
                    child: ListTile(
                      tileColor: kPrimaryColor,
                      title: Text(
                        "Room Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Room description...",
                        style: TextStyle(
                          color: kPrimaryLightColor,
                        ),
                      ),
                      leading: Wrap(
                        children: [
                          BackButtonNav(),
                          CircleNetworkPicture(),
                        ],
                      ),
                      trailing: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: size.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return RoomMessageTile(
                              userName: "Username",
                              message:
                                  "madssssssssssssssssssAWdawsssssssssssssssaaasdjanflkjhsfjhsjkldfhkjsahdfjkshafkjh...",
                              time: "22:22, 2/2/22",
                              repliesExist: true,
                              position: index % 2 == 0,
                            );
                          },
                        ),
                      ),
                      SwipeDownRow(events: events),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
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
                              padding: EdgeInsets.only(right: 10),
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
                    CircleAvatar(
                      backgroundColor: kPrimaryColor.withOpacity(0.5),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoomMessageTile extends StatelessWidget {
  const RoomMessageTile({
    super.key,
    this.position = false,
    required this.userName,
    required this.message,
    required this.time,
    this.repliesExist = false,
  });
  final bool position, repliesExist;
  final String userName, message, time;

  @override
  Widget build(BuildContext context) {
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
                Text(
                  userName,
                  style: TextStyle(
                    color: backgroundColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color.fromARGB(255, 72, 40, 100),
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
