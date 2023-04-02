// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/screens/chatScreens/components/clips.dart';

class StatusSlider extends StatelessWidget {
  const StatusSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: size.width,
      height: size.height * 0.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            StatusClip(),
            StatusClip(),
            StatusClip(),
            StatusClip(),
            StatusClip(),
            StatusClip(),
            StatusClip(),
            StatusClip(),
          ],
        ),
      ),
    );
  }
}
