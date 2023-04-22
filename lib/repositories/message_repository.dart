// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'package:sessions/models/message.model.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/server_urls.dart';
import 'package:sessions/utils/util_methods.dart';

class MessageRepository {
  Future<List<MessageModel>> getListedMessages(
      {required MessageIdList messageIds}) async {
    Pair urlInfo = MessageUrls.fetchListedMessages;

    Response response =
        await httpRequestMethod(urlInfo: urlInfo, body: messageIds);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = body;
      //print(body);
      final messages = result.map((e) {
        MessageModel message = MessageModel.fromJson(e);
        // print(message.toJson());
        return message;
      }).toList();

      return messages;
    } else {
      throw Exception(body['_message']);
    }
  }
}

class MessageIdList {
  final List<IdObject>? ids;

  MessageIdList({required this.ids});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ids': ids!.map((x) => x.toJson()).toList(),
    };
  }

  factory MessageIdList.fromJson(Map<String, dynamic> map) {
    final List<IdObject> newIds = [];
    for (var item in map['ids']) {
      newIds.add(IdObject.fromJson(item));
    }
    return MessageIdList(
      ids: newIds,
    );
  }
}
