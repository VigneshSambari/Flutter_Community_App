import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/enums.dart';

Future<Response> httpRequestMethod(
    {required Pair urlInfo,
    dynamic body,
    String? token,
    dynamic params}) async {
  Response response;

  Uri uri = Uri.parse(urlInfo.url);
  try {
    if (urlInfo.requestType == false) {
      if (params != null) {
        uri.replace(queryParameters: params);
      }

      response = await get(uri);
      return response;
    } else {
      final headers = token == null
          ? {'Content-Type': 'application/json'}
          : {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            };
      response = await post(uri, headers: headers, body: json.encode(body));

      return response;
    }
  } catch (error) {
    throw Exception(error);
  }
}

String? validateEmail(String email) {
  String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  RegExp regex = RegExp(pattern);

  if (email.isEmpty) {
    return 'Email address is required';
  } else if (!regex.hasMatch(email)) {
    if (!email.contains('@')) {
      return 'Email address must contain the @ symbol';
    } else if (email.startsWith('@') || email.endsWith('@')) {
      return 'Email address cannot start or end with @ symbol';
    } else if (!email.contains('.')) {
      return 'Email address must contain a period (.) after the @ symbol';
    } else if (email.startsWith('.') || email.endsWith('.')) {
      return 'Email address cannot start or end with a period (.)';
    } else {
      return 'Please enter a valid email address';
    }
  } else {
    return null;
  }
}

String? validatePassword(String password) {
  if (password.isEmpty) {
    return 'Password is required';
  } else if (password.length < 8) {
    return 'Password must be at least 8 characters long';
  } else if (!password.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  } else if (!password.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  } else if (!password.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one digit';
  } else if (!password.contains(RegExp(r'[!@#\$%^&*]'))) {
    return 'Password must contain at least one special character (!@#\$%^&*)';
  } else {
    return null;
  }
}

String getRoomType({required RoomTypesEnum type}) {
  if (type == RoomTypesEnum.collegeClub) {
    return "collegeClub";
  } else if (type == RoomTypesEnum.collegeBranch) {
    return "collegeBranch";
  } else if (type == RoomTypesEnum.collegeNotifications) {
    return "collegeNotifications";
  } else if (type == RoomTypesEnum.collegePlacement) {
    return "collegePlacement";
  } else if (type == RoomTypesEnum.collegePrivate) {
    return "collegePrivate";
  } else if (type == RoomTypesEnum.collegePublic) {
    return "collegePublic";
  } else if (type == RoomTypesEnum.collegeQA) {
    return "collegeQA";
  } else if (type == RoomTypesEnum.userChats) {
    return "userChats";
  } else if (type == RoomTypesEnum.userPlacement) {
    return "userPlacement";
  } else if (type == RoomTypesEnum.userPrivate) {
    return "userPrivate";
  } else if (type == RoomTypesEnum.userProject) {
    return "userProject";
  } else if (type == RoomTypesEnum.userPublic) {
    return "userPublic";
  }
  return "userPublic";
}

String getRoomTitles({required RoomTypesEnum type}) {
  if (type == RoomTypesEnum.collegeClub) {
    return "College Clubs Channels";
  } else if (type == RoomTypesEnum.collegeBranch) {
    return "College Branch Channels";
  } else if (type == RoomTypesEnum.collegeNotifications) {
    return "Clg Notifications Channels";
  } else if (type == RoomTypesEnum.collegePlacement) {
    return "Clg Placements Channels";
  } else if (type == RoomTypesEnum.collegePrivate) {
    return "Clg Private Channels";
  } else if (type == RoomTypesEnum.collegePublic) {
    return "Clg Public Channels";
  } else if (type == RoomTypesEnum.collegeQA) {
    return "Collge Q&A Channels";
  } else if (type == RoomTypesEnum.userChats) {
    return "Chats";
  } else if (type == RoomTypesEnum.userPlacement) {
    return "Placements Channels";
  } else if (type == RoomTypesEnum.userPrivate) {
    return "Private Channels";
  } else if (type == RoomTypesEnum.userProject) {
    return "Project Channels";
  } else if (type == RoomTypesEnum.userPublic) {
    return "Public Channels";
  }
  return "userPublic";
}
