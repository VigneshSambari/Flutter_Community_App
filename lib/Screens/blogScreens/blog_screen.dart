// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
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
      appBar: CurvedAppBar(
        title: "Blogs",
        actions: [],
        leading: SizedBox(),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
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
                itemCount: widgets.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index != widgets.length) {
                    return BlogTile();
                  } else {
                    return SizedBox(
                      height: 100,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
