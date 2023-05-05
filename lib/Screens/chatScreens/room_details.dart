// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/models/room.model.dart';
import 'package:sessions/models/session.model.dart';
import 'package:sessions/notifications/onesignal/push_notifications.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/repositories/room_repository.dart';
import 'package:sessions/repositories/session_repository.dart';
import 'package:sessions/utils/classes.dart';

class RoomDetails extends StatefulWidget {
  final RoomModel room;
  final bool isSession;
  const RoomDetails({super.key, required this.room, this.isSession = false});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  ProfileRepository profileRepository = ProfileRepository();
  RoomRepository roomRepository = RoomRepository();
  SessionRepository sessionRepository = SessionRepository();
  PushNotifications pushNotifications = PushNotifications();
  List<ProfileModel> joinedProfiles = [];
  List<ProfileModel> requestProfiles = [];
  bool iAmAdmin = false;
  bool isLoading = false, isDisposed = false;
  @override
  void initState() {
    fetchProfile();
    super.initState();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  void loadProfile() async {
    UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSignedInState) {
      ProfileState profileState = BlocProvider.of<ProfileBloc>(context).state;
      if (profileState is ProfileCreatedState) {
        if (widget.room.createdBy == profileState.profile.userId) {
          iAmAdmin = true;
        }
      }
    }
  }

  Future<void> addUserRoom({required ProfileModel profile}) async {
    try {
      await roomRepository.addUserToGroup(
        httpData: JoinLeaveRoomSend(
            userId: profile.userId!,
            roomId: widget.room.roomId ?? "",
            joinOrLeave: ""),
      );
      if (widget.isSession) {
        SessionModel session = await sessionRepository.findByRoomID(
            httpData: IdObject(widget.room.roomId ?? ""));

        await sessionRepository.addSession(
            httpData: SessionAddRemove(
          userId: profile.userId!,
          sessionId: session.sessionId,
        ));
      }
      pushNotifications.sendPushNotification(
        externalUserIds: [profile.userId!],
        title: " Join request accepted!",
        message:
            "You request to join ${widget.isSession ? "session" : "room"} : ${widget.room.name} has been accepted.",
      );
      int index = 0;

      for (var item in requestProfiles) {
        if (item.userId == profile.userId) {
          break;
        }
        index++;
      }
      requestProfiles.removeAt(index);
      widget.room.requests?.removeAt(index);
      widget.room.users?.add(IdObject(profile.userId));
      joinedProfiles.add(profile);
      if (isDisposed || !mounted) {
        return;
      }
      setState(() {
        joinedProfiles;
        requestProfiles;
      });
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
  }

  Future<void> removeUserGroup({required ProfileModel profile}) async {
    try {
      await roomRepository.removeUserFromGroup(
        httpData: JoinLeaveRoomSend(
            userId: profile.userId!,
            roomId: widget.room.roomId ?? "",
            joinOrLeave: ""),
      );

      pushNotifications.sendPushNotification(
          externalUserIds: [profile.userId!],
          title: "You have been removed from ${widget.room.name}!",
          message:
              "You are no longer a member of room: ${widget.room.name}. Request again to join!");
      int index = 0;

      for (var item in joinedProfiles) {
        if (item.userId == profile.userId) {
          break;
        }
        index++;
      }
      joinedProfiles.removeAt(index);
      widget.room.users?.removeAt(index);
      if (isDisposed || !mounted) {
        return;
      }
      setState(() {
        joinedProfiles;
        requestProfiles;
      });
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
  }

  void fetchProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      for (IdObject item in widget.room.users ?? []) {
        ProfileModel? profile =
            await profileRepository.fetchPublicProfiles(userId: item.id);
        joinedProfiles.add(profile!);
      }
      for (IdObject item in widget.room.requests ?? []) {
        ProfileModel? profile =
            await profileRepository.fetchPublicProfiles(userId: item.id);
        requestProfiles.add(profile!);
      }
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
    if (isDisposed || !mounted) {
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Details",
        actions: [],
        leading: BackButtonNav(),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(5),
        child: isLoading
            ? LoadingIndicator(
                circularBlue: true,
              )
            : Column(
                children: [
                  ExistingRoomTitle(title: "Users"),
                  ...joinedProfiles.map((profile) {
                    return ListTileUser(
                      title: "Remove",
                      color: Colors.red,
                      profile: profile,
                      callBack: removeUserGroup,
                      admin:
                          iAmAdmin && widget.room.createdBy != profile.userId,
                    );
                  }).toList(),
                  ExistingRoomTitle(title: "Join requests"),
                  ...requestProfiles.map((profile) {
                    return ListTileUser(
                      title: "Add",
                      color: Colors.green,
                      profile: profile,
                      callBack: addUserRoom,
                      admin:
                          iAmAdmin && widget.room.createdBy != profile.userId,
                    );
                  }).toList(),
                ],
              ),
      ),
    );
  }
}

class ListTileUser extends StatefulWidget {
  final ProfileModel profile;
  final Color color;
  final String title;
  final bool admin;
  final Function({required ProfileModel profile}) callBack;

  const ListTileUser({
    super.key,
    required this.profile,
    required this.color,
    required this.title,
    required this.callBack,
    this.admin = false,
  });

  @override
  State<ListTileUser> createState() => _ListTileUserState();
}

class _ListTileUserState extends State<ListTileUser> {
  bool isLoading = false, isDisposed = false;
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kPrimaryColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CircleImageTile(
            url: widget.profile.profilePic == null
                ? ""
                : widget.profile.profilePic!.secureUrl,
          ),
        ),
      ),
      title: Text(widget.profile.userName ?? ""),
      subtitle: Text(widget.profile.name ?? ""),
      trailing: widget.admin
          ? SizedBox()
          : GestureDetector(
              onTap: () async {
                if (isDisposed || !mounted) return;
                setState(() {
                  isLoading = true;
                });
                await widget.callBack(profile: widget.profile);
                setState(() {
                  isLoading = false;
                });
              },
              child: isLoading
                  ? Container(
                      height: 20,
                      width: 20,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.color,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : ListTileTrailing(
                      color: widget.color,
                      title: widget.title,
                    ),
            ),
    );
  }
}
