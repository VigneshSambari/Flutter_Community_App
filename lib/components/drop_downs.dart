// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, library_private_types_in_public_api, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/enums.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> options;
  final String fieldName;
  final IconData? prefixIcon;
  final Function changeValue;
  final DropTypes dropType;
  final bool sharpCorner;
  CustomDropdownButton({
    required this.options,
    required this.fieldName,
    required this.prefixIcon,
    required this.changeValue,
    required this.dropType,
    this.sharpCorner = false,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String selectedOption = "";

  @override
  Widget build(BuildContext context) {
    Widget dropDownWid = DropDownChild(
      fieldName: widget.fieldName,
      prefixIcon: widget.prefixIcon!,
      selectedOption: selectedOption,
      showDropdownMenu: _showDropdownMenu,
      sharpCorner: widget.sharpCorner,
    );
    final size = MediaQuery.of(context).size;
    return widget.sharpCorner
        ? Container(
            // margin: EdgeInsets.all(5),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: dropDownWid,
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: size.width,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: dropDownWid,
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
      widget.changeValue(value: newValue, dropType: widget.dropType);
      if (newValue != null) {
        setState(() {
          selectedOption = newValue;
        });
      }
    });
  }
}

class DropDownChild extends StatelessWidget {
  final Function showDropdownMenu;
  final String fieldName;
  final IconData prefixIcon;
  final String selectedOption;
  final bool sharpCorner;
  const DropDownChild({
    super.key,
    required this.showDropdownMenu,
    required this.fieldName,
    required this.prefixIcon,
    required this.selectedOption,
    this.sharpCorner = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(
      builder: (context) {
        return SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  sharpCorner
                      ? SizedBox(
                          width: 10,
                        )
                      : Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Icon(
                            prefixIcon,
                            color: kPrimaryColor,
                          ),
                        ),
                  Text(
                    selectedOption == "" ? fieldName : selectedOption,
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedOption == ""
                          ? Colors.grey[700]
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              IconButton(
                splashRadius: 1,
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  showDropdownMenu(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    Key? key,
    required this.constraints,
    required this.child,
    required this.rightPosition,
  }) : super(key: key);
  final BoxConstraints constraints;
  final Widget child;
  final double rightPosition;
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isSheetOpen = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _offsetAnimation = Tween<Offset>(begin: Offset(0.0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: screenHeight * 0.65,
          child: SlideTransition(
            position: _offsetAnimation,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: kPrimaryLightColor,
                  ),
                  child: Center(
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: _isSheetOpen
              ? screenHeight * 0.65
              : widget.constraints.maxHeight - 45,
          right: widget.rightPosition,
          child: SlideTransition(
            position: _offsetAnimation,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSheetOpen = !_isSheetOpen;
                  if (_isSheetOpen) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
