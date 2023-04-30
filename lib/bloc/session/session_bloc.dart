import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sessions/models/session.model.dart';
import 'package:sessions/repositories/session_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepository _sessionRepository;
  SessionBloc(this._sessionRepository) : super(SessionInitialState()) {
    on<SessionInitialEvent>((event, emit) {});
    on<LoadSessionsEvent>((event, emit) async {
      emit(SessionLoadingState());
      try {
        final List<SessionModel> sessions =
            await _sessionRepository.getListedSessions(ids: event.ids);
        emit(SessionLoadedState(sessions: sessions));
      } catch (error) {
        emit(SessionErrorState(error: error.toString()));
      }
    });
  }
}
