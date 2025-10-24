import 'package:booking_application/views/Cricket/views/live_match_screen.dart';
import 'package:flutter/material.dart';

class InningsBreakScreen extends StatelessWidget {
  final String matchId;

  const InningsBreakScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  void _startNextInnings(BuildContext context) {
    // Simply navigate back to LiveMatchScreen
    // It will reload and show second innings
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LiveMatchScreen(matchId: matchId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sports_cricket,
                  size: 100,
                  color: Color(0xFF00BCD4),
                ),
                const SizedBox(height: 48),
                const Text(
                  'Innings Break',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Time for a quick break!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF8A9BA8),
                  ),
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () => _startNextInnings(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Start Next Innings',
                    style: TextStyle(
                      fontSize: 20,
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
}