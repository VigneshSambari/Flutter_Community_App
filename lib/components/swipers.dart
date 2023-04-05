// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/chatScreens/components/status.dart';

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
                child: Center(
                  child: Text(""),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwipeDownRow extends StatefulWidget {
  const SwipeDownRow({
    super.key,
    required this.events,
  });
  final List<Widget> events;
  @override
  State<SwipeDownRow> createState() => _SwipeDownRowState();
}

class _SwipeDownRowState extends State<SwipeDownRow> {
  bool _isOpen1 = false;
  bool _isOpen2 = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.75,
      width: size.width,
      child: Stack(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _isOpen1 = true;
                  setState(() {
                    _isOpen1;
                  });
                },
                onVerticalDragUpdate: (details) {
                  if (!_isOpen1 && details.primaryDelta! > 0) {
                    setState(() {
                      _isOpen1 = true;
                    });
                  }
                },
                onVerticalDragEnd: (details) {
                  if (_isOpen1 && details.primaryVelocity! < 0) {
                    setState(() {
                      _isOpen1 = false;
                    });
                  }
                },
                child: Container(
                  height: 5,
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: purpleGreen,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: size.width / 2 - 2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOpen2 = true;
                  });
                },
                onVerticalDragUpdate: (details) {
                  if (!_isOpen2 && details.primaryDelta! > 0) {
                    setState(() {
                      _isOpen2 = true;
                    });
                  }
                },
                onVerticalDragEnd: (details) {
                  if (_isOpen2 && details.primaryVelocity! < 0) {
                    setState(() {
                      _isOpen2 = false;
                    });
                  }
                },
                child: Container(
                  height: 5,
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(1),
                  width: size.width / 2 - 2,
                  decoration: BoxDecoration(
                    color: purpleRed,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isOpen1 ? size.height * 0.34 : 0,
            width: size.width,
            decoration: BoxDecoration(
              color: purpleGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CarouselSlider(
                      height: size.height * 0.25, items: widget.events),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    icon: CircleAvatar(
                      backgroundColor: Colors.green.withOpacity(0.5),
                      child: Icon(
                        Icons.arrow_drop_up_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isOpen1 = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            duration: Duration(milliseconds: 300),
            height: _isOpen2 ? size.height * 0.28 : 0,
            width: size.width,
            decoration: BoxDecoration(
              color: purpleRed,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: StatusSlider(),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    icon: CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.5),
                      child: Icon(
                        Icons.arrow_drop_up_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isOpen2 = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SwipeDownSheet extends StatefulWidget {
  final Widget child;
  final double height;

  SwipeDownSheet({required this.child, required this.height});

  @override
  _SwipeDownSheetState createState() => _SwipeDownSheetState();
}

class _SwipeDownSheetState extends State<SwipeDownSheet> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onVerticalDragUpdate: (details) {
            if (!_isOpen && details.primaryDelta! > 0) {
              setState(() {
                _isOpen = true;
              });
            }
          },
          onVerticalDragEnd: (details) {
            if (_isOpen && details.primaryVelocity! < 0) {
              setState(() {
                _isOpen = false;
              });
            }
          },
          child: Container(
            height: 5,
            width: _isOpen ? 0 : size.width / 2,
            color: Colors.black,
          ),
        ),
        AnimatedContainer(
          height: _isOpen ? widget.height : 0,
          width: size.width / 1.5,
          duration: const Duration(milliseconds: 300),
          child: Stack(
            children: [
              widget.child,
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_drop_up_rounded,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isOpen = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
