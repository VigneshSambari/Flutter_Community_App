// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:convert';

class ProfileInputVariables {
  String firstName = "";
  String lastName = "";
  String userName = "";
  String profilePic = "";
  String coverPhoto = "";
  String specialization = "";
  String designation = "";

  ProfileInputVariables({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.profilePic,
    required this.coverPhoto,
    required this.specialization,
    required this.designation,
  });
  List<Map<String, String>> links = [];
  List<String> interests = [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'profilePic': profilePic,
      'coverPhoto': coverPhoto,
      'specialization': specialization,
      'designation': designation,
    };
  }

  factory ProfileInputVariables.fromMap(Map<String, dynamic> map) {
    return ProfileInputVariables(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      userName: map['userName'] as String,
      profilePic: map['profilePic'] as String,
      coverPhoto: map['coverPhoto'] as String,
      specialization: map['specialization'] as String,
      designation: map['designation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileInputVariables.fromJson(String source) =>
      ProfileInputVariables.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
