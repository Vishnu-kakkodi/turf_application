import 'dart:async';

import 'package:booking_application/views/Games/GameViews/create_games.dart';
import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';

import 'dart:convert';

// Custom SnackBar for better toast messages
void showCustomSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
    ),
  );
}

// API Service Class
class MatchApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  // Fetch single match data
  static Future<Map<String, dynamic>> getMatchData(String matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsinglevolleymatch/$matchId'),
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

  // Update volleyball match (increment/decrement points)
  static Future<void> updateVolleyballScore(
    String matchId,
    String teamId,
    String playerId,
    int points,
    String action, // 'inc' or 'dec'
  ) async {
    try {
      final payload = {
        "teamId": teamId,
        "playerId": playerId,
        "points": points,
        "action": action,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/users/updatevolleymatch/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update volleyball score');
      }
    } catch (e) {
      print('Error updating volleyball score: $e');
      rethrow;
    }
  }

  // Update current set and points per set
  static Future<void> updateCurrentSetAndPoints(
    String matchId,
    int currentSet,
    int pointsPerSet,
  ) async {
    try {
      final payload = {
        "currentSet": currentSet,
        "pointPerSet": pointsPerSet,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/users/updatevolleymatch/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update current set and points');
      }
    } catch (e) {
      print('Error updating current set and points: $e');
      rethrow;
    }
  }

  // Update points per set only
  static Future<void> updatePointsPerSet(
    String matchId,
    int pointsPerSet,
  ) async {
    try {
      print("Point per set: ${pointsPerSet}");
      final payload = {
        "pointsPerSet": pointsPerSet,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/users/updatevolleymatch/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      print("Response status printin: ${response.statusCode}");
      print("Response status printin: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception('Failed to update points per set');
      }
    } catch (e) {
      print('Error updating points per set: $e');
      rethrow;
    }
  }

  // Finish match
  static Future<void> finishMatch(String matchId) async {
    try {
      final payload = {
        "status": "finished",
      };

      final response = await http.put(
        Uri.parse('$baseUrl/users/updatevolleymatch/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to finish match');
      }
    } catch (e) {
      print('Error finishing match: $e');
      rethrow;
    }
  }

  // Cancel match
  static Future<void> cancelMatch(String matchId, String reason) async {
    try {
      final payload = {
        "reason": reason,
        "Status": "cancel",
      };

      final response = await http.put(
        Uri.parse('$baseUrl/users/updatevolleymatch/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel match');
      }
    } catch (e) {
      print('Error canceling match: $e');
      rethrow;
    }
  }
}

// Game Summary Screen for displaying final results
class GameSummaryScreen extends StatelessWidget {
  final String sportName;
  final List<String> participants;
  final Map<String, int> finalScores;
  final Map<String, int> setsWon;
  final Duration gameDuration;
  final String gameResult;
  final String matchId;

  const GameSummaryScreen({
    super.key,
    required this.sportName,
    required this.participants,
    required this.finalScores,
    required this.setsWon,
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
            // Game result header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: gameResult.contains('Draw') ? const Color(0xFFF3F4F6) : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: gameResult.contains('Draw') ? const Color(0xFFE5E7EB) : const Color(0xFF10B981),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    gameResult.contains('Draw') ? Icons.handshake : Icons.emoji_events,
                    size: 48,
                    color: gameResult.contains('Draw') ? const Color(0xFF6B7280) : const Color(0xFF10B981),
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
                    '$sportName Match',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Sets Won Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Final Sets',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...participants.map((participant) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          participant,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF374151),
                          ),
                        ),
                        Text(
                          '${setsWon[participant] ?? 0} sets',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<GameProvider>().updateMatchStatus(matchId, "completed");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GameManagerScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'New Game',
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

// Set Completion Modal
class SetCompletionModal extends StatelessWidget {
  final String setWinner;
  final int setNumber;
  final Function() onContinue;

  const SetCompletionModal({
    super.key,
    required this.setWinner,
    required this.setNumber,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_events,
              size: 64,
              color: const Color(0xFFF59E0B),
            ),
            const SizedBox(height: 16),
            Text(
              'Set $setNumber Completed!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$setWinner won the set',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Continue to Next Set',
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
      ),
    );
  }
}

// Match Completion Modal
class MatchCompletionModal extends StatelessWidget {
  final String matchWinner;
  final Function() onFinish;

  const MatchCompletionModal({
    super.key,
    required this.matchWinner,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_events,
              size: 64,
              color: const Color(0xFF10B981),
            ),
            const SizedBox(height: 16),
            const Text(
              'Match Completed!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$matchWinner Wins the Match!',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onFinish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'View Summary',
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
      ),
    );
  }
}

// Scorecard Screen with Set-Based Scoring for Volleyball
class ScoreVolleyball extends StatefulWidget {
  final String matchId;

  const ScoreVolleyball({
    super.key,
    required this.matchId,
  });

  @override
  State<ScoreVolleyball> createState() => _ScoreVolleyballState();
}

class _ScoreVolleyballState extends State<ScoreVolleyball> {
  late Map<String, int> scores;
  late Map<String, int> setsWon;
  late bool isMatchEnded;
  late String matchWinner;
  late Stopwatch stopwatch;
  late int currentSet;
  late Duration initialElapsedTime;
  late int setsToWin;
  late int pointsPerSet;
  late int winBy;
  late bool allowDeuce;
  late int finalSetPoint;
  late int totalSets;

  // API related fields
  Map<String, dynamic>? matchData;
  bool isLoading = true;
  List<String> teamIds = [];
  List<String> playerIds = [];
  List<String> participants = [];
  String userId = '';
  String sportName = '';

  // Button state management
  bool _isButtonDisabled = false;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _fetchMatchData();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    // Refresh data every 3 seconds to get real-time updates
    _refreshTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && !isMatchEnded) {
        _fetchMatchData();
      }
    });
  }

  Future<void> _fetchMatchData() async {
    try {
      final data = await MatchApiService.getMatchData(widget.matchId);

      if (mounted) {
        setState(() {
          matchData = data;
          if (isLoading) {
            isLoading = false;
            _initializeGameFromApi();
          } else {
            _updateFromMatchData();
            _updateScoresFromMatchData();
          }
        });
      }
    } catch (e) {
      print('Error fetching match data: $e');
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
        });
        showCustomSnackBar(context, 'Error loading match data: $e', isError: true);
      }
    }
  }

  void _initializeGameFromApi() {
    if (matchData == null) return;

    // Extract userId
    if (matchData!['createdBy'] != null) {
      userId = matchData!['createdBy']['_id'] ?? '';
    }

    // Extract sport name
    if (matchData!['categoryId'] != null) {
      sportName = matchData!['categoryId']['name'] ?? 'Match';
    }

    // Extract match settings
    pointsPerSet = matchData!['pointsPerSet'] ?? 21;
    winBy = matchData!['winBy'] ?? 2;
    allowDeuce = matchData!['allowDeuce'] ?? true;
    finalSetPoint = matchData!['finalSetPoints'] ?? 15;
    totalSets = matchData!['totalSets'] ?? 3;

    // Extract team IDs, player IDs, and create participant names
    final isTeamMatch = matchData!['isTeamMatch'] ?? false;
    teamIds = [];
    playerIds = [];
    participants = [];

    if (isTeamMatch) {
      // Team match structure
      if (matchData!['teams'] != null) {
        final teams = matchData!['teams'] as List;
        teamIds = teams.map((team) => team['teamId'].toString()).toList();
        
        for (var team in teams) {
          String teamName = team['teamName'] ?? 'Team ${participants.length + 1}';
          participants.add(teamName);
          
          if (team['players'] != null && (team['players'] as List).isNotEmpty) {
            final firstPlayer = (team['players'] as List)[0];
            playerIds.add(firstPlayer['playerId'].toString());
          } else {
            playerIds.add('');
          }
        }
      }
    } else {
      // Single player match structure
      if (matchData!['teams'] != null) {
        final players = matchData!['teams'] as List;
        
        for (var player in players) {
          String playerName = player['playerName'] ?? 'Player ${participants.length + 1}';
          participants.add(playerName);
          playerIds.add(player['playerId'].toString());
          teamIds.add(''); // Single players don't have team IDs
        }
      }
    }

    // Initialize scores from current set data
    _initializeScoresFromSets();

    // Get setsToWin from scoringTemplate or totalSets
    if (matchData!['scoringTemplate'] != null) {
      setsToWin = matchData!['scoringTemplate']['setsToWin'] ?? 2;
    } else {
      setsToWin = (totalSets / 2).ceil();
    }

    currentSet = matchData!['currentSet'] ?? 1;
    isMatchEnded = matchData!['status'] == 'finished';
    matchWinner = '';

    // Initialize time
    final timeElapsed = matchData!['timeElapsed'] ?? 0;
    initialElapsedTime = Duration(minutes: timeElapsed);

    stopwatch = Stopwatch();
    if (matchData!['status'] == 'live') {
      stopwatch.start();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
      });
    }
  }

  void _initializeScoresFromSets() {
    scores = {for (String participant in participants) participant: 0};
    setsWon = {for (String participant in participants) participant: 0};

    if (matchData!['sets'] != null) {
      final sets = matchData!['sets'] as List;
      final isTeamMatch = matchData!['isTeamMatch'] ?? false;
      
      // Get current set scores
      if (sets.isNotEmpty && matchData!['currentSet'] != null) {
        final currentSetIndex = (matchData!['currentSet'] as int) - 1;
        if (currentSetIndex < sets.length) {
          final currentSetData = sets[currentSetIndex];
          if (currentSetData['score'] != null) {
            final score = currentSetData['score'];
            
            if (isTeamMatch) {
              // Team match score structure
              if (score['teamA'] != null && participants.isNotEmpty) {
                final teamAScore = score['teamA'];
                if (teamAScore is Map) {
                  scores[participants[0]] = teamAScore['score'] ?? 0;
                }
              }
              if (score['teamB'] != null && participants.length > 1) {
                final teamBScore = score['teamB'];
                if (teamBScore is Map) {
                  scores[participants[1]] = teamBScore['score'] ?? 0;
                }
              }
            } else {
              // Single player match score structure
              if (score['playerA'] != null && participants.isNotEmpty) {
                scores[participants[0]] = score['playerA'] ?? 0;
              }
              if (score['playerB'] != null && participants.length > 1) {
                scores[participants[1]] = score['playerB'] ?? 0;
              }
            }
          }
        }
      }

      // Count sets won by each team/player
      for (var set in sets) {
        if (set['winner'] != null) {
          String? winnerName = set['winner'];
          if (winnerName != null && setsWon.containsKey(winnerName)) {
            setsWon[winnerName] = (setsWon[winnerName] ?? 0) + 1;
          }
        }
      }
    }

    // Also check finalScore for sets won
    if (matchData!['finalScore'] != null) {
      final finalScore = matchData!['finalScore'];
      final isTeamMatch = matchData!['isTeamMatch'] ?? false;
      
      if (isTeamMatch) {
        if (finalScore['teamA'] != null && participants.isNotEmpty) {
          final teamAScore = finalScore['teamA'];
          if (teamAScore is Map) {
            setsWon[participants[0]] = teamAScore['score'] ?? 0;
          }
        }
        if (finalScore['teamB'] != null && participants.length > 1) {
          final teamBScore = finalScore['teamB'];
          if (teamBScore is Map) {
            setsWon[participants[1]] = teamBScore['score'] ?? 0;
          }
        }
      } else {
        // Single player final score structure
        if (finalScore['teamA'] != null && participants.isNotEmpty) {
          setsWon[participants[0]] = finalScore['teamA'] ?? 0;
        }
        if (finalScore['teamB'] != null && participants.length > 1) {
          setsWon[participants[1]] = finalScore['teamB'] ?? 0;
        }
      }
    }
  }

  void _updateScoresFromMatchData() {
    if (matchData == null) return;
    _initializeScoresFromSets();
  }

  void _updateFromMatchData() {
    if (matchData == null) return;

    final status = matchData!['status'] ?? 'live';
    isMatchEnded = status == 'finished';

    final timeElapsed = matchData!['timeElapsed'] ?? 0;
    initialElapsedTime = Duration(minutes: timeElapsed);

    currentSet = matchData!['currentSet'] ?? currentSet;
    pointsPerSet = matchData!['pointsPerSet'] ?? pointsPerSet;
  }

  @override
  void dispose() {
    stopwatch.stop();
    _refreshTimer?.cancel();
    super.dispose();
  }

  Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

  // Check if current set can be ended - Volleyball rules
  bool _canEndCurrentSet() {
    if (scores.isEmpty || participants.length < 2) return false;

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;

    // Check if this is the final set
    final isFinalSet = currentSet == totalSets;
    final targetPoints = isFinalSet ? finalSetPoint : pointsPerSet;

    // Check if we need to adjust pointsPerSet due to deuce (20-20 scenario)
    if (allowDeuce && score1 >= (targetPoints - 1) && score2 >= (targetPoints - 1)) {
      // Both players have reached deuce threshold
      final maxScore = score1 > score2 ? score1 : score2;
      
      // If scores are equal, we need to increase pointsPerSet
      if (score1 == score2) {
        return false; // Cannot end set until pointsPerSet is adjusted
      }
      
      // Check if someone has reached the adjusted pointsPerSet with winBy advantage
      if (maxScore >= targetPoints && (score1 - score2).abs() >= winBy) {
        return true;
      }
      
      return false;
    }

    // Normal scenario: check if any team has reached targetPoints with winBy advantage
    if ((score1 >= targetPoints || score2 >= targetPoints) && (score1 - score2).abs() >= winBy) {
      return true;
    }

    return false;
  }

  // Check if we need to adjust pointsPerSet due to deuce
  bool _needToAdjustPointsPerSet() {
    if (scores.isEmpty || participants.length < 2) return false;

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;

    // Check if both players have reached deuce threshold and scores are equal
    // For volleyball, this happens when both teams reach 20-20 (or 14-14 in final set)
    final isFinalSet = currentSet == totalSets;
    final deuceThreshold = isFinalSet ? (finalSetPoint - 1) : (pointsPerSet - 1);

    if (allowDeuce && 
        score1 >= deuceThreshold && 
        score2 >= deuceThreshold && 
        score1 == score2) {
      return true;
    }

    return false;
  }

  // Get target points for current set
  int _getTargetPoints() {
    return currentSet == totalSets ? finalSetPoint : pointsPerSet;
  }

  String _getSetStatusMessage() {
    if (scores.isEmpty || participants.length < 2) return '';

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;
    final diff = (score1 - score2).abs();
    final maxScore = score1 > score2 ? score1 : score2;
    final targetPoints = _getTargetPoints();

    if (_needToAdjustPointsPerSet()) {
      return 'Deuce! Adjust points per set to continue';
    }

    if (maxScore < targetPoints) {
      return 'First to $targetPoints points wins';
    }

    // Deuce scenario
    if (allowDeuce && score1 >= (targetPoints - 1) && score2 >= (targetPoints - 1)) {
      return 'Deuce! Need to win by $winBy points';
    }

    if (diff < winBy) {
      return 'Need to win by $winBy points';
    }

    return 'Set point reached!';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF3B82F6),
          ),
        ),
      );
    }

    if (matchData == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Failed to load match data'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: _buildSetBasedScorecard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$sportName Match',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      participants.join(' vs '),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildActionButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final needAdjustPoints = _needToAdjustPointsPerSet();
    final shouldDisableButtons = _isButtonDisabled || isMatchEnded;
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (needAdjustPoints && !shouldDisableButtons)
          InkWell(
            onTap: _showAdjust,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Adjust Points',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        InkWell(
          onTap: shouldDisableButtons ? null : _showEndGameOptions,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: shouldDisableButtons ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'End Game',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSetBasedScorecard() {
    final canEndSet = _canEndCurrentSet();
    final needAdjustPoints = _needToAdjustPointsPerSet();
    final statusMessage = _getSetStatusMessage();
    final shouldDisableButtons = _isButtonDisabled || isMatchEnded;
    final targetPoints = _getTargetPoints();

    return Column(
      children: [
        const SizedBox(height: 16),
        _buildSetInfo(targetPoints),
        const SizedBox(height: 12),
        // Status message
        if (statusMessage.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: canEndSet ? const Color(0xFFDCFCE7) : 
                     needAdjustPoints ? const Color(0xFFFEF3C7) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: canEndSet ? const Color(0xFF10B981) : 
                       needAdjustPoints ? const Color(0xFFF59E0B) : const Color(0xFFE5E7EB),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  canEndSet ? Icons.check_circle : 
                  needAdjustPoints ? Icons.warning : Icons.info,
                  color: canEndSet ? const Color(0xFF10B981) : 
                         needAdjustPoints ? const Color(0xFFF59E0B) : const Color(0xFF6B7280),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    statusMessage,
                    style: TextStyle(
                      color: canEndSet ? const Color(0xFF065F46) : 
                             needAdjustPoints ? const Color(0xFF92400E) : const Color(0xFF374151),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: participants.map((participant) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _buildSetParticipantCard(participant, shouldDisableButtons),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: canEndSet && !needAdjustPoints ? _endCurrentSet : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canEndSet && !needAdjustPoints ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              needAdjustPoints ? 'Adjust Points to Continue' : 
              canEndSet ? 'End Current Set' : 'Reach Set Point to Continue',
              style: TextStyle(
                color: canEndSet && !needAdjustPoints ? Colors.white : const Color(0xFF9CA3AF),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSetParticipantCard(String participant, bool buttonsDisabled) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          participant,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${scores[participant]}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Points',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            const Text(
              '/',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF9CA3AF),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${setsWon[participant]}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sets Won',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: (buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444)).withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: buttonsDisabled ? null : () => _decrementScore(participant),
                icon: Icon(Icons.remove, color: Colors.white, size: 20),
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: (buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF10B981)).withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: buttonsDisabled ? null : () => _incrementScore(participant),
                icon: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSetInfo(int targetPoints) {
    final isFinalSet = currentSet == totalSets;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_volleyball,
            color: const Color(0xFF3B82F6),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Set $currentSet of $totalSets | First to $targetPoints (Win by $winBy)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          if (isFinalSet)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Final Set',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _incrementScore(String participant) async {
    if (_isButtonDisabled || isMatchEnded) return;

    final participantIndex = participants.indexOf(participant);
    if (participantIndex < 0 || participantIndex >= teamIds.length) return;

    _setButtonDisabled(true);

    try {
      await MatchApiService.updateVolleyballScore(
        widget.matchId,
        teamIds[participantIndex],
        playerIds[participantIndex],
        1,
        'inc',
      );
      
      // Refresh data to get updated scores
      await _fetchMatchData();
      showCustomSnackBar(context, 'Point added to $participant');
    } catch (e) {
      print('Error incrementing score: $e');
      showCustomSnackBar(context, 'Failed to add point: $e', isError: true);
    } finally {
      _setButtonDisabled(false);
    }
  }

  void _decrementScore(String participant) async {
    if (_isButtonDisabled || isMatchEnded || (scores[participant] ?? 0) <= 0) return;

    final participantIndex = participants.indexOf(participant);
    if (participantIndex < 0 || participantIndex >= teamIds.length) return;

    _setButtonDisabled(true);

    try {
      await MatchApiService.updateVolleyballScore(
        widget.matchId,
        teamIds[participantIndex],
        playerIds[participantIndex],
        1,
        'dec',
      );
      
      // Refresh data to get updated scores
      await _fetchMatchData();
      showCustomSnackBar(context, 'Point removed from $participant');
    } catch (e) {
      print('Error decrementing score: $e');
      showCustomSnackBar(context, 'Failed to remove point: $e', isError: true);
    } finally {
      _setButtonDisabled(false);
    }
  }

  void _setButtonDisabled(bool disabled) {
    if (mounted) {
      setState(() {
        _isButtonDisabled = disabled;
      });
    }
  }

void _showAdjust() async {
  try {
    int newPoints = pointsPerSet + 1;
    
    await MatchApiService.updatePointsPerSet(widget.matchId, newPoints);
    
    setState(() {
      pointsPerSet = newPoints;
    });
    
    showCustomSnackBar(context, 'Points per set adjusted to $newPoints');
    
  } catch (e) {
    print('Error adjusting points per set: $e');
    showCustomSnackBar(context, 'Failed to adjust points: $e', isError: true);
  }
}

  void _endCurrentSet() async {
    if (!_canEndCurrentSet() || _needToAdjustPointsPerSet()) {
      showCustomSnackBar(context, 'Cannot end set yet. Adjust points or reach set point first.', isError: true);
      return;
    }

    // Determine set winner
    String setWinner = '';
    int highestScore = 0;

    scores.forEach((participant, score) {
      if (score > highestScore) {
        highestScore = score;
        setWinner = participant;
      }
    });

    final nextSet = currentSet + 1;
    final isLastSet = nextSet > totalSets;

    try {
      if (isLastSet) {
        // Final set - finish the match
        await MatchApiService.finishMatch(widget.matchId);
        
        setState(() {
          if (setWinner.isNotEmpty) {
            setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
            matchWinner = setWinner;
          }
          isMatchEnded = true;
        });

        stopwatch.stop();
        
        // Show match completion modal
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return MatchCompletionModal(
              matchWinner: matchWinner,
              onFinish: _navigateToSummary,
            );
          },
        );
      } else {
        // Regular set - move to next set
        await MatchApiService.updateCurrentSetAndPoints(widget.matchId, nextSet, pointsPerSet);
        
        setState(() {
          if (setWinner.isNotEmpty) {
            setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
          }
          
          // Reset scores for next set and reset pointsPerSet to original
          scores = {for (String participant in participants) participant: 0};
          currentSet = nextSet;
          pointsPerSet = matchData!['pointsPerSet'] ?? 21; // Reset to original
        });

        // Show set completion modal
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SetCompletionModal(
              setWinner: setWinner,
              setNumber: currentSet - 1,
              onContinue: () {
                Navigator.of(context).pop();
                showCustomSnackBar(context, 'Set ${currentSet-1} completed! $setWinner won the set.');
              },
            );
          },
        );
      }
    } catch (e) {
      print('Error ending current set: $e');
      showCustomSnackBar(context, 'Failed to end set: $e', isError: true);
    }
  }

  void _navigateToSummary() {
    final gameResult = isMatchEnded
        ? (matchWinner.isNotEmpty ? '$matchWinner Wins!' : 'Draw!')
        : 'Game Ended';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameSummaryScreen(
          sportName: sportName,
          participants: participants,
          finalScores: scores,
          setsWon: setsWon,
          gameDuration: totalElapsedTime,
          gameResult: gameResult,
          matchId: widget.matchId,
        ),
      ),
    );
  }

  void _showEndGameOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'End Game Options',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose how you want to end the game:',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showCancelGameDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Cancel Game',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showCompleteGameDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Complete Game',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Back',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCancelGameDialog() {
    final TextEditingController reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Cancel Game',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please provide a reason for canceling the game:',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  hintText: 'Enter reason...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Back',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (reasonController.text.trim().isEmpty) {
                  showCustomSnackBar(context, 'Please enter a reason', isError: true);
                  return;
                }

                Navigator.of(context).pop();
                
                try {
                  await MatchApiService.cancelMatch(widget.matchId, reasonController.text.trim());
                  showCustomSnackBar(context, 'Game cancelled successfully');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GameManagerScreen()),
                  );
                } catch (e) {
                  print('Error canceling game: $e');
                  showCustomSnackBar(context, 'Failed to cancel game: $e', isError: true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Cancel Game',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCompleteGameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Complete Game',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'Are you sure you want to mark this game as completed?',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _endGame('');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Complete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _endGame(String winner) async {
    setState(() {
      isMatchEnded = true;
      matchWinner = winner;
    });

    stopwatch.stop();

    try {
      await MatchApiService.finishMatch(widget.matchId);
      _navigateToSummary();
    } catch (e) {
      print('Error finishing match: $e');
      showCustomSnackBar(context, 'Failed to finish match: $e', isError: true);
    }
  }
}