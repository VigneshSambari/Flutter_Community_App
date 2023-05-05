import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sessions/constants.dart';

class PushNotifications {
  String oneSignalApiUrl = 'https://onesignal.com/api/v1/notifications';
  Future<void> sendPushNotification(
      {required List<String> externalUserIds,
      required String title,
      required String message,
      String routeName = ""}) async {
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Basic $oneSignalRestApiKey',
    };

    var request = {
      'app_id': oneSignalAppId,
      'include_external_user_ids': externalUserIds,
      'contents': {'en': message},
      'headings': {'en': title},
      'data': {'route': routeName}
    };

    await http.post(
      Uri.parse(oneSignalApiUrl),
      headers: headers,
      body: json.encode(request),
    );
  }
}
