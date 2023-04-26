// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/screens/chatScreens/components/clips.dart';

List<EventClip> events = [
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
  EventClip(),
];

class BlogTile extends StatefulWidget {
  final BlogPostModel blog;
  const BlogTile({
    super.key,
    required this.blog,
  });

  @override
  State<BlogTile> createState() => _BlogTileState();
}

int mediaIndex = 0;

class _BlogTileState extends State<BlogTile> {
  void pageChange({required int value}) {
    mediaIndex = value;

    setState(() {
      mediaIndex;
    });
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Stack(
                        children: [
                          CarouselSlider(
                            height: size.height * 0.25,
                            items: events,
                            margin: 0,
                            scroll: false,
                            pageChange: pageChange,
                          ),
                          Positioned(
                            bottom: 3,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: Wrap(
                                children: List.generate(
                                  events.length,
                                  (index) => Container(
                                    width: 7,
                                    height: 7,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      color: mediaIndex == index
                                          ? Colors.white
                                          : Colors.white70,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "+${widget.blog.coverMedia!.length - 1}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Wrap(
                  children: [
                    Text(
                      "${widget.blog.postedBy!}  jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj",
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    )
                  ],
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
                        ClipRRect(
                          child: CircleAvatar(
                            backgroundColor: kPrimaryLightColor,
                            radius: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CircleImageTile(
                                  groupOrPerson: false, url: ""),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.blog.title!,
                              style: blogTitleStyle,
                            ),
                            Text(
                              widget.blog.postedBy!,
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
        borderRadius: BorderRadius.circular(10),
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
