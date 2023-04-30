// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sessions/models/room.model.dart';
import 'package:sessions/repositories/room_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository _roomRepository;

  RoomBloc(this._roomRepository) : super(RoomInitialState()) {
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
    on<LoadListedRoomsEvent>((event, emit) async {
      emit(RoomLoadingState());

      try {
        final List<RoomModel> rooms =
            await _roomRepository.getListedRooms(ids: event.ids);
        emit(RoomLoadedState(rooms: rooms));
      } catch (error) {
        emit(RoomErrorState(error: error.toString()));
      }
    });
  }
}
