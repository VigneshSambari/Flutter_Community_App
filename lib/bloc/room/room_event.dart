// ignore_for_file: prefer_const_constructors_in_immutables

part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

class RoomInitialEvent extends RoomEvent {
  @override
  List<Object?> get props => [];
}

class LoadRoomsEvent extends RoomEvent {
  final String type;

  LoadRoomsEvent({required this.type});

  @override
  List<Object?> get props => [];
}
