// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';

class BlogPostRepository {
  Future<List<BlogPostModel>> getAllBlogs() async {
    Pair urlInfo = BlogUrls.getAllBlogs;
    // print(urlInfo.url);
    Uri uri = Uri.parse(urlInfo.url);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      response.body;
      final List result = jsonDecode(response.body);

      return result.map((e) {
        BlogPostModel newBlog = BlogPostModel.fromJson(e);
        // List<CoverMediaItem>? lst = newBlog.coverMedia;
        // for (var item in lst!) {
        //   print(item.url);
        // }
        return newBlog;
      }).toList();
    } else {
      print(jsonDecode(response.body)['_message']);
      throw Exception(jsonDecode(response.body)['_message']);
    }
  }
}
