// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget> actions;

  const CurvedAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          bottomStart: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: actions,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
