// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

void showMySnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: kPrimaryColor.withOpacity(0.8),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    ),
  );
}


// void showMySnackBar(BuildContext context, String message,TickerProvider tickerProvider) {
  
//   final snackBar = SnackBar(
//     content: Text(message),
//     duration: Duration(seconds: 2),
//     behavior: SnackBarBehavior.floating,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(16),
//     ),
//     elevation: 10,
//     margin: EdgeInsets.all(16),
//   );

//   final animationController = AnimationController(
//     vsync: tickerProvider,
//     duration: Duration(milliseconds: 500),
//   );
//   animationController.forward();

//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     pageBuilder: (BuildContext buildContext, Animation<double> animation,
//         Animation<double> secondaryAnimation) {
//       return WillPopScope(
//         onWillPop: () async {
//           if (animationController.isAnimating) {
//             return false;
//           }
//           await animationController.reverse();
//           return true;
//         },
//         child: SafeArea(
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: AnimatedSize(
//               duration: Duration(milliseconds: 500),
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                   begin: Offset(0, 1),
//                   end: Offset(0, 0),
//                 ).animate(CurvedAnimation(
//                   parent: animationController,
//                   curve: Curves.easeOut,
//                   reverseCurve: Curves.easeIn,
//                 )),
//                 child: snackBar,
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   ).whenComplete(() {
//     animationController.dispose();
//   });
// }
