// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/components/utils.dart';

import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/screens/chatScreens/components/rooms_holder.dart';
import 'package:sessions/screens/chatScreens/create_room.dart';
import 'package:sessions/screens/chatScreens/search_screen.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';

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

List<PairPopMenu> popUpOptions = [
  PairPopMenu(value: 0, option: "Create Room"),
  PairPopMenu(value: 1, option: "View Events"),
  PairPopMenu(value: 2, option: "View Status"),
];

class ChatEntry extends StatefulWidget {
  const ChatEntry({super.key});

  @override
  State<ChatEntry> createState() => _ChatEntryState();
}

class _ChatEntryState extends State<ChatEntry> {
  void onSelectFun({required int value}) {
    if (value == 0) {
      navigatorPush(CreateRoom(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Chat",
        actions: [
          IconButton(
            onPressed: () {
              navigatorPush(
                RoomSearchScreen(
                  searchKey: "",
                  title: "All rooms",
                ),
                context,
              );
            },
            splashRadius: 25,
            icon: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: PopUpMenuWidget(
              options: popUpOptions,
              onSelect: onSelectFun,
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
      color: Colors.white,
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
