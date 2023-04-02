// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/circle_avatars.dart';
import 'package:sessions/components/swipers.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';

import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/screens/chatScreens/components/status.dart';

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
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                ListTile(
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
                Stack(
                  children: [
                    Container(
                      height: size.height,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return Text("Hello");
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
    ));
  }
}
