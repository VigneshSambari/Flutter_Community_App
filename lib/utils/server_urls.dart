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
  static Pair comment = Pair(url: "$blogEndPoint/comment", requestType: true);
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

  static Pair fetchProfile(String userId) {
    return Pair(url: "$profileEndPoint/:$userId", requestType: false);
  }

  static Pair deleteProfile(String userId) {
    return Pair(url: "$profileEndPoint/delete/:$userId", requestType: false);
  }

  static Pair setOnline(String userId) {
    return Pair(url: "$profileEndPoint/setonline/:$userId", requestType: false);
  }

  static Pair setOffline(String userId) {
    return Pair(
        url: "$profileEndPoint/setoffline/:$userId", requestType: false);
  }

  static Pair fetchPublicProfile(String userId) {
    return Pair(
        url: "$profileEndPoint/publicprofile/:$userId", requestType: false);
  }
}
