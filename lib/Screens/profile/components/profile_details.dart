// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/utils.dart';

List<InterestClip> interests = [
  InterestClip(title: "Coding"),
  InterestClip(title: "Sleeping"),
  InterestClip(title: "VideoGames"),
  InterestClip(title: "Coding"),
  InterestClip(title: "Sleeping"),
  InterestClip(title: "Games"),
  InterestClip(title: "Playing"),
];

List<LinkClip> links = [
  LinkClip(title: "Github", url: "https://flutter.dev"),
  LinkClip(title: "Linkedin", url: "https://flutter.dev"),
  LinkClip(title: "GooglePhotos", url: "https://flutter.dev"),
  LinkClip(title: "Instagram", url: "https://flutter.dev"),
  LinkClip(title: "Youtube", url: "https://flutter.dev"),
  LinkClip(title: "Social", url: "https://flutter.dev"),
  LinkClip(title: "Facebook", url: "https://flutter.dev"),
];

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileNameEditTray(
              title: "Profile Info.",
              icon: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/name.png",
              subTitle: Text(
                "Vicky",
                style: TextStyle(fontSize: 16),
              ),
              title: "Name",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/mail.png",
              subTitle: Text(
                "vickysam@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
              title: "Email",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/specialization.png",
              subTitle: Text(
                "Electronics and Communication",
                style: TextStyle(fontSize: 16),
              ),
              title: "Specialization",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/job.png",
              subTitle: Text(
                "Student",
                style: TextStyle(fontSize: 16),
              ),
              title: "Designation",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/interests.png",
              subTitle: Wrap(
                children: interests.map((interest) {
                  return interest;
                }).toList(),
              ),
              title: "Interests",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/links.png",
              subTitle: Wrap(
                children: links.map((link) {
                  return link;
                }).toList(),
              ),
              title: "Links",
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileConnections extends StatelessWidget {
  const ProfileConnections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 3,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ProfileNameEditTray(
                    title: "Connections",
                    icon: Container(),
                  ),
                ),
                PopupMenuButton(
                  iconSize: 32.5,
                  shape: Border.all(
                    width: 2,
                    color: kPrimaryColor,
                  ),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text(
                          'Connections',
                          style: popUpMenuItemStyle(),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Rooms',
                          style: popUpMenuItemStyle(),
                        ),
                        value: 2,
                      ),
                    ];
                  },
                  onSelected: (value) {
                    // Do something when a menu item is selected
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: backgroundColor2.withOpacity(0.85),
                  ),
                ),
              ],
            ),
            ConnectionRoomTile(
              iconUrl:
                  "https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              subTitle: "Room desc",
              title: "Room Name",
              trailing: ConnectionRoomButton(title: "connect"),
            ),
            ConnectionRoomTile(
              iconUrl:
                  "https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              subTitle: "Room desc",
              title: "Room Name",
              trailing: ConnectionRoomButton(title: "connect"),
            ),
            ConnectionRoomTile(
              iconUrl:
                  "https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              subTitle: "Room desc",
              title: "Room Name",
              trailing: ConnectionRoomButton(title: "connect"),
            ),
            ConnectionRoomTile(
              iconUrl:
                  "https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              subTitle: "Room desc",
              title: "Room Name",
              trailing: ConnectionRoomButton(title: "connect"),
            ),
            ConnectionRoomTile(
              iconUrl:
                  "https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              subTitle: "Room desc",
              title: "Room Name",
              trailing: ConnectionRoomButton(title: "connect"),
            ),
            ConnectionRoomTile(
              iconUrl:
                  "https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              subTitle: "Room desc",
              title: "Room Name",
              trailing: ConnectionRoomButton(title: "connect"),
            ),
          ],
        ),
      ),
    );
  }
}
