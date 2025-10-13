import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? socket;
  static Function(Map<String, dynamic>)? onMatchUpdate;

  static void connect(String matchId) {
    socket = IO.io('http://31.97.206.144:3081', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      print('Socket connected');
      socket!.emit('join-match', matchId);
    });

    socket!.on('live-match-update', (data) {
      print('Live match update received: $data');
      if (onMatchUpdate != null) {
        onMatchUpdate!(data as Map<String, dynamic>);
      }
    });

    socket!.onDisconnect((_) => print('Socket disconnected'));
    socket!.onError((error) => print('Socket error: $error'));
  }

  static void disconnect() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }
}