// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:sessions/utils/classes.dart';

class ProfileModel {
  final String? _id;
  final String? userId;
  final String? name;
  final String? userName;
  final List<RoomItem>? rooms;
  final String? college;
  final String? specialization;
  final String? designation;
  final MediaLink? profilePic;
  final MediaLink? coverPic;
  final bool? online;
  final DateTime? lastseen;
  final List<IdObject>? connections;
  final List<IdObject>? connectionRequests;
  final List<IdObject>? requestsSent;
  final List<String>? interests;
  final List<IdObject>? blogs;
  final List<LinkItem>? links;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileModel(
    this._id, {
    this.userId,
    this.name,
    this.userName,
    this.rooms,
    this.college,
    this.specialization,
    this.designation,
    this.profilePic,
    this.coverPic,
    this.online,
    this.lastseen,
    this.connections,
    this.connectionRequests,
    this.requestsSent,
    this.interests,
    this.blogs,
    this.links,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'userId': userId,
      'name': name,
      'userName': userName,
      'rooms': rooms!.map((x) => x.toJson()).toList(),
      'college': college,
      'specialization': specialization,
      'designation': designation,
      'profilePic': profilePic,
      'coverPic': coverPic,
      'online': online,
      'lastseen': lastseen!.toIso8601String(),
      'connections': connections!.map((x) => x.toJson()).toList(),
      'connectionRequests': connectionRequests!.map((x) => x.toJson()).toList(),
      'requestsSent': requestsSent!.map((x) => x.toJson()).toList(),
      'interests': interests,
      'blogs': blogs!.map((x) => x.toJson()).toList(),
      'links': links!.map((x) => x.toJson()).toList(),
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    List<IdObject> newConnections = [],
        newConnectionRequests = [],
        newRequestsSent = [],
        newBlogs = [];
    List<LinkItem> newLinks = [];
    List<RoomItem> newRooms = [];
    List<String> newInterests = [];
    for (var item in map['connections']) {
      newConnections.add(IdObject.fromJson(item));
    }
    for (var item in map['connectionRequests']) {
      newConnectionRequests.add(IdObject.fromJson(item));
    }
    for (var item in map['requestsSent']) {
      newRequestsSent.add(IdObject.fromJson(item));
    }
    for (var item in map['blogs']) {
      newBlogs.add(IdObject.fromJson(item));
    }
    for (var item in map['links']) {
      newLinks.add(LinkItem.fromJson(item));
    }
    for (var item in map['rooms']) {
      newRooms.add(RoomItem.fromJson(item));
    }
    for (var item in map['interests']) {
      newInterests.add(item);
    }
    return ProfileModel(
      map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      rooms: newRooms,
      college: map['college'] != null ? map['college'] as String : null,
      specialization: map['specialization'] != null
          ? map['specialization'] as String
          : null,
      designation:
          map['designation'] != null ? map['designation'] as String : null,
      profilePic: map['profilePic'] != null
          ? MediaLink.fromJson(map['profilePic'])
          : null,
      coverPic:
          map['coverPic'] != null ? MediaLink.fromJson(map['coverPic']) : null,
      online: map['online'] != null ? map['online'] as bool : null,
      lastseen:
          map['lastseen'] != null ? DateTime.parse(map['lastseen']) : null,
      connections: newConnections,
      connectionRequests: newConnectionRequests,
      requestsSent: newRequestsSent,
      interests: newInterests,
      blogs: newBlogs,
      links: newLinks,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
