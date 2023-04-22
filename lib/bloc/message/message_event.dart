// ignore_for_file: prefer_const_constructors_in_immutables

part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class MessageInitialEvent extends MessageEvent {
  @override
  List<Object?> get props => [];
}

// class LoadMessagesEvent extends MessageEvent {
//   final int pageCounter;
//   final String? roomId;
//   final int limit;
//   final List<IdObject> messageIds;
//   final List<MessageModel> messageList;
//   LoadMessagesEvent({
//     required this.pageCounter,
//     required this.roomId,
//     required this.messageIds,
//     required this.limit,
//     required this.messageList,
//   });

//   @override
//   List<Object?> get props => [];
// }
