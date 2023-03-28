// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

class BlurDivider extends StatelessWidget {
  const BlurDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 3.5,
      width: size.width * 0.18,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: kPrimaryColor.withOpacity(0.6),
          )
        ],
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class ConnectionRoomButton extends StatelessWidget {
  const ConnectionRoomButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: kPrimaryColor,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
