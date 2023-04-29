// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double margin;
  final bool scroll;
  final double widthRatio;
  final Function({required int value})? pageChange;

  CarouselSlider({
    required this.items,
    required this.height,
    this.margin = 10,
    this.scroll = true,
    this.pageChange,
    this.widthRatio = .95,
  });

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.scroll) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      if (_currentPage < widget.items.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(widget.margin),
      height: widget.height,
      width: size.width * widget.widthRatio,
      child: Center(
        child: GestureDetector(
          onLongPressDown: (details) {
            _timer?.isActive != false;
          },
          onLongPressEnd: (details) => {
            _timer?.isActive != true,
          },
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                if (widget.pageChange != null) {
                  widget.pageChange!(value: index);
                }
              });
            },
            children: widget.items,
          ),
        ),
      ),
    );
  }
}
