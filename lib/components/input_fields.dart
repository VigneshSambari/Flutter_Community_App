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
    this.controller,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String fieldName;
  final Color iconColor;
  final double height;
  final IconData iconData;
  final bool extensible, enabled;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      widget: TextField(
        maxLength: maxLength,
        enabled: enabled,
        controller: controller,
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
        vertical: 5,
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
    this.controller,
    this.icon,
    this.extensible = false,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String fieldName;
  final bool enabled;
  final double height;
  final IconData? icon;
  final bool extensible;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return RoundedInputField(
      fieldName: fieldName,
      iconData: icon != null ? icon! : Icons.abc,
      height: height,
      extensible: extensible,
      enabled: enabled,
      controller: controller,
      maxLength: maxLength,
    );
  }
}

class SearchBar extends StatelessWidget {
  final VoidCallback fetch;
  const SearchBar({super.key, required this.controller, required this.fetch});

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
                onChanged: (String value) {
                  fetch();
                },
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
              onTap: () {
                fetch();
              },
              child: Icon(
                Icons.search_rounded,
                color: kPrimaryColor,
              ),
            )
          ],
        ));
  }
}

class EntryField extends StatelessWidget {
  final String? title, hintText;
  final int? maxLines, maxLength;
  final TextInputType inputType;
  final Widget suffix;
  final bool enabled;
  final TextEditingController? controller;
  EntryField({
    super.key,
    this.title,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.inputType = TextInputType.text,
    this.suffix = const SizedBox(),
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryDarkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BlueOutlinedInputField(
            hintText: hintText,
            maxLength: maxLength,
            maxLines: maxLines,
            inputType: inputType,
            suffix: suffix,
            controller: controller,
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}

class BlueOutlinedInputField extends StatelessWidget {
  final String? hintText;
  final TextInputType inputType;
  final int? maxLines, maxLength;
  final Widget suffix;
  final TextEditingController? controller;
  final bool enabled;
  const BlueOutlinedInputField({
    super.key,
    this.hintText,
    this.maxLength,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.suffix = const SizedBox(),
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          enabled: enabled,
          controller: controller,
          keyboardType: inputType,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: 1,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: suffix,
        )
      ],
    );
  }
}
