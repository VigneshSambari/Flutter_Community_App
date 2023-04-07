// ignore_for_file: prefer_const_constructors_in_immutables

part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileIdealEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class CreateProfileEvent extends ProfileEvent {
  final CreateProfileSend profileData;
  CreateProfileEvent({required this.profileData});
  @override
  List<Object?> get props => [];
}
