import 'dart:convert';

import 'package:http/http.dart';
import 'package:sessions/models/blogpost.model.dart';
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
        print(room.toJson());
        return room;
      }).toList();
      print(res);
      return res;
    } else {
      print(jsonDecode(response.body)['_message']);
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
        print(room.toJson());
        return room;
      }).toList();

      return res;
    } else {
      throw Exception(body['_message']);
    }
  }
}
