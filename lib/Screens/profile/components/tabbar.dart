// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/grids.dart';
import 'package:sessions/screens/profile/components/profile_details.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/utils.dart';

List<ConnectionRoomTile> tiles = [
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
];

class AnimatedTabBar extends StatefulWidget {
  const AnimatedTabBar({Key? key}) : super(key: key);

  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 50,
            //color: kPrimaryLightColor,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Icon(
                  Icons.person_2_outlined,
                  size: 32.5,
                ),
                Icon(
                  Icons.grid_view_rounded,
                  size: 32.5,
                ),
                Icon(
                  Icons.people_alt_outlined,
                  size: 32.5,
                ),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 16.0),
              labelColor: kPrimaryColor,
              unselectedLabelColor: backgroundColor2.withOpacity(0.6),
              indicator: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryLightColor,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProfileDetails(),
                GridBlogs(),
                ProfileConnections(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
