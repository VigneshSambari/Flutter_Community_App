// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/circle_avatars.dart';
import 'package:sessions/components/swipers.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';

import 'package:sessions/screens/chatScreens/components/clips.dart';
import 'package:sessions/screens/chatScreens/components/status.dart';

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

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            ListTile(
              tileColor: kPrimaryColor,
              title: Text(
                "Room Name",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Room description...",
                style: TextStyle(
                  color: kPrimaryLightColor,
                ),
              ),
              leading: Wrap(
                children: [
                  BackButtonNav(),
                  CircleNetworkPicture(),
                ],
              ),
              trailing: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ),
            Container(
              width: size.width,
              child: Stack(
                children: [
                  SwipeDownRow(events: events),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SwipeDownSheet extends StatefulWidget {
//   final Widget child;
//   final double height;

//   SwipeDownSheet({required this.child, required this.height});

//   @override
//   _SwipeDownSheetState createState() => _SwipeDownSheetState();
// }

// class _SwipeDownSheetState extends State<SwipeDownSheet> {
//   bool _isOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         GestureDetector(
//           onVerticalDragUpdate: (details) {
//             if (!_isOpen && details.primaryDelta! > 0) {
//               setState(() {
//                 _isOpen = true;
//               });
//             }
//           },
//           onVerticalDragEnd: (details) {
//             if (_isOpen && details.primaryVelocity! < 0) {
//               setState(() {
//                 _isOpen = false;
//               });
//             }
//           },
//           child: Container(
//             height: 5,
//             width: _isOpen ? 0 : size.width / 2,
//             color: Colors.black,
//           ),
//         ),
//         AnimatedContainer(
//           height: _isOpen ? widget.height : 0,
//           width: size.width / 1.5,
//           duration: const Duration(milliseconds: 300),
//           child: Stack(
//             children: [
//               widget.child,
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.arrow_drop_up_rounded,
//                     color: kPrimaryColor,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isOpen = false;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
