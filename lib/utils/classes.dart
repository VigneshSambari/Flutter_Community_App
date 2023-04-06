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
