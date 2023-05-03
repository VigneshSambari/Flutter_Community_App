// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/profile.model.dart';

import 'package:sessions/models/session.model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

class VideoCallPage extends StatelessWidget {
  final SessionModel session;
  final ProfileModel profile;
  VideoCallPage({Key? key, required this.session, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallPage(
      session: session,
      profile: profile,
    );
  }
}

/// Note that the userID needs to be globally unique,
final String localUserID = math.Random().nextInt(10000).toString();

class CallPage extends StatelessWidget {
  final String callID;
  final ProfileModel profile;
  final SessionModel session;
  const CallPage({
    Key? key,
    this.callID = "callid",
    required this.session,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: zegoCloudAppId /*input your AppID*/,
        appSign: zegoCloudAppSign! /*input your AppSign*/,
        userID: localUserID,
        userName: profile.userName!,
        callID: session.sessionId,
        config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              /// in minimizing
              ZegoUIKitPrebuiltCallMiniOverlayMachine()
                  .changeState(PrebuiltCallMiniOverlayPageState.idle);
            } else {
              Navigator.of(context).pop();
            }
          }

          /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ],
      ),
    );
  }
}
