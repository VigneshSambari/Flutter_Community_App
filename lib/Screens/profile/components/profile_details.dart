// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/utils.dart';

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
  ProfileDetails({super.key, required this.interests, required this.links});
  final List<LinkClip> links;
  final List<InterestClip> interests;
  @override
  Widget build(BuildContext context) {
    String? email = "", userId = "";
    final userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSignedInState) {
      email = userState.user.email;
      userId = userState.user.userId;
    }
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileCreatedState) {
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsName,
                    subTitle: Text(
                      "${state.profile.name}",
                      style: TextStyle(fontSize: 16),
                    ),
                    title: "Name",
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsMail,
                    subTitle: Text(
                      "$email",
                      style: TextStyle(fontSize: 16),
                    ),
                    title: "Email",
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsCollege,
                    subTitle: Text(
                      "${state.profile.college}",
                      style: TextStyle(fontSize: 16),
                    ),
                    title: "College",
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsSpecialization,
                    subTitle: Text(
                      "${state.profile.specialization}",
                      style: TextStyle(fontSize: 16),
                    ),
                    title: "Specialization",
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsJob,
                    subTitle: Text(
                      "${state.profile.designation}",
                      style: TextStyle(fontSize: 16),
                    ),
                    title: "Designation",
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsInterests,
                    subTitle: Wrap(
                      children: interests.map((interest) {
                        return interest;
                      }).toList(),
                    ),
                    title: "Interests",
                  ),
                  ProfileInfoTile(
                    iconUrl: Assets.assetsProfileiconsLinks,
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
        return Center(
          child: Text(
            "Error in fetching profile",
            style: TextStyle(color: Colors.red),
          ),
        );
      },
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
