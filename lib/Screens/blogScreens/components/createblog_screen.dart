// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/constants.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Create Blog",
        backgroundColor: kPrimaryColor,
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedInputField(
                fieldName: "Title",
                iconData: Icons.percent,
                scale: 0.95,
                extensible: true,
              ),
              RoundedInputField(
                fieldName: "Body",
                iconData: Icons.percent,
                scale: 0.95,
                extensible: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
