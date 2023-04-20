// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:sessions/models/room.model.dart';
import 'package:sessions/repositories/room_repository.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends HydratedBloc<RoomEvent, RoomState> {
  final RoomRepository _roomRepository;

  RoomBloc(
    this._roomRepository,
  ) : super(RoomInitialState()) {
    on<RoomInitialEvent>((event, emit) {
      emit(RoomLoadingState());
    });
    on<LoadRoomsEvent>((event, emit) async {
      emit(RoomLoadingState());

      try {
        final List<RoomModel> rooms =
            await _roomRepository.getRoomsOfType(roomType: event.type);
        emit(RoomLoadedState(rooms: rooms));
      } catch (error) {
        emit(RoomErrorState(error: error.toString()));
      }
    });
  }

  @override
  RoomState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return RoomLoadedState.fromJson(json);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(RoomState state) {
    if (state is RoomLoadedState) {
      return state.toJson();
    }
    return null;
  }
}
