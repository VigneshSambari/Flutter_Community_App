// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/models/message.model.dart';
import 'package:sessions/models/room.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class RoomRepository {
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

class CreateMessageSend {
  final String sentBy;
  final String sentTo;
  final String type;
  final String content;
  final String roomId;
  final String messageId;

  CreateMessageSend({
    required this.sentBy,
    required this.sentTo,
    required this.type,
    required this.content,
    required this.roomId,
    required this.messageId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sentBy': sentBy,
      'sentTo': sentTo,
      'type': type,
      'content': content,
      'roomId': roomId,
      'messageId': messageId,
    };
  }

  factory CreateMessageSend.fromJson(Map<String, dynamic> map) {
    return CreateMessageSend(
      sentBy: map['sentBy'] as String,
      sentTo: map['sentTo'] as String,
      type: map['type'] as String,
      content: map['content'] as String,
      roomId: map['roomId'] as String,
      messageId: map['messageId'] as String,
    );
  }
}
