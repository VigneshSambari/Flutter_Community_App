// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/constants.dart';

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
      child: Container(
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
                  //Center(child: Text('Tab 1')),

                  Center(child: Text('Tab 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [Container()],
            )
          ],
        ),
      ),
    );
  }
}

// class GridBlogs extends StatelessWidget {
//   GridBlogs({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 7,
//       ),
//       child: GridView.builder(
//         itemCount: 50,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20.0),
//                 bottomLeft: Radius.circular(20.0),
//               ),
//               child: SvgPicture.asset("assets/icons/login.svg"));
//         },
//       ),
//     );
//   }
// }

class GridBlogs extends StatelessWidget {
  GridBlogs({Key? key}) : super(key: key);

  final List<String> images = [
    "https://images.pexels.com/photos/14411099/pexels-photo-14411099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7175450/pexels-photo-7175450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15316227/pexels-photo-15316227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/14411099/pexels-photo-14411099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7175450/pexels-photo-7175450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15316227/pexels-photo-15316227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/14411099/pexels-photo-14411099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7175450/pexels-photo-7175450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15316227/pexels-photo-15316227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/14411099/pexels-photo-14411099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7175450/pexels-photo-7175450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15316227/pexels-photo-15316227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/14411099/pexels-photo-14411099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7175450/pexels-photo-7175450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15316227/pexels-photo-15316227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/14411099/pexels-photo-14411099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7175450/pexels-photo-7175450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15316227/pexels-photo-15316227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ];

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3;
    Size size = MediaQuery.of(context).size;
    // Calculate the width of each grid cell dynamically based on the number of images that can fit in a row.
    double gridCellWidth =
        (MediaQuery.of(context).size.width - ((crossAxisCount - 1) * 10)) /
            crossAxisCount;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            child: Image.network(
              images[index],
              fit: BoxFit
                  .cover, // Set the fit property of the image to cover the entire cell
            ),
          );
        },
      ),
    );
  }
}

class BlurDivider extends StatelessWidget {
  const BlurDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 3.5,
      width: size.width * 0.18,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: kPrimaryColor.withOpacity(0.6),
          )
        ],
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
