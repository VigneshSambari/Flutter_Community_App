// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:sessions/components/appbar.dart';
import 'package:sessions/constants.dart';

class PreviewBlog extends StatelessWidget {
  const PreviewBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
          title: "Preview",
          backgroundColor: kPrimaryColor,
          actions: [
            Icon(
              Icons.edit,
              color: Colors.grey,
            )
          ]),
    );
  }
}
