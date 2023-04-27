// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'package:sessions/models/room.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class RoomRepository {
  Future<RoomModel> creatRoom({required CreateRoomSend httpData}) async {
    Pair urlInfo = RoomUrls.create, mediaUrl = MediaUploadUrls.uploadMedia;

    if (httpData.media!.isNotEmpty) {
      httpData.folderName = "room";
      final request = MultipartRequest('POST', Uri.parse(mediaUrl.url));
      final List<MultipartFile> files = [];

      files.add(await MultipartFile.fromPath(
        'files',
        httpData.media!,
      ));

      request.files.addAll(files);
      request.headers['Content-Type'] = 'application/json';
      final jsonPayload = jsonEncode(httpData);
      Map<String, dynamic> jsonMap = jsonDecode(jsonPayload);
      Map<String, String> stringMap = Map<String, String>.from(
          jsonMap.map((key, value) => MapEntry(key, value.toString())));
      request.fields.addAll(stringMap);

      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception("Error uploading room coverpic!");
      }
      var responseString = await response.stream.bytesToString();
      var decodedResponse = jsonDecode(responseString);
      decodedResponse = decodedResponse[0];
      httpData.coverPic = MediaLink(
        secureUrl: decodedResponse['secure_url'],
        publicId: decodedResponse['public_id'],
      );
    }

    Response responseData =
        await httpRequestMethod(urlInfo: urlInfo, body: httpData);
    final body = jsonDecode(responseData.body);

    if (responseData.statusCode == 200) {
      RoomModel room = RoomModel.fromJson(body);
      return room;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<List<RoomModel>> getAllRooms() async {
    Pair urlInfo = RoomUrls.getAllRooms;

    Response response = await httpRequestMethod(urlInfo: urlInfo);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = body;
      //print(body);
      final res = result.map((e) {
        RoomModel room = RoomModel.fromJson(e);

        return room;
      }).toList();

      return res;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<List<RoomModel>> getRoomsOfType({required String roomType}) async {
    Pair urlInfo = RoomUrls.getRoomsOfType(type: roomType);

    Response response =
        await httpRequestMethod(urlInfo: urlInfo, params: {"type": roomType});

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List result = body;

      final res = result.map((e) {
        RoomModel room = RoomModel.fromJson(e);
        return room;
      }).toList();

      return res;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<List<IdObject>> getRoomMessages(
      {required FetchMessagesRoom fetchQuery}) async {
    Pair urlInfo = RoomUrls.fetchMessages;
    Response response =
        await httpRequestMethod(urlInfo: urlInfo, body: fetchQuery);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = body;
      final messages = result.map((e) {
        IdObject message = IdObject.fromJson(e);
        return message;
      }).toList();

      return messages;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<void> createRoomMessage(
      {required CreateMessageSend messageBody}) async {
    Pair urlInfo = RoomUrls.sendMessage;
    Response response =
        await httpRequestMethod(urlInfo: urlInfo, body: messageBody);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {
      throw Exception(body['_message']);
    }
  }
}
