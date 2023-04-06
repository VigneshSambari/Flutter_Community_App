// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/Screens/Login/components/background.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/dividers.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/signup/signup_screen.dart';

import '../../../components/input_fields.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      widget: CenterBody(size: size),
    );
  }
}

class CenterBody extends StatelessWidget {
  CenterBody({
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
            "Login ",
            style: titleTextStyle,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.37,
          ),
          OutlinedInputField(
            hintText: 'abc@gmail.com',
            labelText: 'Enter your email...',
            prefixIcon: Icon(
              Icons.person_4,
              color: kPrimaryColor,
            ),
          ),
          OutlinedInputField(
            labelText: 'Enter your password...',
            hintText: "",
            prefixIcon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            password: true,
          ),
          RoundedButton(
              title: "Login",
              onPress: () {
                showMySnackBar(context, "Hello");
              }),
          HaveAccountOrNot(
            linkName: "SignUp",
            linkWidget: SignUpScreen(),
            textValue: "Don't have an account? ",
          ),
          OrDivider(),
          SocialMediaTray(),
        ],
      ),
    );
  }
}
