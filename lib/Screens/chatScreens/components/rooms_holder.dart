// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/room.model.dart';
import 'package:sessions/screens/chatScreens/chats_display.dart';
import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/utils/enums.dart';
import 'package:sessions/utils/navigations.dart';

class RoomHolder extends StatefulWidget {
  RoomHolder({super.key});

  @override
  State<RoomHolder> createState() => _RoomHolderState();
}

class _RoomHolderState extends State<RoomHolder> {
  late final List<RoomModel> rooms;

  void pushRoomfun({required RoomTypesEnum roomType}) {
    navigatorPush(ChatsDisplay(roomType: roomType), context);
  }

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
              RoomClip(
                title: "Clubs",
                assetUrl: Assets.assetsChatEntryClubs,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegeClub,
              ),
              RoomClip(
                title: "Placements",
                assetUrl: Assets.assetsChatEntryPlacement,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegePlacement,
              ),
              RoomClip(
                title: "Q&A",
                assetUrl: Assets.assetsChatEntryQuesans,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegeQA,
              ),
              RoomClip(
                title: "Sales",
                assetUrl: Assets.assetsChatEntrySales,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegeSales,
              ),
              RoomClip(
                title: "Notifications",
                assetUrl: Assets.assetsChatEntryNotification,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegeNotifications,
              ),
              RoomClip(
                title: "Public",
                assetUrl: Assets.assetsChatEntryPublic,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegePublic,
              ),
              RoomClip(
                title: "Private",
                assetUrl: Assets.assetsChatEntryPrivate,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.collegePrivate,
              ),
              RoomClip(
                title: "Attendance",
                assetUrl: Assets.assetsChatEntryAttendance,
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              RoomClip(
                title: "Public",
                assetUrl: Assets.assetsChatEntryPublic,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.userPublic,
              ),
              RoomClip(
                title: "Private",
                assetUrl: Assets.assetsChatEntryPrivate,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.userPrivate,
              ),
              RoomClip(
                title: "Placements",
                assetUrl: Assets.assetsChatEntryPlacement,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.userPlacement,
              ),
              RoomClip(
                title: "Projects",
                assetUrl: Assets.assetsChatEntryProjects,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.userProject,
              ),
              RoomClip(
                title: "Chats",
                assetUrl: Assets.assetsChatEntryChat,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.userChats,
              ),
              RoomClip(
                title: "Sessions",
                assetUrl: Assets.assetsChatEntrySessions,
                onPressed: pushRoomfun,
                roomType: RoomTypesEnum.userSessions,
              ),
            ],
          )
        ],
      ),
    );
  }
}
