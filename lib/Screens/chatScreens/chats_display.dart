// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/bloc/room/room_bloc_imports.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/chatScreens/chat_screen.dart';
import 'package:sessions/screens/chatScreens/components/status.dart';
import 'package:sessions/screens/chatScreens/components/tiles.dart';
import 'package:sessions/utils/enums.dart';
import 'package:sessions/utils/navigations.dart';
import 'package:sessions/utils/util_methods.dart';

class ChatsDisplay extends StatefulWidget {
  final RoomTypesEnum roomType;
  const ChatsDisplay({super.key, required this.roomType});

  @override
  State<ChatsDisplay> createState() => _ChatsDisplayState();
}

class _ChatsDisplayState extends State<ChatsDisplay> {
  bool _isOpen1 = false;
  bool _isOpenWidget = false;

  @override
  void initState() {
    BlocProvider.of<RoomBloc>(context)
        .add(LoadRoomsEvent(type: getRoomType(type: widget.roomType)));
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final roomState = BlocProvider.of<RoomBloc>(context).state;
    return Scaffold(
      appBar: CurvedAppBar(
        title: (roomState is RoomLoadedState)
            ? getRoomTitles(type: widget.roomType)
            : "... Chats",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              splashRadius: 25,
              onPressed: () {
                navigatorPush(SizedBox(), context);
              },
              icon: Icon(Icons.search),
            ),
          )
        ],
        leading: BackButtonNav(),
      ),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoadedState) {
            final rooms = state.rooms;
            return Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    //SearchBar(controller: searchController),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen1 = true;
                          _isOpenWidget = true;
                        });
                      },
                      child: AnimatedContainer(
                        margin:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                        duration: Duration(milliseconds: 300),
                        width: size.width,
                        height: _isOpen1 ? size.height * 0.28 : 35,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: _isOpenWidget
                            ? SizedBox(
                                //height: _isOpen1 ? size.height * 0.28 : 0,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: StatusSlider(),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: CircleAvatar(
                                          backgroundColor: kPrimaryColor,
                                          child: Icon(
                                            Icons.arrow_drop_up_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isOpen1 = false;
                                          });
                                          Future.delayed(
                                              Duration(milliseconds: 200), () {
                                            setState(() {
                                              _isOpenWidget = false;
                                            });
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.5),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Status...",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kPrimaryDarkColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: kPrimaryColor,
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      height: size.height,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 5));
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: rooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                navigatorPush(
                                    ChatScreen(
                                      roomData: rooms[index],
                                    ),
                                    context);
                              },
                              child: Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.check,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                direction: DismissDirection.horizontal,
                                confirmDismiss: (direction) async {
                                  final bool confirm = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirm"),
                                        content: const Text(
                                            "Are you sure you wish to leave this room?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text("LEAVE"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("CANCEL"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return confirm;
                                },
                                onDismissed: (direction) {
                                  setState(() {
                                    rooms.removeAt(index);
                                  });
                                },
                                child: ChatsTile(
                                  size: size,
                                  roomData: state.rooms[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is RoomErrorState) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(
                  color: Colors.red,
                ),
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
