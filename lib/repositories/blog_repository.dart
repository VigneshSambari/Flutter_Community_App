// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class BlogPostRepository {
  Future<List<BlogPostModel>> getAllBlogs() async {
    Pair urlInfo = BlogUrls.getAllBlogs;

    Response response = await httpRequestMethod(urlInfo: urlInfo);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = body;

      return result.map((e) {
        BlogPostModel newBlog = BlogPostModel.fromJson(e);
        return newBlog;
      }).toList();
    } else {
      print(jsonDecode(response.body)['_message']);
      throw Exception(body['_message']);
    }
  }
}
