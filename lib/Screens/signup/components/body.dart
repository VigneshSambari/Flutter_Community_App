// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/Screens/login/login_screen.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/dividers.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/screens/signup/components/background.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

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
            "Signup to Sessions",
            style: titleTextStyle,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SvgPicture.asset(
            "assets/icons/signup.svg",
            height: size.height * 0.35,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          OutlinedInputField(
            labelText: "Enter your email...",
            hintText: "abc@gmail.com",
            prefixIcon: Icon(Icons.person_4),
          ),
          OutlinedInputField(
            labelText: "Enter your password...",
            hintText: "",
            prefixIcon: Icon(Icons.lock),
            password: true,
          ),
          RoundedButton(
            title: "Signup",
            onPress: () {},
          ),
          HaveAccountOrNot(
            textValue: "Already have an account? ",
            linkName: "Login",
            linkWidget: Loginscreen(),
          ),
          OrDivider(),
          SocialMediaTray()
        ],
      ),
    );
  }
}
