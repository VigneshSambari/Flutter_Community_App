// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/classes.dart';

class PopUpMenuWidget extends StatefulWidget {
  final List<PairPopMenu> options;
  final Function({required int value}) onSelect;
  PopUpMenuWidget({
    Key? key,
    required this.options,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<PopUpMenuWidget> createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (int result) {
        setState(() {
          widget.onSelect(value: result);
        });
      },
      itemBuilder: (BuildContext context) => widget.options
          .map(
            (e) => PopupMenuItem(
              value: e.value,
              child: Text(
                e.option,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
      child: Row(
        children: [
          Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
