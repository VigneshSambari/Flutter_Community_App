// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

class EventOverlayTile extends StatelessWidget {
  const EventOverlayTile({
    super.key,
    required this.parentWidth,
  });

  final double parentWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: parentWidth,
      ),
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          width: parentWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor2.withOpacity(0.7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "Description...",
                textAlign: TextAlign.left,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )),
    );
  }
}

class EventPostedByTile extends StatelessWidget {
  const EventPostedByTile({
    super.key,
    required this.parentWidth,
  });

  final double parentWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: parentWidth,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: backgroundColor2.withOpacity(0.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event by:",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "VickySam1901",
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    child: Image.asset(
                      "assets/profileicons/name.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatsTile extends StatelessWidget {
  const ChatsTile({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 1.5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: kPrimaryColor.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(5),
        color: kPrimaryColor.withOpacity(0.5),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kPrimaryLightColor,
          radius: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              "assets/global/group.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          "Room Name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "Room Description...",
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: true,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "02/2/22",
              style: TextStyle(color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "22",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
