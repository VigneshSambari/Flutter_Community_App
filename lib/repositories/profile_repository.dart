import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class ProfileRepository {
  Future<ProfileModel> create({required CreateProfileSend httpData}) async {
    Pair urlInfo = ProfileUrls.create;
    print("called");

    Response response = await httpRequestMethod(
      urlInfo: urlInfo,
      body: httpData.toJson(),
    );
    print("call completed");
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ProfileModel profile = ProfileModel.fromJson(body);
      return profile;
    } else {
      throw Exception(body['_message']);
    }
  }
}
