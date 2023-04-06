// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables, override_on_non_overriding_member

class UserModel {
  final String? _id;
  final String? email;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;
  UserModel(this._id,
      {this.email, this.password, this.createdAt, this.updatedAt, this.token});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'email': email,
      'password': password,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
      'token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      map['_id'] != null ? map['_id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  @override
  List<Object?> get props =>
      [_id, email, password, createdAt, updatedAt, token];
}
