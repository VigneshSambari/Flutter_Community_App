import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Pair {
  String url;
  bool requestType;
  Pair({
    required this.url,
    required this.requestType,
  });
}

class UserSignUpSend {
  String email;
  String? password;
  UserSignUpSend({required this.email, this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}

class UserSignInSend {
  String email;
  String? password;
  UserSignInSend({required this.email, this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}

class CreateProfileSend {
  final String userName;
  final String name;
  final String userId;
  final String college;
  final String specialization;
  final String designation;
  MediaLink? profilePic;
  MediaLink? coverPic;
  final List<String>? interests;
  final List<LinkSend>? links;
  final String? profilePicFileUrl;
  final String? coverPicFileUrl;

  CreateProfileSend(
      {required this.userName,
      this.profilePicFileUrl,
      this.coverPicFileUrl,
      required this.name,
      required this.userId,
      required this.college,
      required this.specialization,
      required this.designation,
      this.profilePic,
      this.coverPic,
      this.interests,
      this.links});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userName': userName,
      'name': name,
      'userId': userId,
      'college': college,
      'specialization': specialization,
      'designation': designation,
      'profilePic': profilePic,
      'coverPic': coverPic,
      'interests': interests,
      'links': links,
    };
  }
}

class LinkSend {
  final String? name;
  final String? link;

  LinkSend({required this.name, required this.link});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'link': link,
    };
  }

  factory LinkSend.fromJson(Map<String, dynamic> map) {
    return LinkSend(
      name: map['name'] != null ? map['name'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }
}

class RoomItem {
  final String? _id;
  final int page;

  RoomItem(this._id, {required this.page});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'page': page,
    };
  }

  factory RoomItem.fromJson(Map<String, dynamic> map) {
    return RoomItem(
      map['_id'] != null ? map['_id'] as String : null,
      page: map['page'] as int,
    );
  }
}

class IdObject {
  final String? _id;

  IdObject(this._id);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
    };
  }

  factory IdObject.fromJson(Map<String, dynamic> map) {
    return IdObject(
      map['_id'] != null ? map['_id'] as String : null,
    );
  }
}

class LinkItem {
  final String? _id;
  final String? name;
  final String? link;

  LinkItem(this._id, this.name, this.link);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'name': name,
      'link': link,
    };
  }

  factory LinkItem.fromJson(Map<String, dynamic> map) {
    return LinkItem(
      map['_id'] != null ? map['_id'] as String : null,
      map['name'] != null ? map['name'] as String : null,
      map['link'] != null ? map['link'] as String : null,
    );
  }
}

class MediaLink {
  String secureUrl;
  String publicId;
  MediaLink({
    required this.secureUrl,
    required this.publicId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'secureUrl': secureUrl,
      'publicId': publicId,
    };
  }

  factory MediaLink.fromJson(Map<String, dynamic> map) {
    return MediaLink(
      secureUrl: map['secureUrl'] as String,
      publicId: map['publicId'] as String,
    );
  }
}

class UserAndAdmin {
  final String _id;
  final int page;

  UserAndAdmin(this._id, {required this.page});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'page': page,
    };
  }

  factory UserAndAdmin.fromJson(Map<String, dynamic> map) {
    return UserAndAdmin(
      map['_id'] as String,
      page: map['page'] as int,
    );
  }
}

class FetchMessagesRoom {
  final String? roomId;
  final int? limit;
  final int? page;

  FetchMessagesRoom(
      {required this.roomId, required this.limit, required this.page});

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
