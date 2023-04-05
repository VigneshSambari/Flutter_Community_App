import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/models/user.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';

class userRepository {
  // Future<List<BlogPostModel>> signUpUser() async {
  //   Pair urlInfo = BlogUrls.getAllBlogs;
  //   Uri uri = Uri.parse(urlInfo.url);
  //   Response response = await get(uri);
  //   if (response.statusCode == 200) {
  //     final List result = jsonDecode(response.body)['data'];
  //     return result.map((e) => BlogPostModel.fromJson(e)).toList();
  //   } else {
  //     print(jsonDecode(response.body)['_message']);
  //     throw Exception(jsonDecode(response.body)['_message']);
  //   }
  // }
}
