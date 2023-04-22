import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sessions/models/message.model.dart';
import 'package:sessions/repositories/message_repository.dart';
import 'package:sessions/repositories/room_repository.dart';
import 'package:sessions/utils/classes.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  final RoomRepository _roomRepository;
  MessageBloc(this._messageRepository, this._roomRepository)
      : super(MessageInitialState()) {
    on<MessageInitialEvent>((event, emit) {
      emit(MessageInitialState());
    });
    // on<LoadMessagesEvent>((event, emit) async {
    //   emit(MessageLoadingState());

    //   try {
    //     final List<IdObject> currMessageIds =
    //         await _roomRepository.getRoomMessages(
    //             fetchQuery: FetchMessagesRoom(
    //                 roomId: event.roomId,
    //                 page: event.pageCounter,
    //                 limit: event.limit - event.messageIds.length));
    //     for (IdObject id in currMessageIds) {
    //       event.messageIds.add(id);
    //     }
    //     print(event.limit - event.messageIds.length);
    //     if (currMessageIds.isNotEmpty) {
    //       final List<MessageModel> messagesNew =
    //           await _messageRepository.getListedMessages(
    //               messageIds: MessageIdList(ids: currMessageIds));
    //       for (MessageModel message in messagesNew) {
    //         event.messageList.add(message);
    //       }
    //     }

    //     emit(MessageLoadedState(messageList: event.messageList));
    //   } catch (error) {
    //     emit(MessageErrorState(error: error.toString()));
    //   }
    // });
  }
}
