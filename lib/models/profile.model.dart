// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  final String? profilePic;
  final String? coverPic;
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
      'lastseen': lastseen?.millisecondsSinceEpoch,
      'connections': connections!.map((x) => x.toJson()).toList(),
      'connectionRequests': connectionRequests!.map((x) => x.toJson()).toList(),
      'requestsSent': requestsSent!.map((x) => x.toJson()).toList(),
      'interests': interests,
      'blogs': blogs!.map((x) => x.toJson()).toList(),
      'links': links!.map((x) => x.toJson()).toList(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      rooms: map['rooms'] != null
          ? List<RoomItem>.from(
              (map['rooms'] as List<int>).map<RoomItem?>(
                (x) => RoomItem.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      college: map['college'] != null ? map['college'] as String : null,
      specialization: map['specialization'] != null
          ? map['specialization'] as String
          : null,
      designation:
          map['designation'] != null ? map['designation'] as String : null,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      coverPic: map['coverPic'] != null ? map['coverPic'] as String : null,
      online: map['online'] != null ? map['online'] as bool : null,
      lastseen: map['lastseen'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastseen'] as int)
          : null,
      connections: map['connections'] != null
          ? List<IdObject>.from(
              (map['connections'] as List<int>).map<IdObject?>(
                (x) => IdObject.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      connectionRequests: map['connectionRequests'] != null
          ? List<IdObject>.from(
              (map['connectionRequests'] as List<int>).map<IdObject?>(
                (x) => IdObject.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      requestsSent: map['requestsSent'] != null
          ? List<IdObject>.from(
              (map['requestsSent'] as List<int>).map<IdObject?>(
                (x) => IdObject.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      interests: map['interests'] != null
          ? List<String>.from(map['interests'] as List<String>)
          : null,
      blogs: map['blogs'] != null
          ? List<IdObject>.from(
              (map['blogs'] as List<int>).map<IdObject?>(
                (x) => IdObject.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      links: map['links'] != null
          ? List<LinkItem>.from(
              (map['links'] as List<int>).map<LinkItem?>(
                (x) => LinkItem.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }
}
