// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'package:sessions/models/session.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class SessionRepository {
  Future<SessionModel> createSession(
      {required CreateSessionSend httpData}) async {
    Pair urlInfo = SessionUrls.create;
    Response responseData =
        await httpRequestMethod(urlInfo: urlInfo, body: httpData);
    final body = jsonDecode(responseData.body);
    if (responseData.statusCode == 200) {
      SessionModel session = SessionModel.fromJson(body);
      return session;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<List<SessionModel>> getListedSessions({required IdList ids}) async {
    Pair urlInfo = SessionUrls.fetchListed;

    Response response = await httpRequestMethod(urlInfo: urlInfo, body: ids);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = body;
      //print(body);
      final res = result.map((e) {
        SessionModel session = SessionModel.fromJson(e);
        return session;
      }).toList();

      return res;
    } else {
      throw Exception(body['_message']);
    }
  }
}
