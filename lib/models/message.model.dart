import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String? _id;
  final String? type;
  final String? content;
  final List<Reply>? replies;
  final String? sentBy;
  final String? sentTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel(
    this._id, {
    this.type,
    this.content,
    this.replies,
    this.sentBy,
    this.sentTo,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'type': type,
      'content': content,
      'replies': replies!.map((x) => x.toJson()).toList(),
      'sentBy': sentBy,
      'sentTo': sentTo,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    final List<Reply> newReplies = [];
    for (var item in map['replies']) {
      newReplies.add(Reply.fromJson(item));
    }
    return MessageModel(
      map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      replies: newReplies,
      sentBy: map['sentBy'] != null ? map['sentBy'] as String : null,
      sentTo: map['sentTo'] != null ? map['sentTo'] as String : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}

class Reply {
  final String? _id;
  final String? reply;
  final String? repliedBy;
  final DateTime? time;

  Reply(
    this._id, {
    this.reply,
    this.repliedBy,
    this.time,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'reply': reply,
      'repliedBy': repliedBy,
      'time': time!.toIso8601String(),
    };
  }

  factory Reply.fromJson(Map<String, dynamic> map) {
    return Reply(
      map['_id'] != null ? map['_id'] as String : null,
      reply: map['reply'] != null ? map['reply'] as String : null,
      repliedBy: map['repliedBy'] != null ? map['repliedBy'] as String : null,
      time: map['time'] != null ? DateTime.parse(map['time']) : null,
    );
  }
}
