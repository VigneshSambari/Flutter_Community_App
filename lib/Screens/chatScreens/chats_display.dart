// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/screens/chatScreens/components/status.dart';
import 'package:sessions/screens/chatScreens/components/tiles.dart';

class ChatsDisplay extends StatefulWidget {
  const ChatsDisplay({super.key});

  @override
  State<ChatsDisplay> createState() => _ChatsDisplayState();
}

class _ChatsDisplayState extends State<ChatsDisplay> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CurvedAppBar(
        title: "... Chats",
        actions: [],
        leading: BackButtonNav(),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SearchBar(controller: searchController),
              StatusSlider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                height: size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatsTile(size: size);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
