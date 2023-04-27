// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'package:sessions/models/room.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class SessionRepository {
  Future<void> createSession({required CreateSessionSend httpData}) async {
    Pair urlInfo = SessionUrls.create;

    Response responseData =
        await httpRequestMethod(urlInfo: urlInfo, body: httpData);
    final body = jsonDecode(responseData.body);

    if (responseData.statusCode == 200) {
      return;
    } else {
      throw Exception(body['_message']);
    }
  }

  Future<List<RoomModel>> getAllSessions() async {
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
}

class CreateSessionSend {
  final String field;
  final DateTime startDate;
  final DateTime endDate;
  final double payAmount;
  final String roomId;
  final String createdBy;
  final DateTime startTime;
  final DateTime endTime;
  final String repeat;

  CreateSessionSend(
    this.field, {
    required this.startDate,
    required this.endDate,
    required this.payAmount,
    required this.roomId,
    required this.createdBy,
    required this.startTime,
    required this.endTime,
    required this.repeat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'field': field,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'payAmount': payAmount,
      'roomId': roomId,
      'createdBy': createdBy,
      'startTime': startTime.toUtc().toIso8601String(),
      'endTime': endTime.toUtc().toIso8601String(),
      'repeat': repeat,
    };
  }

  factory CreateSessionSend.fromMap(Map<String, dynamic> map) {
    return CreateSessionSend(
      map['field'] as String,
      startDate: DateTime.parse(map['startDate']).toLocal(),
      endDate: DateTime.parse(map['endDate']).toLocal(),
      payAmount: map['payAmount'] as double,
      roomId: map['roomId'] as String,
      createdBy: map['createdBy'] as String,
      startTime: DateTime.parse(map['startTime']).toLocal(),
      endTime: DateTime.parse(map['endTime']).toLocal(),
      repeat: map['repeat'] as String,
    );
  }
}
