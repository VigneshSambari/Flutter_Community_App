// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sessions/assets.dart';
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

class CircleImageTile extends StatelessWidget {
  const CircleImageTile({super.key, this.url, this.groupOrPerson = true});

  final String? url;
  final bool groupOrPerson;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          groupOrPerson ? Assets.assetsGlobalGroup : Assets.assetsGlobalUser,
          fit: BoxFit.cover,
        ),
        (url == null || url == "")
            ? SizedBox()
            : Center(
                child: CachedNetworkImage(
                  imageUrl: url!,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  placeholder: (context, url) => Center(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CircularProgressIndicator(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
      ],
    );
  }
}
