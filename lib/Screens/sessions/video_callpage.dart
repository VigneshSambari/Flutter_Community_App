import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

class VideoCallPage extends StatelessWidget {
  /// Users who use the same callID can in the same call.
  final callIDTextCtrl = TextEditingController(text: "call_id");

  VideoCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallPage();
  }
}

/// Note that the userID needs to be globally unique,
final String localUserID = math.Random().nextInt(10000).toString();

class CallPage extends StatelessWidget {
  final String callID;

  const CallPage({
    Key? key,
    this.callID = "callid",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 986122463 /*input your AppID*/,
        appSign:
            "9f715aac3a5f82878d2f1b168f21e0309d9300451c792f69ea4b93779dc0c189" /*input your AppSign*/,
        userID: localUserID,
        userName: "user_$localUserID",
        callID: callID,
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
