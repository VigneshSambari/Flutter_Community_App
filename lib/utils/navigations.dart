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

void navigatorPopAllExceptFirst(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

void navigatorPushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigatorRemoveAllExceptFirstAndPush(
    BuildContext context, Widget newWidget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => newWidget),
    (route) => route.isFirst,
  );
}
