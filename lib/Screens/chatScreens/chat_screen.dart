// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/circle_avatars.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/blogScreens/preview_blog.dart';
import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/screens/chatScreens/components/status.dart';

List<EventClip> events = [
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Chat",
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            children: [
              CircleNetworkPicture(),
            ],
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                BottomSheetWidget(
                  constraints: constraints,
                  child: StatusSlider(),
                  rightPosition: 0,
                ),
                BottomSheetWidget(
                  constraints: constraints,
                  child:
                      CarouselSlider(height: size.height * 0.25, items: events),
                  rightPosition: 25,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    Key? key,
    required this.constraints,
    required this.child,
    required this.rightPosition,
  }) : super(key: key);
  final BoxConstraints constraints;
  final Widget child;
  final double rightPosition;
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isSheetOpen = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _offsetAnimation = Tween<Offset>(begin: Offset(0.0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: screenHeight * 0.65,
          child: SlideTransition(
            position: _offsetAnimation,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: kPrimaryLightColor,
                  ),
                  child: Center(
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: _isSheetOpen
              ? screenHeight * 0.65
              : widget.constraints.maxHeight - 45,
          right: widget.rightPosition,
          child: SlideTransition(
            position: _offsetAnimation,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSheetOpen = !_isSheetOpen;
                  if (_isSheetOpen) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
