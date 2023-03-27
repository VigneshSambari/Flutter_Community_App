// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/screens/profile/components/tiles.dart';

List<InterestClip> interests = [
  InterestClip(title: "Coding"),
  InterestClip(title: "Sleeping"),
  InterestClip(title: "VideoGames"),
  InterestClip(title: "Coding"),
  InterestClip(title: "Sleeping"),
  InterestClip(title: "Games"),
  InterestClip(title: "Playing"),
];

List<LinkClip> links = [
  LinkClip(title: "Github", url: "https://flutter.dev"),
  LinkClip(title: "Linkedin", url: "https://flutter.dev"),
  LinkClip(title: "GooglePhotos", url: "https://flutter.dev"),
  LinkClip(title: "Instagram", url: "https://flutter.dev"),
  LinkClip(title: "Youtube", url: "https://flutter.dev"),
  LinkClip(title: "Social", url: "https://flutter.dev"),
  LinkClip(title: "Facebook", url: "https://flutter.dev"),
];

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileNameEditTray(
              title: "Profile Info.",
              onPressed: () {},
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/name.png",
              subTitle: Text(
                "Vicky",
                style: TextStyle(fontSize: 16),
              ),
              title: "Name",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/specialization.png",
              subTitle: Text(
                "Electronics and Communication",
                style: TextStyle(fontSize: 16),
              ),
              title: "Specialization",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/job.png",
              subTitle: Text(
                "Student",
                style: TextStyle(fontSize: 16),
              ),
              title: "Designation",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/interests.png",
              subTitle: Wrap(
                children: interests.map((interest) {
                  return interest;
                }).toList(),
              ),
              title: "Interests",
            ),
            ProfileInfoTile(
              iconUrl: "assets/profileicons/links.png",
              subTitle: Wrap(
                children: links.map((link) {
                  return link;
                }).toList(),
              ),
              title: "Links",
            ),
          ],
        ),
      ),
    );
  }
}
