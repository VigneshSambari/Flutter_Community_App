// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> options;
  final String fieldName;
  final IconData prefixIcon;

  CustomDropdownButton({
    required this.options,
    required this.fieldName,
    required this.prefixIcon,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String selectedOption = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.8,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Icon(
                            widget.prefixIcon,
                            color: kPrimaryColor,
                          ),
                        ),
                        Text(
                          selectedOption == ""
                              ? widget.fieldName
                              : selectedOption,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedOption == ""
                                ? Colors.grey[700]
                                : Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  splashRadius: 1,
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _showDropdownMenu(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.options.map((String option) {
                  return ListTile(
                    title: Text(
                      option,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, option);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    ).then((String? newValue) {
      if (newValue != null) {
        setState(() {
          selectedOption = newValue;
        });
      }
    });
  }
}
