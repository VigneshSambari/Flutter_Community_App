// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CurvedAppBar(
          title: "Blogs",
          backgroundColor: backgroundColor2.withOpacity(0.1),
          actions: [],
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: size.width,
            height: size.height,
            padding: EdgeInsets.all(2),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widgets.length,
              itemBuilder: (BuildContext context, int index) {
                return BlogTile();
              },
            ),
          ),
        ),
      ],
    );
  }
}
