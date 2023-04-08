import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:sessions/models/profile.model.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitialState()) {
    on<ProfileIdealEvent>((event, emit) {
      emit(ProfileInitialState());
    });
    on<CreateProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final ProfileModel profile =
            await _profileRepository.create(httpData: event.profileData);
        emit(ProfileCreatedState(profile: profile));
      } catch (error) {
        emit(ProfileErrorState(error: error.toString()));
      }
    });
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    if (state is ProfileCreatedState) {
      print(state.toJson());
      return state.toJson();
    }
    return null;
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      print(json);
      return ProfileCreatedState.fromJson(json);
    }
    return null;
  }
}
