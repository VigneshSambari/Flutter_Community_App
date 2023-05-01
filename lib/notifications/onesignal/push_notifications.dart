import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sessions/constants.dart';

String oneSignalApiUrl = 'https://onesignal.com/api/v1/notifications';

Future<void> sendPushNotification(String externalUserId, String message) async {
  var headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Authorization': 'Basic $oneSignalRestApiKey',
  };

  var request = {
    'app_id': oneSignalAppId,
    'include_external_user_ids': [externalUserId],
    'contents': {'en': message},
  };

  var response = await http.post(
    Uri.parse(oneSignalApiUrl),
    headers: headers,
    body: json.encode(request),
  );
}
