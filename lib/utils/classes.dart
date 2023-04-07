import 'dart:convert';

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
  final String? profilePic;
  final String? coverPic;
  final List<String>? interests;
  final List<Map<String, dynamic>>? links;

  CreateProfileSend(
      {required this.userName,
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

  LinkSend(this.name, this.link);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'link': link,
    };
  }

  factory LinkSend.fromJson(Map<String, dynamic> map) {
    return LinkSend(
      map['name'] != null ? map['name'] as String : null,
      map['link'] != null ? map['link'] as String : null,
    );
  }
}

class RoomItem {
  final String? _id;
  final DateTime? fetchAfter;

  RoomItem(this._id, this.fetchAfter);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'fetchAfter': fetchAfter?.millisecondsSinceEpoch,
    };
  }

  factory RoomItem.fromJson(Map<String, dynamic> map) {
    return RoomItem(
      map['_id'] != null ? map['_id'] as String : null,
      map['fetchAfter'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['fetchAfter'] as int)
          : null,
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
