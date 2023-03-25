// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';

class LinkTile extends StatelessWidget {
  const LinkTile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.26,
            child: SizedInputField(
              fieldName: "Site...",
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: SizedInputField(
              fieldName: "Link...",
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.check,
                color: Colors.green,
                weight: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InterestClip extends StatelessWidget {
  const InterestClip({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: getRandomColorFromList(),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AddLinksBox extends StatelessWidget {
  const AddLinksBox({
    super.key,
    required this.linkTiles,
  });

  final List<LinkTile> linkTiles;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add links to enhance your profile",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "For example: Github, Linkedin, Leetcode...",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 250,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: linkTiles.length,
              itemBuilder: (context, index) {
                return linkTiles[index];
              },
            ),
          )
        ],
      ),
    );
  }
}

class InterestsTile extends StatelessWidget {
  const InterestsTile({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Row(
              children: [
                Expanded(
                  child: RoundedInputField(
                    fieldName: "Interest",
                    iconData: Icons.abc,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
          InterestClip(title: "Sports"),
          InterestClip(title: "Coding"),
          InterestClip(title: "Placement"),
          InterestClip(title: "Sports"),
          InterestClip(title: "Coding"),
          InterestClip(title: "Placement"),
        ],
      ),
    );
  }
}
