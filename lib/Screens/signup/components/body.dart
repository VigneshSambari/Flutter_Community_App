// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sessions/Screens/login/login_screen.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/dividers.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:rive/rive.dart';

import 'package:sessions/repositories/user_repository.dart';
import 'package:sessions/screens/entryPoint/entry_point.dart';
import 'package:sessions/screens/signup/components/background.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: RepositoryProvider(
        create: (context) => UserRepository(),
        child: CenterBody(
          size: size,
        ),
      ),
    );
  }
}

class CenterBody extends StatelessWidget {
  CenterBody({
    super.key,
    required this.size,
  });

  final Size size;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onSignUpPress(BuildContext context, UserSignUpSend userData) {
    BlocProvider.of<UserBloc>(context).add(UserSignUpEvent(userData: userData));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(UserIdealEvent()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            showMySnackBar(context, state.error);
          }
          if (state is UserSignedUpState) {
            navigatorPushReplacement(context, EntryPoint());
            showMySnackBar(context, state.message);
          }
        },
        child: Container(
          alignment: Alignment.center,
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
                        "Signup to Community Application",
                        style: titleTextStyle,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SvgPicture.asset(
                        Assets.assetsIconsSignup,
                        height: size.height * 0.35,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      OutlinedInputField(
                        labelText: "Enter your email...",
                        hintText: "abc@gmail.com",
                        prefixIcon: Icon(Icons.person_4),
                        controller: emailController,
                      ),
                      OutlinedInputField(
                        labelText: "Enter your password...",
                        hintText: "",
                        prefixIcon: Icon(Icons.lock),
                        password: true,
                        controller: passwordController,
                      ),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            print("process");
                            UserSignUpSend userData = UserSignUpSend(
                                email: emailController.text,
                                password: passwordController.text);
                            onSignUpPress(context, userData);
                          },
                          child: RoundedButton(
                            title: "Signup",
                            pressEnable: false,
                            onPress: () {
                              print("onpress");
                            },
                          ),
                        );
                      }),
                      HaveAccountOrNot(
                        textValue: "Already have an account? ",
                        linkName: "Login",
                        linkWidget: Loginscreen(),
                      ),
                      OrDivider(),
                      SocialMediaTray()
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
        ),
      ),
    );
  }
}
