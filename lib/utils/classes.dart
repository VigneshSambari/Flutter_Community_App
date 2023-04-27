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

class PairPopMenu {
  final int value;
  final String option;

  PairPopMenu({required this.value, required this.option});
}

class CreateBlogSend {
  final String title;
  final String body;
  final String postedBy;
  final List<String>? media;
  final List<MediaLink>? coverMedia;

  CreateBlogSend({
    required this.title,
    required this.body,
    required this.postedBy,
    this.media,
    this.coverMedia,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'postedBy': postedBy,
      'media': media,
      'coverMedia': coverMedia,
    };
  }

  factory CreateBlogSend.fromMap(Map<String, dynamic> map) {
    List<String> newMedia = [];
    List<MediaLink> newCoverMedia = [];
    for (var item in map['media']) {
      newMedia.add(item);
    }
    for (var item in map['coverMedia']) {
      newCoverMedia.add(MediaLink.fromJson(item));
    }
    return CreateBlogSend(
      title: map['title'] as String,
      body: map['body'] as String,
      postedBy: map['postedBy'] as String,
      media: newMedia,
      coverMedia: newCoverMedia,
    );
  }
}

class CreateMessageSend {
  final String sentBy;
  final String sentTo;
  final String type;
  final String content;
  final String roomId;
  final String messageId;

  CreateMessageSend({
    required this.sentBy,
    required this.sentTo,
    required this.type,
    required this.content,
    required this.roomId,
    required this.messageId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sentBy': sentBy,
      'sentTo': sentTo,
      'type': type,
      'content': content,
      'roomId': roomId,
      'messageId': messageId,
    };
  }

  factory CreateMessageSend.fromJson(Map<String, dynamic> map) {
    return CreateMessageSend(
      sentBy: map['sentBy'] as String,
      sentTo: map['sentTo'] as String,
      type: map['type'] as String,
      content: map['content'] as String,
      roomId: map['roomId'] as String,
      messageId: map['messageId'] as String,
    );
  }
}

class CreateRoomSend {
  final String name;
  final String type;
  final String description;
  final String createdBy;
  final String? media;
  MediaLink? coverPic;
  String folderName;

  CreateRoomSend(
      {required this.name,
      required this.description,
      required this.createdBy,
      required this.type,
      this.media,
      this.coverPic,
      this.folderName = "global"});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'description': description,
      'createdBy': createdBy,
      'media': media,
      'coverPic': coverPic?.toJson(),
      'folderName': folderName,
    };
  }

  factory CreateRoomSend.fromJson(Map<String, dynamic> map) {
    return CreateRoomSend(
      folderName: map['folderName'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      description: map['description'] as String,
      createdBy: map['createdBy'] as String,
      media: map['media'] != null ? map['media'] as String : null,
      coverPic: map['coverPic'] != null
          ? MediaLink.fromJson(map['coverPic'] as Map<String, dynamic>)
          : null,
    );
  }
}
