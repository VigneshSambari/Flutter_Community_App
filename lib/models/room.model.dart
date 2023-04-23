// ignore_for_file: public_member_api_docs, sort_constructors_first;

import 'package:sessions/utils/classes.dart';

class RoomModel {
  final String? _id;
  final String? name;
  final String? groupIcon;
  final String? type;
  final String? description;
  final String? createdBy;
  final List<IdObject>? users;
  final List<IdObject>? requests;
  final String? messageListId;
  final List<String>? tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MediaLink? coverPic;

  String? get roomId => _id;

  RoomModel(this._id,
      {this.name,
      this.groupIcon,
      this.type,
      this.description,
      this.createdBy,
      this.users,
      this.requests,
      this.messageListId,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.coverPic});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'name': name,
      'groupIcon': groupIcon,
      'type': type,
      'coverPic': coverPic,
      'description': description,
      'createdBy': createdBy,
      'users': users!.map((x) => x.toJson()).toList(),
      'requests': requests!.map((x) => x.toJson()).toList(),
      'messages': messageListId,
      'tags': tags,
      'createdAt': createdAt!.toUtc().toIso8601String(),
      'updatedAt': updatedAt!.toUtc().toIso8601String(),
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> map) {
    List<IdObject> newRequests = [];
    List<IdObject> newUsers = [];
    List<String> newTags = [];
    for (var item in map['tags']) {
      newTags.add(item);
    }
    for (var item in map['users']) {
      newUsers.add(IdObject.fromJson(item));
    }
    for (var item in map['requests']) {
      newRequests.add(IdObject.fromJson(item));
    }

    return RoomModel(
      map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      groupIcon: map['groupIcon'] != null ? map['groupIcon'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      users: newUsers,
      requests: newRequests,
      coverPic:
          map['coverPic'] != null ? MediaLink.fromJson(map['coverPic']) : null,
      messageListId:
          map['messageListId'] != null ? map['messageListId'] as String : null,
      tags: newTags,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt']).toLocal()
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt']).toLocal()
          : null,
    );
  }
}
