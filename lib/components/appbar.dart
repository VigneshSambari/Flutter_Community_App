import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

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
      margin: const EdgeInsets.only(
        bottom: 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          bottomStart: Radius.circular(10),
        ),
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.0,
          ),
        ],
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
