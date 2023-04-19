import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class ProfileRepository {
  Future<ProfileModel?>? loadProfile({required String userId}) async {
    Pair urlInfo = ProfileUrls.fetchProfile(userId: userId);

    Response responseData =
        await httpRequestMethod(urlInfo: urlInfo, params: {"userId": userId});
    final body = jsonDecode(responseData.body);

    if (responseData.statusCode == 200) {
      if (body != null) {
        ProfileModel profile = ProfileModel.fromJson(body);
        return profile;
      }
      return null;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<ProfileModel> create({required CreateProfileSend httpData}) async {
    Pair urlInfo = ProfileUrls.create, mediaUrl = ProfileUrls.mediaUpload;

    final request = MultipartRequest('POST', Uri.parse(mediaUrl.url));
    final files = [
      await MultipartFile.fromPath('files', httpData.coverPicFileUrl!,
          filename: 'coverPic'),
      await MultipartFile.fromPath('files', httpData.profilePicFileUrl!,
          filename: 'profilePic'),
      // add more files as needed
    ];
    request.files.addAll(files);
    request.headers['Content-Type'] = 'application/json';
    final jsonPayload = jsonEncode(httpData);
    Map<String, dynamic> jsonMap = jsonDecode(jsonPayload);
    Map<String, String> stringMap = Map<String, String>.from(
        jsonMap.map((key, value) => MapEntry(key, value.toString())));

    request.fields.addAll(stringMap);
    final response = await request.send();
    // var stream = response.stream;
    // var subscription = stream.listen((data) {
    //   var decodedData = utf8.decode(data);
    //   print(decodedData);
    // });
    if (response.statusCode != 200) {
      throw Exception("Error uploading profile media");
    }
    var responseString = await response.stream.bytesToString();
    var decodedResponse = jsonDecode(responseString);
    //print(decodedResponse['uploadedProfilePic']);

    httpData.profilePic = MediaLink(
        secureUrl: decodedResponse['uploadedProfilePic']['secure_url'],
        publicId: decodedResponse['uploadedProfilePic']['public_id']);
    httpData.coverPic = MediaLink(
        secureUrl: decodedResponse['uploadedCoverPic']['secure_url'],
        publicId: decodedResponse['uploadedCoverPic']['public_id']);
    // print(httpData.coverPic!.toJson());
    // print(httpData.profilePic!.toJson());
    //print(httpData.toJson());
    Response responseData =
        await httpRequestMethod(urlInfo: urlInfo, body: httpData);
    final body = jsonDecode(responseData.body);

    if (responseData.statusCode == 200) {
      ProfileModel profile = ProfileModel.fromJson(body);

      return profile;
    } else {
      throw Exception(body['_message']);
    }
  }
}
