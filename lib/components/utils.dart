// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:math';

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

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

Color getRandomColorFromList() {
  List<Color> myColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black,
    Colors.pink,
    Colors.purple,
    Colors.brown,
    Colors.blueGrey,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.cyan,
  ];
  Random random = Random();
  int index = random.nextInt(myColors.length);
  return myColors[index];
}

Color getRandomRGB() {
  List<Color> myColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  Random random = Random();
  int index = random.nextInt(myColors.length);
  return myColors[index];
}

Widget BackButtonNav() {
  return Builder(
    builder: (context) => Container(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          navigatorPop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    ),
  );
}

class ClipTitle extends StatelessWidget {
  const ClipTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: size.width,
      child: Text(
        title,
        style: TextStyle(
          color: backgroundColor2.withOpacity(0.825),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
