import 'package:booking_application/views/Cricket/cricket_models.dart';
import 'package:flutter/material.dart';
import 'package:booking_application/views/Cricket/services/api_service.dart';
import 'package:booking_application/views/Cricket/live_match_screen.dart';

class InningsBreakSelectionScreen extends StatelessWidget {
  final String matchId;
  final List<Map<String, String>> battingTeamPlayers; // Team B for 2nd innings
  final List<Map<String, String>> bowlingTeamPlayers; // Team A for 2nd innings

  const InningsBreakSelectionScreen({
    Key? key,
    required this.matchId,
    required this.battingTeamPlayers,
    required this.bowlingTeamPlayers,
  }) : super(key: key);

  Future<void> _startInningsFlow(BuildContext context) async {
    // Step 1: Select opening batsmen
    final batsmenResult = await CricketModals.showOpeningBatsmenModal(
      context,
      availableBatsmen: battingTeamPlayers,
    );
    
    if (batsmenResult == null) {
      // User cancelled - go back
      Navigator.of(context).pop();
      return;
    }
    
    // Step 2: Select opening bowler
    final bowlerResult = await CricketModals.showBowlerSelectionModal(
      context,
      availablePlayers: bowlingTeamPlayers,
    );
    
    if (bowlerResult == null) {
      // User cancelled - go back
      Navigator.of(context).pop();
      return;
    }
    
    // Step 3: Start second innings with all details
    await _startSecondInnings(
      context,
      strikerId: batsmenResult['strikerId']!,
      nonStrikerId: batsmenResult['nonStrikerId']!,
      bowlerId: bowlerResult['id']!,
    );
  }

  Future<void> _startSecondInnings(
    BuildContext context, {
    required String strikerId,
    required String nonStrikerId,
    required String bowlerId,
  }) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xFF1976D2)),
        ),
      );

      Map<String, dynamic> payload = {
        "innings": 2,
        "inningStatus": "second innings",
        "runs": 0,
        "wickets": 0,
        "ballUpdate": false,
        "striker": strikerId,
        "nonStriker": nonStrikerId,
        "bowler": bowlerId,
      };
      
      await ApiService.updateMatch(matchId, payload);
      
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Navigate to LiveMatchScreen with replacement
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LiveMatchScreen(matchId: matchId),
        ),
      );
      
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start second innings: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Allow back navigation - will exit to previous screen
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E1E),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2A3441),
          title: const Text('Innings Break'),
          centerTitle: true,
        ),
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
                    'First innings completed',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8A9BA8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ready to start the second innings?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8A9BA8),
                    ),
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () => _startInningsFlow(context),
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
                      'Start Second Innings',
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
      ),
    );
  }
}