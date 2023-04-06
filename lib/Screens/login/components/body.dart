// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/Screens/Login/components/background.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/dividers.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/entryPoint/entry_point.dart';
import 'package:sessions/screens/signup/signup_screen.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          showMySnackBar(context, state.error);
        }
        if (state is UserSignedInState) {
          navigatorPushReplacement(context, EntryPoint());
          showMySnackBar(context, state.message);
        }
      },
      child: Background(
        widget: CenterBody(size: size),
      ),
    );
  }
}

class CenterBody extends StatefulWidget {
  CenterBody({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<CenterBody> createState() => _CenterBodyState();
}

class _CenterBodyState extends State<CenterBody> {
  String? emailError, passwordError;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void onSignUpPress(BuildContext context, UserSignInSend userData) {
    //BlocProvider.of<UserBloc>(context).add(UserIdealEvent());
    BlocProvider.of<UserBloc>(context).add(UserSignInEvent(userData: userData));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login ",
                    style: titleTextStyle,
                  ),
                  SizedBox(
                    height: widget.size.height * 0.02,
                  ),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: widget.size.height * 0.37,
                  ),
                  OutlinedInputField(
                    error: emailError,
                    hintText: 'abc@gmail.com',
                    labelText: 'Enter your email...',
                    prefixIcon: Icon(
                      Icons.person_4,
                      color: kPrimaryColor,
                    ),
                    controller: emailController,
                  ),
                  OutlinedInputField(
                    error: passwordError,
                    labelText: 'Enter your password...',
                    hintText: "",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    controller: passwordController,
                    password: true,
                  ),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          if (emailController.text.isEmpty) {
                            setState(
                              () {
                                emailError = "Email cannot be empty!";
                              },
                            );
                          } else {
                            emailError = null;
                          }
                          if (passwordController.text.isEmpty) {
                            setState(() {
                              passwordError = "Password cannot be empty!";
                            });
                          } else {
                            passwordError = null;
                          }

                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            final currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            UserSignInSend userData = UserSignInSend(
                                email: emailController.text,
                                password: passwordController.text);
                            onSignUpPress(context, userData);
                          }
                        },
                        child: RoundedButton(
                          title: "Login",
                          pressEnable: false,
                          onPress: () {},
                        ),
                      );
                    },
                  ),
                  HaveAccountOrNot(
                    linkName: "SignUp",
                    linkWidget: SignUpScreen(),
                    textValue: "Don't have an account? ",
                  ),
                  OrDivider(),
                  SocialMediaTray(),
                ],
              ),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return CircularProgressIndicatorOnStack();
              }

              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
