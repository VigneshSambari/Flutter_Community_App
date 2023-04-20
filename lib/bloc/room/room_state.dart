// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'room_bloc.dart';

abstract class RoomState extends Equatable {}

class RoomInitialState extends RoomState {
  @override
  List<Object?> get props => [];
}

class RoomLoadingState extends RoomState {
  @override
  List<Object?> get props => [];
}

class RoomLoadedState extends RoomState {
  final List<RoomModel> rooms;

  RoomLoadedState({required this.rooms});

  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rooms': rooms.map((x) => x.toJson()).toList(),
    };
  }

  factory RoomLoadedState.fromJson(Map<String, dynamic> map) {
    return RoomLoadedState(
      rooms: List<RoomModel>.from(
        (map['rooms'] as List<int>).map<RoomModel>(
          (x) => RoomModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class RoomErrorState extends RoomState {
  final String error;

  RoomErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
