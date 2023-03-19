// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/constants.dart';

class BlogTile extends StatelessWidget {
  const BlogTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3.5),
      margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Text("+5"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: const Text(
                  "Username: frwkjefisfo;grsgdgrrzdgzdfvvdjaskzdkjsndkjsjdvvvvvrffzdgzdgz;soef",
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            // height: 50,
            child: GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "title",
                              style: blogTitleStyle,
                            ),
                            Text(
                              "subtitle",
                              style: blogSubtitleStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedFileTile extends StatelessWidget {
  const SelectedFileTile({
    Key? key,
    required this.index,
    required this.removeTile,
    required this.title,
  }) : super(key: key);

  final Function removeTile;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: kPrimaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              removeTile(index);
            },
            child: Icon(
              Icons.close,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}

class TypeSpecifiers extends StatelessWidget {
  const TypeSpecifiers({
    super.key,
    required this.background,
    required this.textColor,
    required this.title,
  });

  final Color background, textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }
}
