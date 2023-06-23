// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileCreatedState extends ProfileState {
  final ProfileModel profile;
  final String message = "Succesfully created Profile!";

  ProfileCreatedState({required this.profile});
  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'profile': profile.toJson(),
    };
  }

  factory ProfileCreatedState.fromJson(Map<String, dynamic> map) {
    return ProfileCreatedState(
      profile: ProfileModel.fromJson(map['profile'] as Map<String, dynamic>),
    );
  }
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

class ProfileNotExistState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileFetchFailedState extends ProfileState {
  @override
  List<Object?> get props => [];
}
