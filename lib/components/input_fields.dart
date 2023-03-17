// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../constants.dart';

class OutlinedInputField extends StatefulWidget {
  OutlinedInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.password = false,
  });

  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final bool password;

  @override
  State<OutlinedInputField> createState() => _OutlinedInputFieldState();
}

class _OutlinedInputFieldState extends State<OutlinedInputField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width * 0.84,
      child: TextFormField(
        onTapOutside: (value) {
          setState(() {
            passwordVisible = false;
          });
        },
        obscureText: widget.password ? !passwordVisible : false,
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: EdgeInsets.only(left: 10),
            child: widget.prefixIcon,
          ),
          suffixIcon: widget.password
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    !passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                )
              : null,
          fillColor: kPrimaryLightColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryLightColor),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryLightColor),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    super.key,
    required this.fieldName,
    this.iconColor = kPrimaryColor,
    required this.iconData,
    this.scale = 0.85,
    this.extensible = false,
  });

  final String fieldName;
  final Color iconColor;
  final double scale;
  final IconData iconData;
  final bool extensible;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      widget: TextField(
        maxLines: extensible ? 10 : 1,
        minLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: fieldName,
          icon: Icon(
            iconData,
            color: iconColor,
          ),
        ),
      ),
      scale: scale,
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.widget,
    required this.scale,
  });

  final Widget widget;
  final double scale;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * scale,
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: widget,
    );
  }
}
