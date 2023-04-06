import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sessions/models/user.model.dart';
import 'package:sessions/repositories/user_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitialState()) {
    on<UserIdealEvent>((event, emit) {
      emit(UserInitialState());
    });
    on<UserSignUpEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final UserModel user = await _userRepository.signUp(
          httpData: event.userData,
        );
        print(user.toJson());
        emit(UserSignedUpState(user: user));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });
    on<UserSignInEvent>((event, emit) {});
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    print("contains check");
    if (json.isNotEmpty) {
      print("contains");
      return UserSignedUpState.fromJson(json);
    }
    print("contains not");
    return null;
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    print("trying to save");
    print(state.toString());
    if (state is UserSignedUpState) {
      print(state.toJson());
      print("saved");
      return state.toJson();
    }
    print("not saved");
    return null;
  }
}
