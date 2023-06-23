// ignore_for_file: prefer_const_constructors_in_immutables

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserIdealEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UserSignUpEvent extends UserEvent {
  final UserSignUpSend userData;
  UserSignUpEvent({required this.userData});
  @override
  List<Object?> get props => [];
}

class UserSignInEvent extends UserEvent {
  final UserSignInSend userData;
  UserSignInEvent({required this.userData});
  @override
  List<Object?> get props => [];
}
