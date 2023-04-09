// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/tabbar.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/utils.dart';

class MyBottomSheet extends StatefulWidget {
  final double minHeight;
  final List<InterestClip> interests;
  final List<LinkClip> links;
  const MyBottomSheet(
      {super.key,
      required this.minHeight,
      required this.interests,
      required this.links});
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late double _currentHeight;
  DraggableScrollableController controller = DraggableScrollableController();
  double maxHeight = 700;

  @override
  void initState() {
    _currentHeight = widget.minHeight - 65;

    controller.addListener(() {
      setState(() {
        _currentHeight = controller.pixels - 80;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    maxHeight = size.height;
    return DraggableScrollableSheet(
      controller: controller,
      snap: true,
      minChildSize: widget.minHeight / MediaQuery.of(context).size.height,
      maxChildSize: maxHeight / MediaQuery.of(context).size.height,
      initialChildSize: widget.minHeight / MediaQuery.of(context).size.height,
      builder: (BuildContext context, ScrollController scrollController) {
        //print(_currentHeight);
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0.0, -2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlurDivider(size: size),
                    Container(
                      height: _currentHeight - 10,
                      child: AnimatedTabBar(
                        interests: widget.interests,
                        links: widget.links,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
