// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/components/grids.dart';
import 'package:sessions/screens/profile/components/profile_details.dart';
import 'package:sessions/screens/profile/components/utils.dart';

class MyBottomSheet extends StatefulWidget {
  final double minHeight;

  const MyBottomSheet({super.key, required this.minHeight});
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late double _currentHeight;
  DraggableScrollableController controller = DraggableScrollableController();
  double maxHeight = 700;
  @override
  void initState() {
    _currentHeight = widget.minHeight - 65;
    controller.addListener(() {
      setState(() {
        _currentHeight = controller.pixels;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    maxHeight = size.height;
    return DraggableScrollableSheet(
      controller: controller,
      //snap: true,
      minChildSize: widget.minHeight / MediaQuery.of(context).size.height,
      maxChildSize: maxHeight / MediaQuery.of(context).size.height,
      initialChildSize: widget.minHeight / MediaQuery.of(context).size.height,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0.0, -2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlurDivider(size: size),
                    Container(
                      height: _currentHeight - 10,
                      child: AnimatedTabBar(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedTabBar extends StatefulWidget {
  const AnimatedTabBar({Key? key}) : super(key: key);

  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 50,
            //color: kPrimaryLightColor,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Icon(
                  Icons.person_2_outlined,
                  size: 32.5,
                ),
                Icon(
                  Icons.grid_view_rounded,
                  size: 32.5,
                ),
                Icon(
                  Icons.people_alt_outlined,
                  size: 32.5,
                ),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 16.0),
              labelColor: kPrimaryColor,
              unselectedLabelColor: backgroundColor2.withOpacity(0.6),
              indicator: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryLightColor,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProfileDetails(),
                GridBlogs(),
                Center(child: Text('Tab 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
