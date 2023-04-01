// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/chatScreens/components/clips.dart';

class RoomHolder extends StatefulWidget {
  const RoomHolder({super.key});

  @override
  State<RoomHolder> createState() => _RoomHolderState();
}

class _RoomHolderState extends State<RoomHolder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(10),
      width: size.width,
      //height: size.height * 0.4,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.45),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandableWidget(
            children: [
              RoomClip(title: "Clubs", assetUrl: "assets/chatEntry/clubs.png"),
              RoomClip(
                  title: "Placements",
                  assetUrl: "assets/chatEntry/placement.png"),
              RoomClip(title: "Q&A", assetUrl: "assets/chatEntry/quesans.png"),
              RoomClip(title: "Sales", assetUrl: "assets/chatEntry/sales.png"),
              RoomClip(
                  title: "Notifications",
                  assetUrl: "assets/chatEntry/notification.png"),
              RoomClip(
                  title: "Public", assetUrl: "assets/chatEntry/public.png"),
              RoomClip(
                  title: "Private", assetUrl: "assets/chatEntry/private.png"),
              RoomClip(
                  title: "Attendance",
                  assetUrl: "assets/chatEntry/attendance.png"),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              RoomClip(
                  title: "Public", assetUrl: "assets/chatEntry/public.png"),
              RoomClip(
                  title: "Private", assetUrl: "assets/chatEntry/private.png"),
              RoomClip(
                  title: "Placements",
                  assetUrl: "assets/chatEntry/placement.png"),
              RoomClip(
                  title: "Projects", assetUrl: "assets/chatEntry/projects.png"),
              RoomClip(
                  title: "ChatAI", assetUrl: "assets/chatEntry/chatbot.png"),
              RoomClip(
                  title: "Sessions", assetUrl: "assets/chatEntry/sessions.png"),
            ],
          )
        ],
      ),
    );
  }
}
