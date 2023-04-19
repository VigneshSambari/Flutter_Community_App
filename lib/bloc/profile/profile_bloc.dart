import 'package:equatable/equatable.dart';
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
    on<LoadProfileEvent>((event, emit) async {
      print("Inside load profile");
      emit(ProfileLoadingState());
      try {
        final ProfileModel? profile =
            await _profileRepository.loadProfile(userId: event.userId);
        if (profile != null) {
          print("Inside exist profile");
          emit(ProfileCreatedState(profile: profile));
        } else {
          print("Inside not exist profile");
          emit(ProfileNotExistState());
        }
      } catch (error) {
        //emit(ProfileLoadingState());
        emit(ProfileFetchFailedState());
      }
    });
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    if (state is ProfileCreatedState) {
      return state.toJson();
    }
    return null;
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return ProfileCreatedState.fromJson(json);
    }
    return null;
  }
}
