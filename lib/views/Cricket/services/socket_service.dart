// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   static IO.Socket? socket;
//   static Function(Map<String, dynamic>)? onMatchUpdate;

//   static void connect(String matchId) {
//     socket = IO.io('http://31.97.206.144:3081', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket!.connect();

//     socket!.onConnect((_) {
//       print('Socket connected');
//       socket!.emit('join-match', matchId);
//     });

//     socket!.on('live-match-update', (data) {
//       print('Live match update received: $data');
//       if (onMatchUpdate != null) {
//         onMatchUpdate!(data as Map<String, dynamic>);
//       }
//     });

//     socket!.onDisconnect((_) => print('Socket disconnected'));
//     socket!.onError((error) => print('Socket error: $error'));
//   }

//   static void disconnect() {
//     socket?.disconnect();
//     socket?.dispose();
//     socket = null;
//   }
// }










import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? socket;

  // Callback for match updates
  static Function(Map<String, dynamic>)? onMatchUpdate;

  // Callback for join confirmation
  static Function(Map<String, dynamic>)? onJoinConfirmation;

  static void connect(String matchId) {
    socket = IO.io('http://31.97.206.144:3081', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    // On successful connection
    socket!.onConnect((_) {
      print('Socket connected: ${socket!.id}');

      // Emit join-match event
      socket!.emit('join-match', matchId);
    });

    // Listen for live match updates
    socket!.on('live-match-update', (data) {
      print('Live match update received: $data');
      if (onMatchUpdate != null && data is Map<String, dynamic>) {
        onMatchUpdate!(data);
      }
    });

    // Listen for join confirmation
    socket!.on('join-confirmation', (data) {
      print('Join confirmation received: $data');
      if (onJoinConfirmation != null && data is Map<String, dynamic>) {
        onJoinConfirmation!(data);
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
