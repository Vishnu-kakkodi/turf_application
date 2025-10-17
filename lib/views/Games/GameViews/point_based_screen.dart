import 'package:booking_application/views/Games/create_games.dart';
import 'package:booking_application/views/Games/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/games_view_screen.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// API Service Class
class MatchApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  // Fetch single match data
  static Future<Map<String, dynamic>> getMatchData(String matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsinglegamematch/$matchId'),
      );
print("Response data: ${response.statusCode}");


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

  // Update match status
  static Future<void> updateMatchStatus(
    String userId,
    String matchId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/footballstatus/$userId/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update match status');
      }
    } catch (e) {
      print('Error updating match status: $e');
      rethrow;
    }
  }

  // Update points
  static Future<void> updatePoints(
    String userId,
    String matchId,
    String teamId,
    int points,
  ) async {
    try {
      final payload = {
        "pointUpdate": {
          "teamId": teamId,
          "points": points,
        }
      };

      await updateMatchStatus(userId, matchId, payload);
    } catch (e) {
      print('Error updating points: $e');
      rethrow;
    }
  }

  // Finish match
  static Future<void> finishMatch(
    String userId,
    String matchId,
    Map<String, int> finalScores,
  ) async {
    try {
      final payload = {
        "status": "finished",
        "finalScores": finalScores,
      };

      await updateMatchStatus(userId, matchId, payload);
    } catch (e) {
      print('Error finishing match: $e');
      rethrow;
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

  static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
    socket?.on('liveScoreUpdate', (data) {
      print('Live score update received: $data');
      callback(data);
    });
  }

  static void listenToSingleMatchData(Function(Map<String, dynamic>) callback) {
    socket?.on('singleMatchData', (data) {
      print('Single match data received: $data');
      callback(data);
    });
  }

  static void dispose() {
    socket?.disconnect();
    socket?.dispose();
  }
}

// Game Summary Screen
class GameSummaryScreen extends StatelessWidget {
  final String sportName;
  final List<String> participants;
  final Map<String, int> finalScores;
  final Duration gameDuration;
  final String gameResult;
  final String matchId;

