part of 'message_bloc.dart';

abstract class MessageState extends Equatable {}

class MessageInitialState extends MessageState {
  @override
  List<Object?> get props => [];
}

class MessageLoadingState extends MessageState {
  @override
  List<Object?> get props => [];
}

class MessageLoadedState extends MessageState {
  final List<MessageModel> messageList;

  MessageLoadedState({required this.messageList});
  @override
  List<Object?> get props => [];
}

class MessageErrorState extends MessageState {
  final String error;

  MessageErrorState({required this.error});
  @override
  List<Object?> get props => [];
}
