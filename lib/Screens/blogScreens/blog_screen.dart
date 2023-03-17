// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/navbar.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/blogScreens/components/blog_utils.dart';

List<Widget> widgets = [
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile(),
  BlogTile()
];

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      //resizeToAvoidBottomInset: false,
      appBar: CurvedAppBar(
        title: "Blogs",
        backgroundColor: kPrimaryColor,
        actions: [],
      ),
      body: Container(
        width: size.width,
        padding: EdgeInsets.all(2),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return RoundedInputField(
                fieldName: "Search",
                iconData: Icons.search,
                scale: 0.85,
              );
            }
            return BlogTile();
          },
        ),
      ),
      bottomNavigationBar: NavBarAnimated(),
    );
  }
}
