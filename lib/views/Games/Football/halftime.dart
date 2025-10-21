import 'package:booking_application/views/Games/Football/halftime.dart';
import 'package:booking_application/views/Games/GameService/football_api_services.dart';
import 'package:booking_application/views/Games/create_games.dart';
import 'package:booking_application/views/Games/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/game_selection.dart';
import 'package:booking_application/views/Games/games_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Half-Time Break Screen
class HalfTimeScreen extends StatelessWidget {
  final String matchId;
  final String matchName;
  final Map<String, int> teamScores;
  final List<Map<String, dynamic>> teams;

  const HalfTimeScreen({
    super.key,
    required this.matchId,
    required this.matchName,
    required this.teamScores,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sports_soccer,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'HALF TIME',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  matchName,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF9CA3AF),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildScoreDisplay(),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () => _startSecondHalf(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Second Half',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreDisplay() {
    final team1Id = teams.isNotEmpty ? teams[0]['teamId'] as String : '';
    final team2Id = teams.length > 1 ? teams[1]['teamId'] as String : '';
    final score1 = teamScores[team1Id] ?? 0;
    final score2 = teamScores[team2Id] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                _getTeamName(0),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$score1',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '-',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                _getTeamName(1),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$score2',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getTeamName(int index) {
    if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
    final team = teams[index];
    return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
  }

  Future<void> _startSecondHalf(BuildContext context) async {
    try {
      final firstTeam = teams.isNotEmpty ? teams[0] : null;
      final firstPlayer = firstTeam != null &&
              firstTeam['players'] != null &&
              (firstTeam['players'] as List).isNotEmpty
          ? firstTeam['players'][0]
          : null;

      if (firstTeam != null && firstPlayer != null) {
        final payload = {
          // "teamId": firstTeam['teamId'],
          // "playerId": firstPlayer['playerId'],
          // "goals": 0,
          "currentStatus": "second-half"
        };

        print("Payload: $payload");

        await MatchApiService.updateScore(matchId, payload);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorecardScreen(matchId: matchId),
        ),
      );
    } catch (e) {
      print('Error starting second half: $e');
    }
  }
}