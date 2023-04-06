import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/utils/classes.dart';

Future<Response> httpRequestMethod(
    {required Pair urlInfo, dynamic? body, String? token}) async {
  Response response;
  Uri uri = Uri.parse(urlInfo.url);
  try {
    if (urlInfo.requestType == false) {
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
