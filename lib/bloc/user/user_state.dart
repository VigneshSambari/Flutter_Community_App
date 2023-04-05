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
