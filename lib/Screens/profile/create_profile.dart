// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/drop_downs.dart';

import 'package:sessions/components/input_fields.dart';

import 'package:sessions/constants.dart';

import 'package:sessions/screens/profile/components/profile_image_utils.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/util_classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  ProfileInputVariables inputVariables = ProfileInputVariables(
    firstName: "",
    lastName: "",
    profilePic: "",
    userName: "",
  );

  ProfileInputControllers inputControllers = ProfileInputControllers();

  String saveString = "";

  void addProfilePic(String path) {
    setState(() {
      inputVariables.profilePic = path;
    });
  }

  Future<void> saveProfileData(ProfileInputVariables data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataString = jsonEncode(data.toJson());
    prefs.setString("profileData", dataString);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString("profileData");
    if (jsonData != null) {
      dynamic data = jsonDecode(jsonData);
    }
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
                        inputVariables.profilePic == ""
                            ? SizedBox()
                            : ProfileImage(
                                profilePicPath: inputVariables.profilePic,
                                size: size,
                              ),
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
                options: inputVariables.collegeDropDown,
                fieldName: "Select your College",
              ),
              CustomDropdownButton(
                prefixIcon: Icons.science,
                options: inputVariables.specializationDropDown,
                fieldName: "Select your Specialization",
              ),
              CustomDropdownButton(
                prefixIcon: Icons.work,
                options: inputVariables.designationDropDown,
                fieldName: "Select your Designation",
              ),
              InterestsTile(size: size),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AddLinksBox(linkTiles: inputVariables.linkTiles),
              ),
              RoundedButton(
                title: "Save",
                onPress: () async {
                  //await saveProfileData(inputVariables);
                  await loadData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInputControllers {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController interests = TextEditingController();
}
