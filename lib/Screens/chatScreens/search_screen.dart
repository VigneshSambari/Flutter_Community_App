// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sessions/bloc/profile/profile_bloc.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/models/room.model.dart';
import 'package:sessions/notifications/onesignal/push_notifications.dart';
import 'package:sessions/repositories/room_repository.dart';
import 'package:sessions/utils/classes.dart';

class RoomSearchScreen extends StatefulWidget {
  final String title;
  final String searchKey;
  RoomSearchScreen({super.key, required this.title, required this.searchKey});

  @override
  State<RoomSearchScreen> createState() => _RoomSearchScreenState();
}

class _RoomSearchScreenState extends State<RoomSearchScreen> {
  TextEditingController searchController = TextEditingController();
  RoomRepository roomRepository = RoomRepository();
  List<RoomModel> queryRooms = [];
  bool isLoading = false, isDisposed = false;
  late ProfileModel profile;
  @override
  void initState() {
    fetchProfile();
    BlocProvider.of<ProfileBloc>(context)
        .add(LoadProfileEvent(userId: profile.userId!));
    fetchRooms();
    super.initState();
  }

  void fetchProfile() {
    ProfileState profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileCreatedState) {
      profile = profileState.profile;
    }
    setState(() {
      queryRooms;
    });
  }

  Future<void> fetchRooms() async {
    setState(() {
      isLoading = true;
    });
    try {
      queryRooms = await roomRepository.searchRooms(
        httpData: SearchRoomSend(
          type: widget.searchKey,
          query: searchController.text,
        ),
      );
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
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (profile is ProfileCreatedState) {
          fetchProfile();
        }
      },
      child: Scaffold(
        appBar: CurvedAppBar(
          title: widget.title,
          actions: [],
          leading: BackButtonNav(),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          margin: EdgeInsets.all(5),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileCreatedState) {
                profile = state.profile;
              }
              return SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    SearchBar(controller: searchController, fetch: fetchRooms),
                    isLoading
                        ? LoadingIndicator(
                            circularBlue: true,
                          )
                        : Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: queryRooms.length,
                              itemBuilder: (context, index) {
                                List<RoomItem> joinedRoomIds =
                                    profile.rooms ?? [];
                                List<IdObject> requestSend =
                                    profile.requestsSent ?? [];
                                String status = "Join";
                                RoomModel currRoom = queryRooms[index];

                                for (RoomItem room in joinedRoomIds) {
                                  if (room.id == currRoom.roomId) {
                                    status = "Joined";

                                    break;
                                  }
                                }

                                for (IdObject item in requestSend) {
                                  if (item.id == currRoom.roomId) {
                                    status = "Pending";
                                    break;
                                  }
                                }
                                return SearchRoomTile(
                                  status: status,
                                  room: queryRooms[index],
                                  roomId: currRoom.roomId ?? "",
                                  userId: profile.userId ?? "",
                                  userName: profile.userName ?? "",
                                );
                              },
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SearchRoomTile extends StatefulWidget {
  final RoomModel room;
  final String status;
  final String userId;
  final String roomId;
  final String userName;
  SearchRoomTile(
      {super.key,
      required this.room,
      required this.status,
      required this.userId,
      required this.roomId,
      this.userName = ""});

  @override
  State<SearchRoomTile> createState() => _SearchRoomTileState();
}

class _SearchRoomTileState extends State<SearchRoomTile> {
  Color color = kPrimaryColor;
  String currentStatus = "";
  bool isDisposed = false, isLoading = false;
  RoomRepository roomRepository = RoomRepository();
  final PushNotifications notifications = PushNotifications();

  @override
  void initState() {
    currentStatus = widget.status;
    super.initState();
  }

  Future<void> joinRoom() async {
    setState(() {
      isLoading = true;
    });
    String number = "0";
    try {
      number = await roomRepository.joinRoom(
        httpData: JoinLeaveRoomSend(
          userId: widget.userId,
          roomId: widget.roomId,
          joinOrLeave: "join",
        ),
      );

      if (number == "1") {
        notifications.sendPushNotification(
            externalUserIds: [widget.room.createdBy!],
            title: "Room join request!",
            message:
                "You received a join request from ${widget.userName} to join ${widget.room.name}");
      }
    } catch (error) {
      showMySnackBar(context, error.toString());
    }
    if (isDisposed || !mounted) {
      return;
    }
    setState(() {
      if (number == "1") {
        currentStatus = "Pending";
      } else if (number == "2") {
        currentStatus = "Joined";
      }
      isLoading = false;
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentStatus == "Joined") {
      color = Colors.green;
    } else if (currentStatus == "Pending") {
      color = Colors.orange;
    }
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CircleImageTile(
            url: widget.room.coverPic == null
                ? ""
                : widget.room.coverPic!.secureUrl,
          ),
        ),
      ),
      title: Text(widget.room.name ?? ""),
      subtitle: Text(widget.room.description ?? ""),
      trailing: GestureDetector(
        onTap: () {
          if (currentStatus == "Join") {
            joinRoom();
          }
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
          child: isLoading
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  currentStatus,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
