// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/rive_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenuItem = browseMenu.first;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor2.withOpacity(0.8),
          width: 275,
          height: size.height,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InfoCard(
                  title: "VickySam1901",
                  subtitle: "Student",
                ),
                SideMenuCategory(
                  title: "Browse",
                ),
                ...browseMenu.map(
                  (menu) => SideMenuTile(
                    isActive: selectedMenuItem == menu,
                    menu: menu,
                    press: () {
                      menu.input!.change(true);
                      setState(() {
                        selectedMenuItem = menu;
                      });
                      Future.delayed(
                        Duration(milliseconds: 100),
                        () {
                          menu.input!.change(false);
                        },
                      );
                    },
                    riveInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: menu.stateMachineName,
                      );
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                  ),
                ),
                SideMenuCategory(
                  title: "History",
                ),
                ...historyMenus.map(
                  (menu) => SideMenuTile(
                    isActive: selectedMenuItem == menu,
                    menu: menu,
                    press: () {
                      menu.input!.change(true);
                      setState(() {
                        selectedMenuItem = menu;
                      });
                      Future.delayed(
                        Duration(milliseconds: 100),
                        () {
                          menu.input!.change(false);
                        },
                      );
                    },
                    riveInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: menu.stateMachineName,
                      );
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.menu,
    required this.press,
    required this.riveInit,
    required this.isActive,
  });

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              height: 56,
              width: isActive ? 275 : 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: highligherColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveInit,
                ),
              ),
              title: Text(
                menu.title,
                style: sideMenuTileStyle,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SideMenuCategory extends StatelessWidget {
  const SideMenuCategory({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 25,
        bottom: 15,
        top: 15,
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white70,
            ),
      ),
    );
  }
}

List<RiveAsset> browseMenu = [
  RiveAsset(
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Favourites",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Help",
    src: "assets/riveAssets/icons.riv",
  ),
  // RiveAsset(
  //   artboard: "HOME",
  //   stateMachineName: "HOME_Interactivity",
  //   title: "Home",
  //   src: "assets/riveAssets/icons.riv",
  // )
];

List<RiveAsset> historyMenus = [
  RiveAsset(
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "History",
    src: "assets/riveAssets/icons.riv",
  ),
  RiveAsset(
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notifications",
    src: "assets/riveAssets/icons.riv",
  ),
];
