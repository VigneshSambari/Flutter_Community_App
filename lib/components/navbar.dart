import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/rive_utils.dart';

class NavBarAnimated extends StatefulWidget {
  const NavBarAnimated({super.key});

  @override
  State<NavBarAnimated> createState() => _NavBarAnimatedState();
}

class _NavBarAnimatedState extends State<NavBarAnimated> {
  RiveAsset selectedBottomNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor2.withOpacity(0.825),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            bottomNavs.length,
            (index) => GestureDetector(
              onTap: () {
                bottomNavs[index].input!.change(true);
                if (bottomNavs[index] != selectedBottomNav) {
                  setState(() {
                    selectedBottomNav = bottomNavs[index];
                  });
                }
                Future.delayed(Duration(seconds: 1), () {
                  bottomNavs[index].input!.change(false);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NavHighlighter(
                    isActive: bottomNavs[index] == selectedBottomNav,
                  ),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: RiveAnimation.asset(
                      bottomNavs[index].src,
                      artboard: bottomNavs[index].artboard,
                      onInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(
                          artboard,
                          stateMachineName: bottomNavs[index].stateMachineName,
                        );
                        bottomNavs[index].input =
                            controller.findSMI("active") as SMIBool;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Timer",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notifications",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
    src: "assets/riveAssets/icons.riv",
  ),
];
