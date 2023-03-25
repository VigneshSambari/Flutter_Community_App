// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:convert';

import 'package:sessions/screens/profile/components/tiles.dart';

// class ProfileInputvariables {
//   String firstName = "";
//   String lastName = "";
//   String userName = "";
//   String profilePic = "";

//   final List<Map<String, String>> links = [];
//   final List<String> interests = [];
//   final List<String> collegeDropDown = [
//     "NIT Kurukshetra",
//     "NIT Warangal",
//     "NIT Agartala",
//     "None"
//   ];
//   final List<String> specializationDropDown = [
//     "ECE",
//     "CSE",
//     "IT",
//   ];

//   final List<String> designationDropDown = [
//     "Student",
//     "Teacher",
//     "Professor",
//     "Doctor",
//     "Student",
//   ];

//   final List<String> interestDropDown = [
//     "Coding",
//     "Web development",
//     "Placement",
//     "Android Development",
//     "AI/ML",
//   ];

//   final List<LinkTile> linkTiles = [
//     LinkTile(),
//     LinkTile(),
//     LinkTile(),
//     LinkTile(),
//   ];
//}

class ProfileInputVariables {
  String firstName = "";
  String lastName = "";
  String userName = "";
  String profilePic = "";
  ProfileInputVariables({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.profilePic,
  });
  final List<Map<String, String>> links = [];
  final List<String> interests = [];
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'profilePic': profilePic,
    };
  }

  factory ProfileInputVariables.fromMap(Map<String, dynamic> map) {
    return ProfileInputVariables(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      userName: map['userName'] as String,
      profilePic: map['profilePic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileInputVariables.fromJson(String source) =>
      ProfileInputVariables.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
