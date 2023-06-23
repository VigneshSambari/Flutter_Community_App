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
        emit(UserSignedUpState(user: user));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });
    on<UserSignInEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final UserModel user = await _userRepository.signIn(
          httpData: event.userData,
        );
        emit(UserSignedInState(user: user));
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return UserSignedInState.fromJson(json);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserSignedInState) {
      return state.toJson();
    }
    return null;
  }
}
