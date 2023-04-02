import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

class CircleNetworkPicture extends StatelessWidget {
  const CircleNetworkPicture({super.key, this.url = ""});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: kPrimaryColor,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: kPrimaryLightColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            "assets/global/user.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
