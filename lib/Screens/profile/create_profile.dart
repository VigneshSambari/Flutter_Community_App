// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sessions/bloc/blog/blog_bloc_imports.dart';
import 'package:sessions/bloc/profile/profile_bloc_imports.dart';
import 'package:sessions/bloc/user/user_bloc_imports.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/drop_downs.dart';

import 'package:sessions/components/input_fields.dart';
import 'package:sessions/components/snackbar.dart';
import 'package:sessions/components/utils.dart';

import 'package:sessions/constants.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/screens/entryPoint/entry_point.dart';

import 'package:sessions/screens/profile/components/profile_image_utils.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/util_classes.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/enums.dart';
import 'package:sessions/utils/navigations.dart';

List<LinkTile> linkTiles = [];

List<String> collegeDropDown = [
  "NIT Kurukshetra",
  "NIT Warangal",
  "NIT Agartala",
  "None"
];
List<String> specializationDropDown = [
  "ECE",
  "CSE",
  "IT",
  "MECH",
  "CIVIL",
  "PIE",
  "None"
];

List<String> designationDropDown = [
  "Student",
  "Teacher",
  "Professor",
  "Doctor",
  "Student",
  "None"
];

List<String> interestDropDown = [
  "Coding",
  "Web development",
  "Placement",
  "Android Development",
  "AI/ML",
  "Gaming"
];

Set<String> interestList = {};

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
      coverPhoto: "",
      designation: "",
      specialization: "");

  ProfileInputControllers inputControllers = ProfileInputControllers();
  String collegeValue = "", specializationValue = "", designationValue = "";
  String saveString = "";

  void addProfilePic(String path) {
    setState(() {
      inputVariables.profilePic = path;
    });
  }

  void addCoverPhoto(String path) {
    setState(() {
      inputVariables.coverPhoto = path;
    });
  }

  // Future<void> saveProfileData(ProfileInputVariables data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String dataString = jsonEncode(data.toJson());
  //   prefs.setString("profileData", dataString);
  // }

  // Future<void> loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final jsonData = prefs.getString("profileData");
  //   if (jsonData != null) {}
  // }

  void setDropDownValue({required String value, required DropTypes dropType}) {
    if (dropType == DropTypes.collegeDropDown) {
      print(value);
      collegeValue = value;
    } else if (dropType == DropTypes.designationDropDown) {
      print(value);
      designationValue = value;
    } else if (dropType == DropTypes.specializationDropDown) {
      print(value);
      specializationValue = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController firstNameCont = TextEditingController(),
        lastNameCont = TextEditingController(),
        userNameCont = TextEditingController(),
        interestCont = TextEditingController();

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
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      height: 300,
                      child: Stack(
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
                                    setProfile: addCoverPhoto,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    inputVariables.coverPhoto == ""
                                        ? SizedBox()
                                        : CoverPhoto(
                                            profilePicPath:
                                                inputVariables.coverPhoto,
                                            size: size,
                                          ),
                                    inputVariables.coverPhoto == ""
                                        ? SizedBox()
                                        : Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: AddImageIcon(
                                              setProfile: addCoverPhoto,
                                              plusRadius: 10,
                                              iconSize: 15,
                                              picIconSize: 40,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 15,
                            bottom: 10,
                            child: Container(
                              width: size.width * 0.25,
                              height: size.width * 0.25,
                              child: Padding(
                                padding: EdgeInsets.all(1),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      child: CircleAvatar(
                                        radius: 53.5,
                                        backgroundColor: kPrimaryLightColor,
                                        child: Center(
                                          child: AddImageIcon(
                                            setProfile: addProfilePic,
                                            picIconSize: 27,
                                            plusRadius: 6,
                                            iconSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    inputVariables.profilePic == ""
                                        ? SizedBox()
                                        : ProfileImage(
                                            radius: 60,
                                            profilePicPath:
                                                inputVariables.profilePic,
                                          ),
                                    inputVariables.profilePic == ""
                                        ? SizedBox()
                                        : Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: AddImageIcon(
                                              setProfile: addProfilePic,
                                              plusRadius: 7,
                                              iconSize: 10,
                                              picIconSize: 28,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedInputField(
                              fieldName: "First Name",
                              controller: firstNameCont),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: SizedInputField(
                            fieldName: "Last Name",
                            controller: lastNameCont,
                          ),
                        ),
                      ],
                    ),
                    SizedInputField(
                      fieldName: "UserName",
                      controller: userNameCont,
                    ),
                    CustomDropdownButton(
                      dropType: DropTypes.collegeDropDown,
                      prefixIcon: Icons.school,
                      options: collegeDropDown,
                      fieldName: "Select your College",
                      changeValue: setDropDownValue,
                    ),
                    CustomDropdownButton(
                      dropType: DropTypes.specializationDropDown,
                      prefixIcon: Icons.science,
                      options: specializationDropDown,
                      fieldName: "Select your Specialization",
                      changeValue: setDropDownValue,
                    ),
                    CustomDropdownButton(
                      dropType: DropTypes.designationDropDown,
                      prefixIcon: Icons.work,
                      options: designationDropDown,
                      fieldName: "Select your Designation",
                      changeValue: setDropDownValue,
                    ),
                    InterestsTile(
                        size: size,
                        controller: interestCont,
                        interestsList: interestList),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: AddLinksBox(linkTiles: linkTiles),
                    ),
                    BlocListener<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileCreatedState) {
                          navigatorPopAllExceptFirst(context);
                          navigatorPushReplacement(context, EntryPoint());
                        }
                      },
                      child: RoundedButton(
                        title: "Save",
                        onPress: () async {
                          String userIdUser;
                          final userState =
                              BlocProvider.of<UserBloc>(context).state;
                          if (userState is UserSignedInState) {
                            userIdUser = userState.user.userId!;
                          } else {
                            return;
                          }
                          if (firstNameCont.text.isEmpty ||
                              lastNameCont.text.isEmpty) {
                            showMySnackBar(context,
                                "First name and last name cannot be empty!");
                            return;
                          }
                          if (userNameCont.text.isEmpty) {
                            showMySnackBar(
                                context, "Username cannot be empty!");
                            return;
                          }
                          List<Map<String, String>> links = [];
                          for (var link in linkTiles) {
                            Map<String, String> currLink = {};
                            if (link.nameCont.text.isEmpty ||
                                link.linkCont.text.isEmpty) {
                              showMySnackBar(context, "Fill all link fields!");
                              print(
                                  link.nameCont.text + "" + link.linkCont.text);
                              return;
                            }
                            currLink[link.nameCont.text] = link.linkCont.text;
                            links.add(currLink);
                          }
                          print(
                              "$collegeValue, $designationValue, $specializationValue");
                          BlocProvider.of<ProfileBloc>(context).add(
                            CreateProfileEvent(
                              profileData: CreateProfileSend(
                                  userName: userNameCont.text,
                                  name: firstNameCont.text,
                                  userId: userIdUser,
                                  college: collegeValue,
                                  specialization: specializationValue,
                                  designation: designationValue,
                                  interests: interestList.toList(),
                                  links: links,
                                  coverPicFileUrl: inputVariables.coverPhoto,
                                  profilePicFileUrl: inputVariables.profilePic),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return Center(
                    child: CircularProgressIndicatorOnStack(),
                  );
                }
                return SizedBox();
              },
            ),
          ],
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
