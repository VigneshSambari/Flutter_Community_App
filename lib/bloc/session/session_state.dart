part of 'session_bloc.dart';

abstract class SessionState extends Equatable {}

class SessionInitialState extends SessionState {
  @override
  List<Object?> get props => [];
}

class SessionLoadingState extends SessionState {
  @override
  List<Object?> get props => [];
}

class SessionLoadedState extends SessionState {
  final List<SessionModel> sessions;

  SessionLoadedState({required this.sessions});
  @override
  List<Object?> get props => [];
}

class SessionErrorState extends SessionState {
  final String error;

  SessionErrorState({required this.error});
  @override
  List<Object?> get props => [];
}
