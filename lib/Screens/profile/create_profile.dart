// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/drop_downs.dart';

import 'package:sessions/components/input_fields.dart';

import 'package:sessions/constants.dart';

import 'package:sessions/screens/profile/components/profile_image_utils.dart';
import 'package:sessions/screens/profile/components/tiles.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final List<String> collegeDropDown = [
    "NIT Kurukshetra",
    "NIT Warangal",
    "NIT Agartala",
    "None"
  ];

  final List<String> specializationDropDown = [
    "ECE",
    "CSE",
    "IT",
  ];

  final List<String> designationDropDown = [
    "Student",
    "Teacher",
    "Professor",
    "Doctor",
    "Student",
  ];

  final List<String> interestDropDown = [
    "Coding",
    "Web development",
    "Placement",
    "Android Development",
    "AI/ML",
  ];

  final List<LinkTile> linkTiles = [
    LinkTile(),
    LinkTile(),
    LinkTile(),
    LinkTile(),
  ];

  String appDirectoryPath = "";
  String profilePicPath = "";

  void addProfilePic(String path) {
    setState(() {
      profilePicPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CurvedAppBar(
        title: "Create Profile",
        leading: Icon(Icons.arrow_back_ios),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 5,
        ),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: 230,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Center(
                      child: AddImageIcon(
                        setProfile: addProfilePic,
                      ),
                    ),
                    Stack(
                      children: [
                        profilePicPath == ""
                            ? SizedBox()
                            : ProfileImage(
                                profilePicPath: profilePicPath, size: size),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: AddImageIcon(
                            setProfile: addProfilePic,
                            plusRadius: 10,
                            iconSize: 15,
                            picIconSize: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedInputField(fieldName: "First Name"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SizedInputField(fieldName: "Last Name"),
                  ),
                ],
              ),
              SizedInputField(fieldName: "UserName"),
              CustomDropdownButton(
                prefixIcon: Icons.school,
                options: collegeDropDown,
                fieldName: "Select your College",
              ),
              CustomDropdownButton(
                prefixIcon: Icons.science,
                options: specializationDropDown,
                fieldName: "Select your Specialization",
              ),
              CustomDropdownButton(
                prefixIcon: Icons.work,
                options: designationDropDown,
                fieldName: "Select your Designation",
              ),
              InterestsTile(size: size),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AddLinksBox(linkTiles: linkTiles),
              ),
              RoundedButton(
                title: "Save",
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
