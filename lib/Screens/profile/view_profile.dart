// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/bottom_sheet.dart';
import 'package:sessions/screens/profile/components/profile_image_utils.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Profile",
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
            ),
          ),
        ],
        leading: Container(),
      ),
      body: ViewProfileBody(),
    );
  }
}

class ViewProfileBody extends StatelessWidget {
  const ViewProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          // padding: EdgeInsets.symmetric(5),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              PhotoTray(
                coverPhoto: "",
                profilePic: "",
                userName: "VickySam1901",
              ),
              MyBottomSheet(
                minHeight: size.height * 0.675,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class PhotoTray extends StatelessWidget {
  const PhotoTray(
      {super.key,
      required this.coverPhoto,
      required this.profilePic,
      required this.userName});
  final String coverPhoto, profilePic, userName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.325,
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(5),
            child: Stack(
              children: [
                coverPhoto == ""
                    ? SizedBox()
                    : CoverPhoto(
                        profilePicPath: coverPhoto,
                        size: size,
                      ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            bottom: 15,
            child: Row(
              children: [
                Container(
                  color: kPrimaryColor,
                  width: size.width * 0.25,
                  height: size.width * 0.25,
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: profilePic == ""
                        ? SizedBox()
                        : ProfileImage(
                            radius: 60,
                            profilePicPath: profilePic,
                          ),
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                Container(
                  width: size.width,
                  height: size.width * 0.25,
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.5,
                              vertical: 5,
                            ),
                            child: Text(
                              userName,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
