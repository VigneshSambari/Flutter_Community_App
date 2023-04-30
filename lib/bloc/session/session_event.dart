part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class SessionInitialEvent extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class LoadSessionsEvent extends SessionEvent {
  final IdList ids;

  LoadSessionsEvent({required this.ids});
  @override
  List<Object?> get props => [];
}
