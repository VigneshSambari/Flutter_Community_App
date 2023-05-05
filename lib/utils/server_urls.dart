// ignore_for_file: unnecessary_string_interpolations

import 'package:sessions/constants.dart';
import 'package:sessions/utils/classes.dart';

class UserUrls {
  static String userEndPoint = "$httpServerUrl/auth";
  static Pair signIn = Pair(url: "$userEndPoint/login", requestType: true);
  static Pair signUp = Pair(url: "$userEndPoint/register", requestType: true);
  static Pair sendVerifivationEmail =
      Pair(url: "$userEndPoint/verifyemail", requestType: true);
  static Pair emailVerified =
      Pair(url: "$userEndPoint/verified", requestType: false);
  static Pair changePassword =
      Pair(url: "$userEndPoint/changepassword", requestType: true);
}

class BlogUrls {
  static String blogEndPoint = "$httpServerUrl/blog";
  static Pair getAllBlogs = Pair(url: "$blogEndPoint/all", requestType: false);
  static Pair getOwnBlogs = Pair(url: "$blogEndPoint/own", requestType: false);
  static Pair create = Pair(url: "$blogEndPoint/create", requestType: true);
  static Pair delete = Pair(url: "$blogEndPoint/delete", requestType: true);
  static Pair update = Pair(url: "$blogEndPoint/update", requestType: true);
  static Pair pagedBlogs =
      Pair(url: "$blogEndPoint/pagedblogs", requestType: true);
  static Pair comment = Pair(url: "$blogEndPoint/comment", requestType: true);
  static Pair mediaUpload =
      Pair(url: "$blogEndPoint/uploadmedia", requestType: true);
  static Pair deletecommentorreply =
      Pair(url: "$blogEndPoint/deletecommentorreply", requestType: true);
  static Pair addreply = Pair(url: "$blogEndPoint/addreply", requestType: true);

  static Pair likeOrUnlike(String id, String choice, String commentorpost) {
    return Pair(
        url: "$blogEndPoint/:$commentorpost/:$id/:$choice", requestType: false);
  }
}

class ProfileUrls {
  static String profileEndPoint = "$httpServerUrl/profile";
  static Pair mediaUpload =
      Pair(url: "$profileEndPoint/uploadprofile", requestType: true);
  static Pair create = Pair(url: "$profileEndPoint/create", requestType: true);
  static Pair update = Pair(url: "$profileEndPoint/update", requestType: true);
  static Pair checkIfFriend =
      Pair(url: "$profileEndPoint/checkfriend", requestType: true);
  static Pair otherProfile =
      Pair(url: "$profileEndPoint/otherprofile", requestType: true);
  static Pair sendRequest =
      Pair(url: "$profileEndPoint/sendrequest", requestType: true);
  static Pair acceptRequest =
      Pair(url: "$profileEndPoint/acceptrequest", requestType: true);
  static Pair disconnect =
      Pair(url: "$profileEndPoint/disconnect", requestType: true);
  static Pair fetchPublicProfiles =
      Pair(url: "$profileEndPoint/publicprofiles", requestType: true);

  static Pair fetchProfile({required String userId}) {
    return Pair(url: "$profileEndPoint/:$userId", requestType: false);
  }

  static Pair deleteProfile({required String userId}) {
    return Pair(url: "$profileEndPoint/delete/:$userId", requestType: false);
  }

  static Pair setOnline({required String userId}) {
    return Pair(url: "$profileEndPoint/setonline/:$userId", requestType: false);
  }

  static Pair setOffline({required String userId}) {
    return Pair(
        url: "$profileEndPoint/setoffline/:$userId", requestType: false);
  }
}

class MediaUploadUrls {
  static String mediaEndPoint = "$httpServerUrl/media";
  static Pair uploadMedia =
      Pair(url: "$mediaEndPoint/upload", requestType: true);
  static Pair deleteMedia =
      Pair(url: "$mediaEndPoint/delete", requestType: true);
}

class RoomUrls {
  static String roomEndPoint = "$httpServerUrl/room";
  static Pair getAllRooms = Pair(url: "$roomEndPoint", requestType: false);
  static Pair create = Pair(url: "$roomEndPoint/create", requestType: true);
  static Pair queryRooms = Pair(url: "$roomEndPoint/query", requestType: true);
  static Pair join = Pair(url: "$roomEndPoint/join", requestType: true);
  static Pair leave = Pair(url: "$roomEndPoint/leave", requestType: true);
  static Pair checkIfMember =
      Pair(url: "$roomEndPoint/checkmember", requestType: false);
  static Pair sendMessage =
      Pair(url: "$roomEndPoint/sendmessage", requestType: true);
  static Pair deleteMessage =
      Pair(url: "$roomEndPoint/deletemessage", requestType: true);
  static Pair fetchMessages =
      Pair(url: "$roomEndPoint/fetchmessages", requestType: true);
  static Pair fetchListedRooms =
      Pair(url: "$roomEndPoint/fetchlisted", requestType: true);
  static Pair addUserToGroup =
      Pair(url: "$roomEndPoint/addtogroup", requestType: true);
  static Pair removeUser =
      Pair(url: "$roomEndPoint/removeusergroup", requestType: true);

  static Pair getRoomsOfType({required String type}) {
    return Pair(url: "$roomEndPoint/getroomstype/$type", requestType: false);
  }

  static Pair joinViaLink({required String roomId}) {
    return Pair(url: "$roomEndPoint/joinvialink/:$roomId", requestType: false);
  }
}

class MessageUrls {
  static String messageEndPoint = "$httpServerUrl/message";
  static Pair fetchListedMessages =
      Pair(url: "$messageEndPoint/fetchlistedmessages", requestType: true);
  static Pair replyMessage =
      Pair(url: "$messageEndPoint/reply", requestType: true);
  static Pair deleteReply =
      Pair(url: "$messageEndPoint/deletereply", requestType: true);
}

class SessionUrls {
  static String sessionEndPoint = "$httpServerUrl/session";
  static Pair getAll = Pair(url: "$sessionEndPoint/getall", requestType: false);
  static Pair create = Pair(url: "$sessionEndPoint/create", requestType: true);
  static Pair exit = Pair(url: "$sessionEndPoint/exit", requestType: true);
  static Pair update = Pair(url: "$sessionEndPoint/update", requestType: true);
  static Pair fetchListed =
      Pair(url: "$sessionEndPoint/fetchlisted", requestType: true);
}
