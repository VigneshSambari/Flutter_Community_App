// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/room/room_bloc.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/utils/classes.dart';

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
          List<IdObject> roomIds = [];
          for (RoomItem item in state.profile.rooms ?? []) {
            roomIds.add(IdObject(item.id));
          }
          for (IdObject item in state.profile.requestsSent ?? []) {
            roomIds.add(IdObject(item.id));
          }
          BlocProvider.of<RoomBloc>(context)
              .add(LoadListedRoomsEvent(ids: IdList(ids: roomIds)));
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
        if (state is ProfileErrorState) {
          return Center(
            child: Text(
              "Error in fetching profile",
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
}

class ProfileConnections extends StatefulWidget {
  const ProfileConnections({
    super.key,
  });

  @override
  State<ProfileConnections> createState() => _ProfileConnectionsState();
}

class _ProfileConnectionsState extends State<ProfileConnections> {
  late String userId;
  String title = "Rooms";
  @override
  void initState() {
    UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSignedInState) {
      userId = userState.user.userId!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 3,
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileCreatedState) {
            return BlocBuilder<RoomBloc, RoomState>(
              builder: (context, roomState) {
                if (roomState is RoomLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ProfileNameEditTray(
                                title: title,
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
                                    value: "Connections",
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      'Rooms',
                                      style: popUpMenuItemStyle(),
                                    ),
                                    value: "Rooms",
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                setState(() {
                                  title = value;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                                color: backgroundColor2.withOpacity(0.85),
                              ),
                            ),
                          ],
                        ),
                        ExistingRoomTitle(title: "Joined Rooms"),
                        ...roomState.rooms.map((room) {
                          for (RoomItem item
                              in profileState.profile.rooms ?? []) {
                            if (item.id == room.roomId!) {
                              return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: CircleImageTile(
                                          url: room.coverPic == null
                                              ? ""
                                              : room.coverPic!.secureUrl),
                                    ),
                                  ),
                                  title: Text(room.name!),
                                  subtitle: Text(room.description ?? ""),
                                  trailing: ListTileTrailing(
                                    color: Colors.red,
                                    title: "Exit",
                                  ));
                            }
                          }
                          return SizedBox();
                        }).toList(),
                        ExistingRoomTitle(title: "Room Requests Sent"),
                        ...roomState.rooms.map((room) {
                          for (IdObject item
                              in profileState.profile.requestsSent ?? []) {
                            if (item.id == room.roomId!) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: CircleImageTile(
                                        url: room.coverPic == null
                                            ? ""
                                            : room.coverPic!.secureUrl),
                                  ),
                                ),
                                title: Text(room.name!),
                                subtitle: Text(room.description ?? ""),
                                trailing: ListTileTrailing(
                                    color: Colors.orange, title: "Cancel"),
                              );
                            }
                          }
                          return SizedBox();
                        }).toList(),
                        SizedBox(
                          height: 150,
                        )
                      ],
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
          if (profileState is ProfileErrorState) {
            return Center(
              child: Text(
                profileState.error,
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
