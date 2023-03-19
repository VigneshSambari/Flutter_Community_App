// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';

import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/screens/blogScreens/components/blog_utils.dart';

import 'package:sessions/utils/file_picker.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final List<File> selectedFiles = [];

  void removeSelected(index) {
    selectedFiles.removeAt(index);
    setState(() {
      selectedFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Create Blog",
        backgroundColor: kPrimaryColor,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedInputField(
                fieldName: "Title",
                iconData: Icons.title,
                scale: 0.95,
                extensible: false,
              ),
              RoundedInputField(
                fieldName: "Body",
                iconData: Icons.text_snippet,
                scale: 0.95,
                extensible: true,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: selectedFiles.isEmpty
                      ? size.height * 0.3
                      : size.height * 0.5,
                  width: size.width * 0.9,
                  decoration: boxDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Upload images/videos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Please choose only:",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          ...typeAllowed.map((type) => type),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          selectedFiles.addAll(await pickFilesBlog());
                          setState(() {
                            selectedFiles;
                          });
                        },
                        child: Container(
                          width: size.width * 0.7,
                          height: 110,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: lightColor,
                          ),
                          child: DottedBorder(
                            color: kPrimaryColor,
                            borderType: BorderType.Rect,
                            strokeWidth: 1.5,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: 10,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_copy,
                                    size: 40,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Choose files here...",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor.withOpacity(0.9),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "(Max file size: 10MB)",
                                    style: TextStyle(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width * 0.69,
                        height: selectedFiles.isEmpty ? 0 : size.height * 0.26,
                        decoration: BoxDecoration(
                          //color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 1.5,
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedFiles.length,
                          itemBuilder: (context, index) {
                            return SelectedFileTile(
                              removeTile: removeSelected,
                              index: index,
                              title: selectedFiles[index].path.split('/').last,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RoundedButton(
                title: "Preview",
                onPress: () {},
                color: lightColor,
                textColor: Colors.black,
              ),
              RoundedButton(
                title: "Create",
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<TypeSpecifiers> typeAllowed = [
  TypeSpecifiers(
    background: Colors.green.shade100,
    textColor: Colors.green,
    title: ".JPG",
  ),
  TypeSpecifiers(
    background: Colors.blue.shade100,
    textColor: Colors.blue,
    title: ".PNG",
  ),
  TypeSpecifiers(
    background: Colors.pink.shade100,
    textColor: Colors.pink,
    title: ".MP4",
  ),
  TypeSpecifiers(
    background: Colors.orange.shade100,
    textColor: Colors.orange,
    title: ".GIF",
  )
];

BoxDecoration boxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(40),
  color: kPrimaryLightColor,
);
