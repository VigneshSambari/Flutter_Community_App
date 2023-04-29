// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        print(newBlog.toJson());
        return newBlog;
      }).toList();
    } else {
      print(jsonDecode(response.body)['_message']);
      throw Exception(body['_message']);
    }
  }

  Future<List<BlogPostModel>> getPagedBlogs(
      {required FetchPagedBlogs httpData}) async {
    Pair urlInfo = BlogUrls.pagedBlogs;

    Response response = await httpRequestMethod(
      urlInfo: urlInfo,
      body: httpData,
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = body;

      return result.map((e) {
        BlogPostModel newBlog = BlogPostModel.fromJson(e);
        return newBlog;
      }).toList();
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<void> creatBlog({required CreateBlogSend httpData}) async {
    Pair urlInfo = BlogUrls.create, mediaUrl = BlogUrls.mediaUpload;
    print("before mesia upload");
    if (httpData.media!.isNotEmpty) {
      final request = MultipartRequest('POST', Uri.parse(mediaUrl.url));
      final List<MultipartFile> files = [];
      for (String localFile in httpData.media!) {
        // print(localFile);
        files.add(await MultipartFile.fromPath(
          'files',
          localFile,
        ));
      }
      request.files.addAll(files);
      request.headers['Content-Type'] = 'application/json';
      print("1");
      final jsonPayload = jsonEncode(httpData);
      print("2");
      Map<String, dynamic> jsonMap = jsonDecode(jsonPayload);
      print("3");
      Map<String, String> stringMap = Map<String, String>.from(
          jsonMap.map((key, value) => MapEntry(key, value.toString())));
      print("4");
      request.fields.addAll(stringMap);
      print("5");

      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception("Error uploading blog media");
      }
      print("after mesia upload");
      var responseString = await response.stream.bytesToString();
      var decodedResponse = jsonDecode(responseString);
      print(decodedResponse);

      for (var item in decodedResponse) {
        httpData.coverMedia!.add(
          MediaLink(
            secureUrl: item['secure_url'],
            publicId: item['public_id'],
          ),
        );
      }
    }
    //print(httpData.toJson());
    print("6");
    Response responseData =
        await httpRequestMethod(urlInfo: urlInfo, body: httpData);
    print("7");
    final body = jsonDecode(responseData.body);

    if (responseData.statusCode == 200) {
      BlogPostModel blog = BlogPostModel.fromJson(body);
      print(blog.toJson());
    } else {
      throw Exception(body['_message']);
    }
  }
}
