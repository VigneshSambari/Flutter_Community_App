// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/navigations.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot({
    super.key,
    required this.textValue,
    required this.linkName,
    required this.linkWidget,
  });

  final String textValue;
  final String linkName;
  final Widget linkWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textValue,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            navigatorPop(context);
            navigatorPush(linkWidget, context);
          },
          child: Text(
            linkName,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    super.key,
    required this.srcLink,
    required this.onPress,
  });

  final String srcLink;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          border: Border.all(
            width: 2,
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          srcLink,
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}

class SocialMediaTray extends StatelessWidget {
  const SocialMediaTray({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIcon(
          srcLink: "assets/icons/facebook.svg",
          onPress: () {},
        ),
        SocialMediaIcon(
          srcLink: "assets/icons/google-plus.svg",
          onPress: () {},
        ),
        SocialMediaIcon(
          srcLink: "assets/icons/twitter.svg",
          onPress: () {},
        )
      ],
    );
  }
}

class NavHighlighter extends StatelessWidget {
  const NavHighlighter({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(
        bottom: 2,
      ),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white60,
        ),
      ),
    );
  }
}
