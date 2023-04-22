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
}

class FetchMessagesRoom {
  final String? roomId;
  final int? limit;
  final int? page;

  FetchMessagesRoom({required this.roomId, this.limit = 10, this.page = 1});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'roomId': roomId,
      'limit': limit,
      'page': page,
    };
  }

  factory FetchMessagesRoom.fromJson(Map<String, dynamic> map) {
    return FetchMessagesRoom(
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      limit: map['limit'] != null ? map['limit'] as int : null,
      page: map['page'] != null ? map['page'] as int : null,
    );
  }
}
