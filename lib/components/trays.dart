// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

class ProfileNameEditTray extends StatelessWidget {
  const ProfileNameEditTray({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kPrimaryDarkColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(right: 0, child: icon)
        ],
      ),
    );
  }
}
