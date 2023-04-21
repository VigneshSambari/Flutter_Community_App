import 'package:sessions/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final SocketService _singleton = SocketService._internal();
  Socket? _socket;

  factory SocketService({Map<String, dynamic>? query}) {
    if (_singleton._socket == null) {
      // Define the connection options and parameters
      final options = OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders(query!) // optional
          .build();

      // Connect to the server with the options and parameters
      _singleton._socket = io(socketServerUrl, options);
      _singleton._socket!.connect();

      // Listen for connection events
      _singleton._socket!.onConnect((_) {
        print('Connected to socket server!');
      });
    }

    return _singleton;
  }

  void test({required String message}) {
    _socket!.emit('test', message);
  }

  void setOnline() {
    _socket!.emit('setOnline');
  }

  void disconnect() {
    _socket!.emit('disconnect');
  }

  void sendRooMessage() {
    const message = {
      "sentBy": "63df5afd61cf376cb318c141",
      "sentTo": "63e104f6e291f1dc9ef7a5d3",
      "content": "Message!",
      "type": "text"
    };

    const roomId = "63e104f6e291f1dc9ef7a5d3";
    _socket!.emit('sendRoomMessage', {'message': message, 'roomId': roomId});
  }

  void fetchRoomMessages() {
    print("inside1");
    const roomId = "63e104f6e291f1dc9ef7a5d3";
    _socket!.emit('fetchRoomMessages', {'roomId': roomId});
    _socket!.on(
      'fetchedRoomMessages',
      (messages) => {
        print(messages),
      },
    );
  }

  Socket get socket => _socket!;

  SocketService._internal();
}