  const GameSummaryScreen({
    super.key,
    required this.sportName,
    required this.participants,
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
            // Display final scores
            ...participants.map((participant) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      participant,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      '${finalScores[participant] ?? 0} pts',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
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

// Scorecard Screen - Point-Based Only
class PointBasedScreen extends StatefulWidget {
  final String matchId;

  const PointBasedScreen({
    super.key,
    required this.matchId,
  });

  @override
  State<PointBasedScreen> createState() => _PointBasedScreenState();
}

class _PointBasedScreenState extends State<PointBasedScreen> {
  late Map<String, int> scores;
  late bool isMatchEnded;
  late String matchWinner;
  late Stopwatch stopwatch;
  late Duration initialElapsedTime;

  // API related fields
  Map<String, dynamic>? matchData;
  bool isLoading = true;
  List<String> teamIds = [];
  List<String> participants = [];
  String userId = '';
  String sportName = '';
  int targetPoints = 21; // Default target points to win

  @override
  void initState() {
    super.initState();
    _initializeSocket();
    _fetchMatchData();
  }

  void _initializeSocket() {
    SocketService.initSocket();
    SocketService.joinMatch(widget.matchId);

    SocketService.listenToLiveScoreUpdate((data) {
      if (mounted) {
        setState(() {
          if (data['teamScores'] != null) {
            _updateScoresFromSocket(data['teamScores']);
          }
        });
      }
    });

    SocketService.listenToSingleMatchData((data) {
      if (mounted) {
        setState(() {
          matchData = data['match'];
          _updateFromMatchData();
        });
      }
    });
  }

  Future<void> _fetchMatchData() async {
    try {
      final data = await MatchApiService.getMatchData(widget.matchId);

      if (mounted) {
        setState(() {
          matchData = data;
          isLoading = false;
          _initializeGameFromApi();
        });
      }
    } catch (e) {
      print('Error fetching match data: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading match data: $e')),
        );
      }
    }
  }

  void _initializeGameFromApi() {
    if (matchData == null) return;

    // Extract userId from createdBy
    if (matchData!['createdBy'] != null) {
      userId = matchData!['createdBy']['_id'] ?? '';
    }

    // Extract sport name from categoryId
    if (matchData!['categoryId'] != null) {
      sportName = matchData!['categoryId']['name'] ?? 'Match';
    }

    // Extract team IDs and create participant names
    if (matchData!['teams'] != null) {
      final teams = matchData!['teams'] as List;
      teamIds = teams.map((team) => team['teamId'].toString()).toList();
      participants = List.generate(
        teams.length,
        (index) => 'Team ${String.fromCharCode(65 + index)}'
      );
    }

    // Initialize scores to 0
    scores = {for (String participant in participants) participant: 0};

    // Load existing scores if available
    if (matchData!['scoreCard'] != null) {
      final scoreCard = matchData!['scoreCard'] as List;
      for (var entry in scoreCard) {
        final teamId = entry['teamId'];
        final points = entry['points'] ?? 0;
        final index = teamIds.indexOf(teamId);
        if (index >= 0 && index < participants.length) {
          scores[participants[index]] = points;
        }
      }
    }

    isMatchEnded = matchData!['status'] == 'finished';
    matchWinner = '';

    // Initialize time
    final totalDuration = matchData!['totalDuration'] ?? 90;
    initialElapsedTime = Duration(minutes: totalDuration);

    stopwatch = Stopwatch();
    if (matchData!['status'] == 'live') {
      stopwatch.start();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
      });
    }
  }

  void _updateScoresFromSocket(Map<String, dynamic> teamScores) {
    teamScores.forEach((teamId, score) {
      final index = teamIds.indexOf(teamId);
      if (index >= 0 && index < participants.length) {
        scores[participants[index]] = score;
      }
    });
  }

  void _updateFromMatchData() {
    if (matchData == null) return;

    // Update scores from match data
    if (matchData!['scoreCard'] != null) {
      final scoreCard = matchData!['scoreCard'] as List;
      for (var entry in scoreCard) {
        final teamId = entry['teamId'];
        final points = entry['points'] ?? 0;
        final index = teamIds.indexOf(teamId);
        if (index >= 0 && index < participants.length) {
          scores[participants[index]] = points;
        }
      }
    }

    // Update match status
    isMatchEnded = matchData!['status'] == 'finished';
  }

  @override
  void dispose() {
    stopwatch.stop();
    SocketService.dispose();
    super.dispose();
  }

  Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

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
                child: _buildPointBasedScorecard(),
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        InkWell(
          onTap: _showNewGameDialog,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Text(
              'New Game',
              style: TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: _showEndGameDialog,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
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

  Widget _buildPointBasedScorecard() {
    return Column(
      children: [
        _buildTimer(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: participants.length > 2
              ? Column(
                  children: participants.asMap().entries.map((entry) {
                    final index = entry.key;
                    final participant = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                      child: _buildParticipantCard(participant, index),
                    );
                  }).toList(),
                )
              : Row(
                  children: participants.asMap().entries.map((entry) {
                    final index = entry.key;
                    final participant = entry.value;
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
                        child: _buildParticipantCard(participant, index),
                      ),
                    );
                  }).toList(),
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildParticipantCard(String participant, int participantIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          participant,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Points',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${scores[participant] ?? 0}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: () => _awardPoint(participant, participantIndex),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Award Point',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimer() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final elapsed = totalElapsedTime;
        final minutes = elapsed.inMinutes;
        final seconds = elapsed.inSeconds % 60;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Match Time',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (stopwatch.isRunning) {
                          stopwatch.stop();
                        } else {
                          stopwatch.start();
                        }
                      });
                    },
                    icon: Icon(
                      stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        stopwatch.reset();
                        initialElapsedTime = Duration.zero;
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _awardPoint(String participant, int participantIndex) async {
    setState(() {
      scores[participant] = (scores[participant] ?? 0) + 1;
    });

    // Update API
    if (participantIndex < teamIds.length) {
      try {
        await MatchApiService.updatePoints(
          userId,
          widget.matchId,
          teamIds[participantIndex],
          scores[participant] ?? 0,
        );
      } catch (e) {
        print('Error updating points: $e');
      }
    }

    // Check win condition
    _checkWinCondition();
  }

  void _checkWinCondition() {
    scores.forEach((participant, score) {
      if (score >= targetPoints) {
        _endGame(participant);
      }
    });
  }

  void _endGame(String winner) async {
    setState(() {
      isMatchEnded = true;
      matchWinner = winner;
    });

    stopwatch.stop();

    // Update API to finish match
    try {
      final finalScoresMap = <String, int>{};
      for (var i = 0; i < participants.length && i < teamIds.length; i++) {
        finalScoresMap[teamIds[i]] = scores[participants[i]] ?? 0;
      }

      await MatchApiService.finishMatch(
        userId,
        widget.matchId,
        finalScoresMap,
      );
    } catch (e) {
      print('Error finishing match: $e');
    }

    _navigateToSummary();
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
          gameDuration: totalElapsedTime,
          gameResult: gameResult,
          matchId: widget.matchId,
        ),
      ),
    );
  }

  void _showEndGameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'End Game',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'Are you sure you want to end this game? This action cannot be undone.',
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
                
                // Determine winner
                String winner = '';
                int highestScore = 0;
                scores.forEach((participant, score) {
                  if (score > highestScore) {
                    highestScore = score;
                    winner = participant;
                  }
                });
                
                _endGame(winner);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'End Game',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNewGameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'New Game',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'Are you sure you want to start a new game? Current progress will be lost.',
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
                context.read<GameProvider>().updateMatchStatus(widget.matchId, "completed");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ViewMatchScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'New Game',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}