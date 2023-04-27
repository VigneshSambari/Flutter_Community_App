// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/profile_image_utils.dart';

class PhotoTray extends StatelessWidget {
  PhotoTray(
      {super.key,
      required this.coverPhoto,
      required this.profilePic,
      required this.userName});
  final String? coverPhoto, profilePic, userName;

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
                coverPhoto == null
                    ? SizedBox()
                    : CoverPhotoNetwok(
                        coverPicPath: coverPhoto!,
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
                SizedBox(
                  width: size.width * 0.25,
                  height: size.width * 0.25,
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: profilePic == null
                        ? SizedBox()
                        : ProfileImageNetwork(
                            radius: 60,
                            profilePicPath: profilePic!,
                          ),
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                SizedBox(
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
                              userName!,
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
