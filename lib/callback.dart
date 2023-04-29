import 'package:flutter/material.dart';

class CallBack extends StatefulWidget {
  const CallBack({super.key, required this.input});
  final String input;

  @override
  State<CallBack> createState() => _CallBackState();
}

class _CallBackState extends State<CallBack> {
  bool muted = false;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
