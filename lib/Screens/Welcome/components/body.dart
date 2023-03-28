// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/screens/signup/signup_screen.dart';
import 'package:sessions/screens/welcome/components/background.dart';
import 'package:sessions/Screens/Login/login_screen.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/navigations.dart';

import '../../../components/buttons.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: CenterBody(size: size),
    );
  }
}

class CenterBody extends StatelessWidget {
  const CenterBody({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Community Application",
            style: titleTextStyle,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                title: "Login",
                onPress: () {
                  navigatorPush(Loginscreen(), context);
                },
              ),
              RoundedButton(
                title: "SignUp",
                onPress: () {
                  navigatorPush(SignUpScreen(), context);
                },
                color: kPrimaryLightColor,
                textColor: Colors.black,
              )
            ],
          )
        ],
      ),
    );
  }
}
