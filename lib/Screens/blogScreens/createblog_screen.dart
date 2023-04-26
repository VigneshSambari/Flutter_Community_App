// ignore_for_file: public_member_api_docs, sort_constructors_first, sized_box_for_whitespace, curly_braces_in_flow_control_structures, use_build_context_synchronously
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sessions/bloc/blog/blog_bloc.dart';
import 'package:sessions/bloc/user/user_bloc.dart';

import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/repositories/blog_repository.dart';
import 'package:sessions/screens/blogScreens/components/blog_utils.dart';
import 'package:sessions/utils/classes.dart';

import 'package:sessions/utils/file_picker.dart';
import 'package:sessions/utils/navigations.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  final List<File> selectedFiles = [];
  bool _isLoading = false, _isDisposed = false;
  final BlogPostRepository _blogPostRepository = BlogPostRepository();

  void removeSelected(index) {
    selectedFiles.removeAt(index);
    setState(() {
      selectedFiles;
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => BlogPostRepository(),
      child: BlocProvider(
        create: (context) => BlogBloc(
          RepositoryProvider.of<BlogPostRepository>(context),
        ),
        child: Scaffold(
          appBar: CurvedAppBar(
            leading: BackButtonNav(),
            title: "Create Blog",
            backgroundColor: kPrimaryColor,
            actions: [],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedInputField(
                        fieldName: "Title",
                        controller: titleController,
                        iconData: (Icons.title),
                        extensible: false,
                      ),
                      RoundedInputField(
                        fieldName: "Body",
                        controller: bodyController,
                        iconData: Icons.text_snippet,
                        extensible: true,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: selectedFiles.isEmpty
                              ? size.height * 0.3
                              : size.height * 0.50,
                          width: size.width * 0.9,
                          decoration: boxDecoration,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload images/videos",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Please choose only:",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ),
                                      ...typeAllowed.map((type) => type),
                                    ],
                                  ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                color: kPrimaryColor
                                                    .withOpacity(0.9),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "(Max file size: 10MB)",
                                              style: TextStyle(
                                                color: kPrimaryColor
                                                    .withOpacity(0.5),
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
                                  height: selectedFiles.isEmpty
                                      ? 0
                                      : size.height * 0.2,
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
                                        title: selectedFiles[index]
                                            .path
                                            .split('/')
                                            .last,
                                      );
                                    },
                                  ),
                                ),
                                // Container(
                                //   width: size.width * 0.5,
                                //   child: selectedFiles.isEmpty
                                //       ? null
                                //       : RoundedButton(title: "Upload", onPress: () {}),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      RoundedButton(
                        title: "Preview",
                        onPress: () {},
                        color: lightColor,
                        textColor: Colors.black,
                      ),
                      Builder(
                        builder: (context) {
                          return RoundedButton(
                            title: "Create",
                            onPress: () async {
                              String userIdUser;
                              final userState =
                                  BlocProvider.of<UserBloc>(context).state;
                              if (userState is UserSignedInState) {
                                userIdUser = userState.user.userId!;
                              } else {
                                return;
                              }
                              if (titleController.text.isEmpty ||
                                  titleController.text.isEmpty) {
                                showMySnackBar(
                                    context, "Title cannot be empty!");
                                return;
                              }
                              if (bodyController.text.isEmpty) {
                                showMySnackBar(
                                    context, "Body cannot be empty!");
                                return;
                              }
                              List<String> mediaPaths = [];
                              for (File file in selectedFiles) {
                                //print(file.path);
                                mediaPaths.add(file.path);
                              }
                              CreateBlogSend blogData = CreateBlogSend(
                                  title: titleController.text,
                                  body: bodyController.text,
                                  postedBy: userIdUser,
                                  media: mediaPaths,
                                  coverMedia: []);
                              try {
                                if (!_isDisposed || !mounted) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                }
                                await _blogPostRepository.creatBlog(
                                    httpData: blogData);

                                if (!_isDisposed || !mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                                navigatorPop(context);
                              } catch (error) {
                                showMySnackBar(context, error.toString());
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              _isLoading ? CircularProgressIndicatorOnStack() : SizedBox(),
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
