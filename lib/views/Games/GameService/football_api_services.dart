import 'package:booking_application/views/Games/GameViews/create_games.dart';
import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// API Service Class
class MatchApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  static Future<Map<String, dynamic>> getMatchData(String matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsinglegamematch/$matchId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['match'];
      } else {
        throw Exception('Failed to load match data');
      }
    } catch (e) {
      print('Error fetching match data: $e');
      rethrow;
    }
  }

  static Future<void> updateScore(
    String matchId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/update-score/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print("Update score response: ${response.statusCode}");

      if (response.statusCode != 200) {
        throw Exception('Failed to update score');
      }
    } catch (e) {
      print('Error updating score: $e');
      rethrow;
    }
  }

  static Future<void> makeSubstitution(String matchId, Map<String, dynamic> payload) async {
  final response = await http.put(
    Uri.parse('$baseUrl/users/update-score/$matchId'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(payload),
  );

  print("Response status code: ${response.statusCode}");
    print("Response status code: ${response.body}");

  
  if (response.statusCode != 200) {
    throw Exception('Failed to make substitution');
  }
}
}

// Socket Service Class
class SocketService {
  static IO.Socket? socket;
  static const String socketUrl = 'http://31.97.206.144:3081';

  static void initSocket() {
    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket?.on('connect', (_) {
      print('Socket connected: ${socket?.id}');
    });

    socket?.on('disconnect', (_) {
      print('Socket disconnected');
    });
  }

  static void joinMatch(String matchId) {
    socket?.emit('join-match', matchId);
    print('Joined match room: $matchId');
  }

  static void listenToMatchUpdate(Function(Map<String, dynamic>) callback) {
    socket?.on('match:update', (data) {
      print('Match update received: $data');
      callback(data);
    });
  }

  static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
    socket?.on('liveScoreUpdate', (data) {
      print('Live score update received: $data');
      callback(data);
    });
  }

  static void dispose() {
    socket?.disconnect();
    socket?.dispose();
  }
}
