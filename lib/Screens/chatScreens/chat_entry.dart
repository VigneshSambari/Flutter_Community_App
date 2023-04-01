// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/screens/chatScreens/components/rooms_holder.dart';

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

class ChatEntry extends StatelessWidget {
  const ChatEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Chat",
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 12.5),
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
        leading: SizedBox(),
      ),
      body: EntryChatBody(),
    );
  }
}

class EntryChatBody extends StatefulWidget {
  const EntryChatBody({super.key});

  @override
  State<EntryChatBody> createState() => _EntryChatBodyState();
}

class _EntryChatBodyState extends State<EntryChatBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      height: size.height,
      width: size.width,
      color: kPrimaryLightColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.015),
            ClipTitle(title: "Upcoming Events"),
            CarouselSlider(height: size.height * 0.25, items: events),
            SizedBox(height: size.height * 0.02),
            ClipTitle(title: "Forums"),
            RoomHolder()
          ],
        ),
      ),
    );
  }
}
