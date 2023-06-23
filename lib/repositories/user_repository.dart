import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/models/user.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class UserRepository {
  Future<UserModel> signUp({required UserSignUpSend httpData}) async {
    Pair urlInfo = UserUrls.signUp;
    Response response = await httpRequestMethod(
      urlInfo: urlInfo,
      body: httpData.toJson(),
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(body);
      return user;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<UserModel> signIn({required UserSignInSend httpData}) async {
    Pair urlInfo = UserUrls.signIn;
    Response response = await httpRequestMethod(
      urlInfo: urlInfo,
      body: httpData.toJson(),
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(body);
      return user;
    } else {
      throw Exception(body['_message']);
    }
  }
}
