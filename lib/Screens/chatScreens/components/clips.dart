// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/chatScreens/components/tiles.dart';

class RoomClip extends StatelessWidget {
  const RoomClip({
    super.key,
    required this.title,
    this.assetUrl = "assets/global/noimage.png",
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final String title;
  final String assetUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CircleAvatar(
              radius: size.width * 0.045,
              backgroundColor: kPrimaryLightColor,
              child: Image.asset(
                assetUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExpandableWidget extends StatefulWidget {
  final List<Widget> children;

  ExpandableWidget({required this.children});

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.55),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // height: size.width * 0.135,
          width: MediaQuery.of(context).size.width * _animation.value +
              size.width * 0.3,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expanded = !_expanded;
                      if (_expanded) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        RoomClip(
                            title: "College",
                            assetUrl: "assets/chatEntry/college.png"),
                        Icon(
                          !_expanded
                              ? Icons.arrow_right_rounded
                              : Icons.arrow_left_rounded,
                          color: backgroundColor2,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_expanded)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [...widget.children],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EventClip extends StatelessWidget {
  const EventClip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.5,
            color: kPrimaryColor.withOpacity(0.65),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double parentWidth = constraints.maxWidth;
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(
                    "assets/icons/chat.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: EventOverlayTile(parentWidth: parentWidth),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        EventPostedByTile(parentWidth: parentWidth),
                      ],
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}

class StatusClip extends StatelessWidget {
  const StatusClip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      child: Stack(
        children: [
          SizedBox(
            width: size.width * 0.27,
            height: size.height * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/global/portrait.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: kPrimaryLightColor,
                    child: Image.asset(
                      "assets/global/user.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
