// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import '../constants.dart';

class OutlinedInputField extends StatefulWidget {
  OutlinedInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.password = false,
    this.enabled = true,
    this.controller,
    this.error,
  });

  String? error;
  TextEditingController? controller;
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final bool password, enabled;

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
        controller: widget.controller,
        onTapOutside: (value) {
          setState(() {
            passwordVisible = false;
          });
        },
        obscureText: widget.password ? !passwordVisible : false,
        decoration: InputDecoration(
          prefixIcon: Container(
            // padding: EdgeInsets.only(
            //   left: widget.prefixIcon.icon == null ? 0 : 10,
            // ),
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
          errorText: widget.error,
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
    this.extensible = false,
    this.height = 0,
    this.enabled = true,
  });

  final String fieldName;
  final Color iconColor;
  final double height;
  final IconData iconData;
  final bool extensible, enabled;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      widget: TextField(
        enabled: enabled,
        maxLines: extensible ? 10 : 2,
        minLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: fieldName,
          icon: iconData == Icons.abc
              ? null
              : Icon(
                  iconData,
                  color: iconColor,
                ),
        ),
      ),
      height: height,
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.widget,
    this.height = 0,
  });

  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //height: height == 0 ? null : height,
      width: size.width,
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

class SizedInputField extends StatelessWidget {
  const SizedInputField({
    super.key,
    this.enabled = true,
    required this.fieldName,
    this.height = 60,
  });

  final String fieldName;
  final bool enabled;
  final double height;
  @override
  Widget build(BuildContext context) {
    return RoundedInputField(
      fieldName: fieldName,
      iconData: Icons.abc,
      height: height,
      extensible: false,
      enabled: enabled,
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search_rounded,
                color: kPrimaryColor,
              ),
            )
          ],
        ));
  }
}
