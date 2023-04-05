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
