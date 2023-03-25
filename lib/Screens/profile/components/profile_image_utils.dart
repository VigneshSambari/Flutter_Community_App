import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sessions/components/file_pickers.dart';
import 'package:sessions/constants.dart';

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
        File? selectedFile = await pickFile();
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

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.profilePicPath,
    required this.size,
  });

  final String profilePicPath;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.file(
        File(profilePicPath),
        fit: BoxFit.cover,
        height: 230,
        width: size.width,
      ),
    );
  }
}
