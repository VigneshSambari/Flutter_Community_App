// ignore_for_file: public_member_api_docs, sort_constructors_first;

import 'package:sessions/utils/classes.dart';

class RoomModel {
  final String? _id;
  final String? name;
  final String? groupIcon;
  final String? type;
  final String? description;
  final String? createdBy;
  final List<IdObject>? admins;
  final List<IdObject>? users;
  final List<IdObject>? requests;
  final List<IdObject>? messages;
  final List<String>? tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RoomModel(
    this._id, {
    this.name,
    this.groupIcon,
    this.type,
    this.description,
    this.createdBy,
    this.admins,
    this.users,
    this.requests,
    this.messages,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'name': name,
      'groupIcon': groupIcon,
      'type': type,
      'description': description,
      'createdBy': createdBy,
      'admins': admins!.map((x) => x.toJson()).toList(),
      'users': users!.map((x) => x.toJson()).toList(),
      'requests': requests!.map((x) => x.toJson()).toList(),
      'messages': messages!.map((x) => x.toJson()).toList(),
      'tags': tags,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> map) {
    List<IdObject> newAdmins = [],
        newUsers = [],
        newRequests = [],
        newMessages = [];
    List<String> newTags = [];
    for (var item in map['tags']) {
      newTags.add(item);
    }
    for (var item in map['admins']) {
      newAdmins.add(IdObject.fromJson(item));
    }
    for (var item in map['users']) {
      newUsers.add(IdObject.fromJson(item));
    }
    for (var item in map['requests']) {
      newRequests.add(IdObject.fromJson(item));
    }
    for (var item in map['messages']) {
      newMessages.add(IdObject.fromJson(item));
    }
    return RoomModel(
      map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      groupIcon: map['groupIcon'] != null ? map['groupIcon'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      admins: newAdmins,
      users: newUsers,
      requests: newRequests,
      messages: newMessages,
      tags: newTags,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
