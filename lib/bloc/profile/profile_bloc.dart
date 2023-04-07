import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/repositories/profile_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
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
}
