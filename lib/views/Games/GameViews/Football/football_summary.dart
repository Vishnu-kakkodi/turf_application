// Game Summary Screen
import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GameSummaryScreen extends StatelessWidget {
  final String matchName;
  final Map<String, int> finalScores;
  final Duration gameDuration;
  final String gameResult;
  final String matchId;

  const GameSummaryScreen({
    super.key,
    required this.matchName,
    required this.finalScores,
    required this.gameDuration,
    required this.gameResult,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Game Summary',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF374151)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: gameResult.contains('Draw')
                    ? const Color(0xFFF3F4F6)
                    : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: gameResult.contains('Draw')
                      ? const Color(0xFFE5E7EB)
                      : const Color(0xFF10B981),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    gameResult.contains('Draw')
                        ? Icons.handshake
                        : Icons.emoji_events,
                    size: 48,
                    color: gameResult.contains('Draw')
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    gameResult,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    matchName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<GameProvider>()
                          .updateMatchStatus(matchId, "completed");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameManagerScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Back to Games',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
