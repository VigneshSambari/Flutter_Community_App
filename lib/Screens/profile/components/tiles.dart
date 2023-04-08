// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/profile/create_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkTile extends StatelessWidget {
  final TextEditingController nameCont, linkCont;
  final List<LinkTile> linkList;
  int? index;
  final VoidCallback stateUpdate;
  LinkTile({
    super.key,
    required this.linkList,
    required this.stateUpdate,
    required this.nameCont,
    required this.linkCont,
  });

  void setIndex(int newIndex) {
    print(newIndex);
    print("built");
    index = newIndex;
  }

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
              controller: nameCont,
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: SizedInputField(
              controller: linkCont,
              fieldName: "Link...",
            ),
          ),
          GestureDetector(
            onTap: () {
              linkList.removeAt(index!);
              print(index);
              print("deleted");
              stateUpdate();
            },
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.75),
              child: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.9),
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

class LinkClip extends StatelessWidget {
  const LinkClip({super.key, required this.title, required this.url});
  final String title, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launchUrl(Uri.parse(url))) {}
      },
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: getRandomColorFromList(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.open_in_new_outlined,
                color: Colors.white,
                size: 22,
              )
            ],
          )),
    );
  }
}

class AddLinksBox extends StatefulWidget {
  const AddLinksBox({
    super.key,
    required this.linkTiles,
  });

  final List<LinkTile> linkTiles;

  @override
  State<AddLinksBox> createState() => _AddLinksBoxState();
}

class _AddLinksBoxState extends State<AddLinksBox> {
  void stateUpdate() {
    setState(() {
      linkTiles;
    });
  }

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
                  onTap: () {
                    TextEditingController nameCont = TextEditingController(),
                        linkCont = TextEditingController();
                    widget.linkTiles.add(LinkTile(
                      linkCont: linkCont,
                      nameCont: nameCont,
                      linkList: linkTiles,
                      stateUpdate: stateUpdate,
                    ));
                    stateUpdate();
                  },
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
              itemCount: widget.linkTiles.length,
              itemBuilder: (context, index) {
                widget.linkTiles[index].setIndex(index);
                return widget.linkTiles[index];
              },
            ),
          )
        ],
      ),
    );
  }
}

class InterestsTile extends StatefulWidget {
  const InterestsTile({
    super.key,
    required this.size,
    required this.controller,
    required this.interestsList,
  });
  final Set<String> interestsList;
  final Size size;
  final TextEditingController controller;

  @override
  State<InterestsTile> createState() => _InterestsTileState();
}

class _InterestsTileState extends State<InterestsTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: widget.size.width * 0.6,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: widget.size.width * 0.45,
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundedInputField(
                          fieldName: "Interest",
                          iconData: Icons.abc,
                          height: 50,
                          controller: widget.controller,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.interestsList.add(widget.controller.text);
                    widget.controller.clear();
                    setState(() {
                      interestList;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CircleAvatar(
                      radius: widget.size.width * 0.04,
                      backgroundColor: kPrimaryColor.withOpacity(0.85),
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ...widget.interestsList.map((e) => InterestClip(title: e)).toList(),
        ],
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconUrl,
    this.trailing = const SizedBox(),
  });

  final String title, iconUrl;
  final Widget subTitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        trailing: trailing,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25,
          child: Image.asset(iconUrl),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: subTitle,
      ),
    );
  }
}

class ConnectionRoomTile extends StatelessWidget {
  const ConnectionRoomTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconUrl,
    this.trailing = const SizedBox(),
  });

  final String title, iconUrl;
  final String subTitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        trailing: trailing,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              iconUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subTitle,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class RowTextTile extends StatelessWidget {
  const RowTextTile({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
  });

  final String leftTitle, rightTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Wrap(
        children: [
          TextTile(title: leftTitle),
          SizedBox(width: 10),
          Text(
            ":",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          TextTile(
            title: rightTitle,
            backgroundColor: kPrimaryLightColor,
            textColor: kPrimaryDarkColor,
            fontWeight: FontWeight.w100,
          )
        ],
      ),
    );
  }
}

class TextTile extends StatelessWidget {
  const TextTile({
    super.key,
    required this.title,
    this.backgroundColor = kPrimaryLightColor,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.bold,
  });

  final String title;
  final Color backgroundColor, textColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
