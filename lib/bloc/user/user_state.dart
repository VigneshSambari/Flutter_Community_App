part of 'user_bloc.dart';

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSignedUpState extends UserState {
  final UserModel user;
  final String message = "Successfully registered User!";

  UserSignedUpState({required this.user});

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user': user.toJson(),
    };
  }

  factory UserSignedUpState.fromJson(Map<String, dynamic> map) {
    return UserSignedUpState(
      user: UserModel.fromJson(map['user'] as Map<String, dynamic>),
    );
  }
}

class UserSignedInState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({required this.error});
  @override
  List<Object?> get props => [];
}
