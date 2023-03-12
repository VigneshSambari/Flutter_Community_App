import 'package:flutter/material.dart';

void navigatorPush(Widget widget, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigatorPop(BuildContext context) {
  Navigator.pop(context);
}
