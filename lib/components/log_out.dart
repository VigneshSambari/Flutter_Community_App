// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/welcome/welcome_screen.dart';
import 'package:sessions/utils/navigations.dart';
import '../bloc/user/user_bloc_imports.dart';

Future<void> clearBlocStates(BuildContext context) async {
  await HydratedBloc.storage.clear();
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await clearBlocStates(context);
        BlocProvider.of<UserBloc>(context).add(UserIdealEvent());
        // navigatorPopAllExceptFirst(context);
        // navigatorPushReplacement(context, WelcomeScreen());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor2.withOpacity(0.75),
          borderRadius: BorderRadius.circular(7.5),
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        )),
      ),
    );
  }
}
