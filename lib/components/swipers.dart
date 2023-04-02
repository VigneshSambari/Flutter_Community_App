// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class DragDownSheet extends StatefulWidget {
  @override
  _DragDownSheetState createState() => _DragDownSheetState();
}

class _DragDownSheetState extends State<DragDownSheet> {
  double _minHeight = 10;
  double _maxHeight = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    setState(() {
      _maxHeight = MediaQuery.of(context).size.height * 0.7;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _minHeight,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onVerticalDragStart: (_) {
          _isDragging = true;
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (!_isDragging) return;
          double newHeight = _minHeight + details.delta.dy;
          if (newHeight > _maxHeight) {
            newHeight = _maxHeight;
          } else if (newHeight < 10) {
            newHeight = 10;
          }
          setState(() {
            _minHeight = newHeight;
          });
        },
        onVerticalDragEnd: (_) {
          _isDragging = false;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(""),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
