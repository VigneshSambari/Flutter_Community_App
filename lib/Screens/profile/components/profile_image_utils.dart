// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sessions/components/file_pickers.dart';
import 'package:sessions/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddImageIcon extends StatelessWidget {
  const AddImageIcon({
    super.key,
    required this.setProfile,
    this.iconSize = 20,
    this.plusRadius = 10,
    this.picIconSize = 50,
  });

  final Function setProfile;
  final double iconSize, plusRadius, picIconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        File? selectedFile = await pickFile(allowMultipleFiles: false);
        if (selectedFile != null) {
          String filePath = await saveFile(
            file: selectedFile,
            folderName: "Profile",
          );
          setProfile(filePath);
        }
      },
      child: Stack(
        children: [
          Icon(
            Icons.image,
            color: kPrimaryColor,
            size: picIconSize,
          ),
          CircleAvatar(
            radius: plusRadius,
            child: Icon(
              Icons.add,
              size: iconSize,
            ),
          )
        ],
      ),
    );
  }
}

class CoverPhoto extends StatelessWidget {
  const CoverPhoto({
    super.key,
    required this.profilePicPath,
    required this.size,
    this.height = 230,
  });

  final String profilePicPath;
  final Size size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.file(
        File(profilePicPath),
        fit: BoxFit.cover,
        height: height == 0 ? null : height,
        width: size.width,
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.profilePicPath,
    required this.radius,
  });

  final String profilePicPath;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        backgroundColor: kPrimaryLightColor,
        radius: radius,
        child: Image.file(
          File(profilePicPath),
          fit: BoxFit.fitHeight,
          height: radius * 3,
          width: radius * 3,
        ),
      ),
    );
  }
}

class CoverPhotoNetwok extends StatelessWidget {
  const CoverPhotoNetwok({
    super.key,
    required this.coverPicPath,
    required this.size,
    this.height = 230,
  });

  final String coverPicPath;
  final Size size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: coverPicPath,
          fit: BoxFit.cover,
          height: height,
          width: size.width,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}

class ProfileImageNetwork extends StatelessWidget {
  const ProfileImageNetwork({
    super.key,
    required this.profilePicPath,
    required this.radius,
  });

  final String profilePicPath;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        backgroundColor: kPrimaryLightColor,
        radius: radius,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: profilePicPath,
            fit: BoxFit.cover,
            height: radius * 2,
            width: radius * 2,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
        ),
      ),
    );
  }
}
