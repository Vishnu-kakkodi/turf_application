import 'package:booking_application/views/Games/Football/football_summary.dart';
import 'package:booking_application/views/Games/Football/halftime.dart';
import 'package:booking_application/views/Games/GameService/football_api_services.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/games_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

// Football Scorecard Screen
class ScorecardScreen extends StatefulWidget {
  final String matchId;

  const ScorecardScreen({
    super.key,
    required this.matchId,
  });

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  Map<String, dynamic>? matchData;
  bool isLoading = true;

  String matchName = '';
  String currentStatus = 'live';
  List<Map<String, dynamic>> teams = [];
  Map<String, int> teamScores = {};
  List<Map<String, dynamic>> scoreCard = [];

  DateTime? kickOffTime;
  int totalDuration = 15;
  int halfTimeDuration = 2;
  bool extraTimeAllowed = false;
  int extraTimeDuration = 0;
  bool extraTimeAllowedForHalfTime = false;
  int extraTimeDurationForHalfTime = 0;
  bool extraTimeAllowedForFullTime = false;
  int extraTimeDurationForFullTime = 0;

  bool isInHalfTimeExtraTime = false;
  bool isInFullTimeExtraTime = false;
  int extraTimeMinutes = 0;
  int addedHalfTimeExtra = 0;
  int addedFullTimeExtra = 0;

  @override
  void initState() {
    super.initState();
    _initSetup();
  }

  Future<void> _initSetup() async {
    await _initializeSocket();
    await _fetchMatchData();
    _checkMatchStatus();
    _startTimer();
  }

  void _checkMatchStatus() {
    if (currentStatus == 'break') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HalfTimeScreen(
              matchId: widget.matchId,
              matchName: matchName,
              teamScores: teamScores,
              teams: teams,
            ),
          ),
        );
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (kickOffTime != null && mounted) {
        setState(() {
          _elapsedTime = _calculateElapsedTime();
          _checkForAutomaticBreaks();
        });
      }
    });
  }

  void _checkForAutomaticBreaks() {
    final minutes = _elapsedTime.inMinutes;
    final halfTime = totalDuration ~/ 2;

    if (currentStatus == 'live' &&
        minutes >= halfTime &&
        !extraTimeAllowedForHalfTime &&
        !isInHalfTimeExtraTime) {
      _showHalfTimeModal();
    }

    if (currentStatus == 'live' &&
        isInHalfTimeExtraTime &&
        minutes >= (halfTime + extraTimeDurationForHalfTime)) {
      _showHalfTimeModal();
    }

    if (currentStatus == 'second-half' &&
        minutes >= totalDuration &&
        !extraTimeAllowedForFullTime &&
        !isInFullTimeExtraTime) {
      _showFullTimeModal();
    }

    if (currentStatus == 'second-half' &&
        isInFullTimeExtraTime &&
        minutes >= (totalDuration + extraTimeDurationForFullTime)) {
      _showFullTimeModal();
    }
  }

  // Duration _calculateElapsedTime() {
  //   if (kickOffTime == null) return Duration.zero;

  //   try {
  //     final now = DateTime.now();
  //     final kickoff = kickOffTime!.isUtc
  //         ? DateTime(
  //             kickOffTime!.year,
  //             kickOffTime!.month,
  //             kickOffTime!.day,
  //             kickOffTime!.hour,
  //             kickOffTime!.minute,
  //             kickOffTime!.second,
  //             kickOffTime!.millisecond,
  //             kickOffTime!.microsecond,
  //           )
  //         : kickOffTime!;

  //     final difference = now.difference(kickoff);
  //     return difference.isNegative ? Duration.zero : difference;
  //   } catch (e) {
  //     print('Error calculating elapsed time: $e');
  //     return Duration.zero;
  //   }
  // }

  Duration _calculateElapsedTime() {
    if (kickOffTime == null) return Duration.zero;

    try {
      final now = DateTime.now();
      final kickoff = kickOffTime!.isUtc
          ? DateTime(
              kickOffTime!.year,
              kickOffTime!.month,
              kickOffTime!.day,
              kickOffTime!.hour,
              kickOffTime!.minute,
              kickOffTime!.second,
              kickOffTime!.millisecond,
              kickOffTime!.microsecond,
            )
          : kickOffTime!;

      Duration difference = now.difference(kickoff);

      // Subtract half-time if second-half
      if (currentStatus == 'second-half') {
        dynamic halfDuration = Duration(minutes: halfTimeDuration);
        difference -= halfDuration;
        if (difference.isNegative) difference = Duration.zero; // safety
      }

      return difference;
    } catch (e) {
      print('Error calculating elapsed time: $e');
      return Duration.zero;
    }
  }

  Future<void> _initializeSocket() async {
    SocketService.initSocket();
    SocketService.joinMatch(widget.matchId);

    SocketService.listenToMatchUpdate((data) {
      if (mounted) {
        setState(() {
          _updateFromSocketData(data);
        });
      }
    });

    SocketService.listenToLiveScoreUpdate((data) {
      if (mounted) {
        setState(() {
          if (data['teamScores'] != null) {
            final scores = data['teamScores'] as Map<String, dynamic>;
            scores.forEach((teamId, score) {
              teamScores[teamId] = score is int ? score : 0;
            });
          }
        });
      }
    });
  }

  void _updateFromSocketData(Map<String, dynamic> data) {
    if (data['name'] != null) {
      matchName = data['name'];
    }

    if (data['status'] != null || data['currentStatus'] != null) {
      currentStatus = data['currentStatus'] ?? data['status'] ?? 'live';
      _checkMatchStatus();
    }

    if (data['startKickTime'] != null) {
      try {
        kickOffTime = DateTime.parse(data['startKickTime']);
      } catch (e) {
        print('Error parsing startKickTime: $e');
      }
    }

    if (data['liveGoalScores'] != null) {
      final liveScores = data['liveGoalScores'] as List;
      for (var score in liveScores) {
        final teamId = score['teamId'] as String;
        final goals = score['teamGoals'] as int;
        teamScores[teamId] = goals;
      }
    }

    if (data['scoreCard'] != null) {
      scoreCard = List<Map<String, dynamic>>.from(data['scoreCard']);
    }

    if (data['teams'] != null) {
      teams = List<Map<String, dynamic>>.from(data['teams']);
    }

    if (data['extraTimeAllowedForHalfTime'] != null) {
      extraTimeAllowedForHalfTime = data['extraTimeAllowedForHalfTime'];
    }
    if (data['extraTimeDurationForHalfTime'] != null) {
      extraTimeDurationForHalfTime = data['extraTimeDurationForHalfTime'];
    }
    if (data['extraTimeAllowedForFullTime'] != null) {
      extraTimeAllowedForFullTime = data['extraTimeAllowedForFullTime'];
    }
    if (data['extraTimeDurationForFullTime'] != null) {
      extraTimeDurationForFullTime = data['extraTimeDurationForFullTime'];
    }
  }

  Future<void> _fetchMatchData() async {
    try {
      final data = await MatchApiService.getMatchData(widget.matchId);

      if (mounted) {
        setState(() {
          matchData = data;
          isLoading = false;
          _initializeFromMatchData();
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

  void _initializeFromMatchData() {
    if (matchData == null) return;

    matchName = matchData!['name'] ?? 'Football Match';
    currentStatus =
        matchData!['currentStatus'] ?? matchData!['status'] ?? 'live';
    totalDuration = matchData!['totalDuration'] ?? 15;
    halfTimeDuration = matchData!['halfTimeDuration'] ?? 2;
    extraTimeAllowed = matchData!['extraTimeAllowed'] ?? false;
    extraTimeDuration = matchData!['extraTimeDuration'] ?? 0;
    extraTimeAllowedForHalfTime =
        matchData!['extraTimeAllowedForHalfTime'] ?? false;
    extraTimeDurationForHalfTime =
        matchData!['extraTimeDurationForHalfTime'] ?? 0;
    extraTimeAllowedForFullTime =
        matchData!['extraTimeAllowedForFullTime'] ?? false;
    extraTimeDurationForFullTime =
        matchData!['extraTimeDurationForFullTime'] ?? 0;

    if (matchData!['startKickTime'] != null) {
      try {
        kickOffTime = DateTime.parse(matchData!['startKickTime']);
        _elapsedTime = _calculateElapsedTime();
      } catch (e) {
        print('Error parsing startKickTime: $e');
      }
    }

    if (matchData!['teams'] != null) {
      teams = List<Map<String, dynamic>>.from(matchData!['teams']);
    }

    if (matchData!['liveGoalScores'] != null) {
      final liveScores = matchData!['liveGoalScores'] as List;
      for (var score in liveScores) {
        final teamId = score['teamId'] as String;
        final goals = score['teamGoals'] as int? ?? 0;
        teamScores[teamId] = goals;
      }
    }

    if (matchData!['scoreCard'] != null) {
      scoreCard = List<Map<String, dynamic>>.from(matchData!['scoreCard']);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    SocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF3B82F6),
          ),
        ),
      );
    }

    if (matchData == null || teams.isEmpty) {
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
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to load match data'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
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
                child: _buildFootballScorecard(),
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
                      matchName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Football Match',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final minutes = _elapsedTime.inMinutes;
    final halfTime = totalDuration ~/ 2;
    print("Current half time: $halfTime");
    print("Current half Minutes: $minutes");
    print("Current half Status: $currentStatus");

    bool canAddExtraTime = false;
    if (currentStatus == 'half-time' && minutes >= halfTime) {
      canAddExtraTime = true;
    } else if (currentStatus == 'second-half' && minutes >= totalDuration) {
      canAddExtraTime = true;
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        InkWell(
          onTap: _showCardSelectionDialog,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.style, size: 16, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  'Cards',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: canAddExtraTime ? _showExtraTimeDialog : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: canAddExtraTime
                  ? const Color(0xFFFBBF24)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: canAddExtraTime
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFFE5E7EB),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer,
                  size: 16,
                  color:
                      canAddExtraTime ? Colors.white : const Color(0xFF9CA3AF),
                ),
                const SizedBox(width: 4),
                Text(
                  'Extra Time',
                  style: TextStyle(
                    color: canAddExtraTime
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: _showStopDialog,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Text(
              'Stop',
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

  Widget _buildFootballScorecard() {
    return Column(
      children: [
        _buildTimer(),
        const SizedBox(height: 16),
        _buildActionButtons(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: teams.length == 2
              ? Row(
                  children: [
                    Expanded(child: _buildTeamCard(0)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTeamCard(1)),
                  ],
                )
              : Column(
                  children: List.generate(
                    teams.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildTeamCard(index),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 24),
        _buildGoalScorecard(),
        const SizedBox(height: 24),
        _buildCardsSection(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTeamCard(int teamIndex) {
    if (teamIndex >= teams.length) return const SizedBox.shrink();

    final team = teams[teamIndex];
    final teamId = team['teamId'] as String;
    final teamName = _getTeamName(teamIndex);
    final goals = teamScores[teamId] ?? 0;
    final players = team['players'] as List? ?? [];

    return Container(
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
      child: Column(
        children: [
          Text(
            teamName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${players.length} Players',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$goals',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Goals',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () =>
                      _showPlayerSelectionModal(teamId, players, 'dec'),
                  icon: const Icon(Icons.remove, color: Colors.white, size: 20),
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () =>
                      _showPlayerSelectionModal(teamId, players, 'inc'),
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalScorecard() {
    if (scoreCard.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.sports_soccer, color: Color(0xFF10B981), size: 24),
              SizedBox(width: 8),
              Text(
                'Goal Scorers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...scoreCard.asMap().entries.map((entry) {
            final teamIndex = entry.key;
            final teamScore = entry.value;
            final teamId = teamScore['teamId'] as String;
            final players = teamScore['players'] as List? ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (teamIndex > 0) const Divider(height: 24),
                Text(
                  _getTeamName(teamIndex),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 8),
                if (players.where((p) => (p['goals'] ?? 0) > 0).isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'No goals yet',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else
                  ...players.where((p) => (p['goals'] ?? 0) > 0).map((player) {
                    final playerName = player['playerName'] ?? 'Unknown';
                    final goals = player['goals'] ?? 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.sports_soccer,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              playerName,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF1F2937),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$goals ${goals == 1 ? 'goal' : 'goals'}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCardsSection() {
    if (scoreCard.isEmpty) return const SizedBox.shrink();

    // Check if any player has cards
    bool hasCards = false;
    for (var teamScore in scoreCard) {
      final players = teamScore['players'] as List? ?? [];
      for (var player in players) {
        final warningCards = player['warningCards'];
        if (warningCards != null) {
          final yellow = warningCards['yellow'] ?? 0;
          final red = warningCards['red'] ?? 0;
          if (yellow > 0 || red > 0) {
            hasCards = true;
            break;
          }
        }
      }
      if (hasCards) break;
    }

    if (!hasCards) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.style, color: Color(0xFFF59E0B), size: 24),
              SizedBox(width: 8),
              Text(
                'Warning Cards',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...scoreCard.asMap().entries.map((entry) {
            final teamIndex = entry.key;
            final teamScore = entry.value;
            final players = teamScore['players'] as List? ?? [];

            // Filter players with cards
            final playersWithCards = players.where((p) {
              final warningCards = p['warningCards'];
              if (warningCards != null) {
                final yellow = warningCards['yellow'] ?? 0;
                final red = warningCards['red'] ?? 0;
                return yellow > 0 || red > 0;
              }
              return false;
            }).toList();

            if (playersWithCards.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (teamIndex > 0) const Divider(height: 24),
                Text(
                  _getTeamName(teamIndex),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 8),
                ...playersWithCards.map((player) {
                  final playerName = player['playerName'] ?? 'Unknown';
                  final warningCards = player['warningCards'];
                  final yellow = warningCards['yellow'] ?? 0;
                  final red = warningCards['red'] ?? 0;
                  final isOut = player['isOut'] ?? false;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isOut
                                ? const Color(0xFFEF4444)
                                : const Color(0xFFF59E0B),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            isOut ? Icons.person_off : Icons.warning,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            playerName,
                            style: TextStyle(
                              fontSize: 15,
                              color: isOut
                                  ? const Color(0xFF6B7280)
                                  : const Color(0xFF1F2937),
                              fontWeight: FontWeight.w500,
                              decoration: isOut
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (yellow > 0) ...[
                              Container(
                                width: 20,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '$yellow',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                            if (red > 0) ...[
                              Container(
                                width: 20,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '$red',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  String _getTeamName(int index) {
    if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
    final team = teams[index];
    return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
  }

  Widget _buildTimer() {
    dynamic minutes;
    dynamic seconds;
    if (currentStatus == 'half-time' || currentStatus == 'break') {
      minutes = _elapsedTime.inMinutes;
      seconds = _elapsedTime.inSeconds % 60;
    } else if (currentStatus == 'second-half') {
      minutes = _elapsedTime.inMinutes;
      seconds = _elapsedTime.inSeconds % 60;
    }
    final halfTime = totalDuration ~/ 2;

    bool isExtraTime = false;
    Color timerColor = const Color(0xFF1F2937);
    int displayExtraTime = 0;

    if (currentStatus == 'half-time' &&
        minutes >= halfTime &&
        extraTimeAllowedForHalfTime) {
      isExtraTime = true;
      isInHalfTimeExtraTime = true;
      timerColor = const Color(0xFF3B82F6);
      displayExtraTime = minutes - halfTime;
    } else if (currentStatus == 'second-half' &&
        minutes >= totalDuration &&
        extraTimeAllowedForFullTime) {
      isExtraTime = true;
      isInFullTimeExtraTime = true;
      timerColor = const Color(0xFF3B82F6);
      displayExtraTime = minutes - totalDuration;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: timerColor,
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
              Text(
                isExtraTime ? 'Extra Time' : 'Match Time',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isExtraTime && displayExtraTime > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+$displayExtraTime',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                currentStatus == 'second-half' ? '2ND HALF' : '1ST HALF',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCardSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Issue Warning Card',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                title: const Text('Yellow Card'),
                subtitle: const Text('Warning'),
                onTap: () {
                  Navigator.pop(context);
                  _showTeamSelectionForCard('yellow');
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                title: const Text('Red Card'),
                subtitle: const Text('Ejection'),
                onTap: () {
                  Navigator.pop(context);
                  _showTeamSelectionForCard('red');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTeamSelectionForCard(String cardType) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Team',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];
                    final teamName = _getTeamName(index);
                    final teamId = team['teamId'] as String;
                    final players = team['players'] as List? ?? [];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF3B82F6),
                        child: Text(
                          teamName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        teamName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text('${players.length} players'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                        _showPlayerSelectionForCard(teamId, players, cardType);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlayerSelectionForCard(
      String teamId, List players, String cardType) {
    if (players.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No players available')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Player for ${cardType == 'yellow' ? 'Yellow' : 'Red'} Card',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    final playerName = player['playerName'] ?? 'Unknown';
                    final playerId = player['playerId'];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: cardType == 'yellow'
                            ? const Color(0xFFFBBF24)
                            : const Color(0xFFEF4444),
                        child: Text(
                          playerName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        playerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                        _issueCard(teamId, playerId, cardType);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _issueCard(
      String teamId, String playerId, String cardType) async {
    try {
      final payload = {
        "teamId": teamId,
        "playerId": playerId,
        "warningCards": {
          "yellow": cardType == 'yellow' ? 1 : 0,
          "red": cardType == 'red' ? 1 : 0,
        }
      };

      await MatchApiService.updateScore(widget.matchId, payload);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${cardType == 'yellow' ? 'Yellow' : 'Red'} card issued successfully'),
            backgroundColor: cardType == 'yellow'
                ? const Color(0xFFFBBF24)
                : const Color(0xFFEF4444),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error issuing card: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error issuing card: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  void _showExtraTimeDialog() {
    final minutes = _elapsedTime.inMinutes;
    final halfTime = totalDuration ~/ 2;

    bool isHalfTime = currentStatus == 'half-time' && minutes >= halfTime;
    bool isFullTime =
        currentStatus == 'second-half' && minutes >= totalDuration;

    TextEditingController halfTimeController = TextEditingController();
    TextEditingController fullTimeController = TextEditingController();

    int addedHalfTimeExtra = 0;
    int addedFullTimeExtra = 0;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        bool halfTimeExtraEnabled = extraTimeAllowedForHalfTime;
        bool fullTimeExtraEnabled = extraTimeAllowedForFullTime;
        int halfTimeExtraDuration = extraTimeDurationForHalfTime;
        int fullTimeExtraDuration = extraTimeDurationForFullTime;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Extra Time Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isHalfTime) ...[
                      const Text(
                        'Half-Time Extra Time',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151)),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        title: const Text('Enable Half-Time Extra Time'),
                        subtitle:
                            const Text('Add extra minutes for first half'),
                        value: halfTimeExtraEnabled,
                        activeColor: const Color(0xFF10B981),
                        onChanged: (value) {
                          setDialogState(() {
                            halfTimeExtraEnabled = value;
                            if (!value) halfTimeExtraDuration = 0;
                          });
                        },
                      ),
                      if (halfTimeExtraEnabled)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Pre-configured Duration: $halfTimeExtraDuration minutes'),
                              Slider(
                                value: halfTimeExtraDuration.toDouble(),
                                min: 1,
                                max: 15,
                                divisions: 14,
                                activeColor: const Color(0xFF10B981),
                                label: '$halfTimeExtraDuration min',
                                onChanged: (value) {
                                  setDialogState(() =>
                                      halfTimeExtraDuration = value.toInt());
                                },
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Add Extra Time (Manual Input):',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              TextField(
                                controller: halfTimeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Enter minutes',
                                ),
                                onChanged: (value) {
                                  setDialogState(() {
                                    addedHalfTimeExtra =
                                        int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                    if (isFullTime) ...[
                      const Text(
                        'Full-Time Extra Time',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151)),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        title: const Text('Enable Full-Time Extra Time'),
                        subtitle:
                            const Text('Add extra minutes for second half'),
                        value: fullTimeExtraEnabled,
                        activeColor: const Color(0xFF10B981),
                        onChanged: (value) {
                          setDialogState(() {
                            fullTimeExtraEnabled = value;
                            if (!value) fullTimeExtraDuration = 0;
                          });
                        },
                      ),
                      if (fullTimeExtraEnabled)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Pre-configured Duration: $fullTimeExtraDuration minutes'),
                              Slider(
                                value: fullTimeExtraDuration.toDouble(),
                                min: 1,
                                max: 15,
                                divisions: 14,
                                activeColor: const Color(0xFF10B981),
                                label: '$fullTimeExtraDuration min',
                                onChanged: (value) {
                                  setDialogState(() =>
                                      fullTimeExtraDuration = value.toInt());
                                },
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Add Extra Time (Manual Input):',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              TextField(
                                controller: fullTimeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Enter minutes',
                                ),
                                onChanged: (value) {
                                  setDialogState(() {
                                    addedFullTimeExtra =
                                        int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    if (isHalfTime) {
                      await _updateExtraTimeSettings(
                        halfTimeEnabled: halfTimeExtraEnabled,
                        halfTimeDuration:
                            halfTimeExtraDuration + addedHalfTimeExtra,
                      );
                    }

                    if (isFullTime) {
                      await _updateExtraTimeSettings(
                        fullTimeEnabled: fullTimeExtraEnabled,
                        fullTimeDuration:
                            fullTimeExtraDuration + addedFullTimeExtra,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateExtraTimeSettings({
    bool? halfTimeEnabled,
    int? halfTimeDuration,
    bool? fullTimeEnabled,
    int? fullTimeDuration,
  }) async {
    try {
      final firstTeam = teams.isNotEmpty ? teams[0] : null;
      final firstPlayer = firstTeam != null &&
              firstTeam['players'] != null &&
              (firstTeam['players'] as List).isNotEmpty
          ? firstTeam['players'][0]
          : null;

      if (firstTeam != null && firstPlayer != null) {
        Map<String, dynamic> payload = {
          "teamId": firstTeam['teamId'],
          "playerId": firstPlayer['playerId'],
          "goals": 0,
        };

        if (halfTimeEnabled != null) {
          payload["extraTimeAllowedForHalfTime"] = halfTimeEnabled;
          setState(() {
            extraTimeAllowedForHalfTime = halfTimeEnabled;
          });
        }
        if (halfTimeDuration != null) {
          payload["extraTimeDurationForHalfTime"] = halfTimeDuration;
          setState(() {
            extraTimeDurationForHalfTime = halfTimeDuration;
          });
        }

        if (fullTimeEnabled != null) {
          payload["extraTimeAllowedForFullTime"] = fullTimeEnabled;
          setState(() {
            extraTimeAllowedForFullTime = fullTimeEnabled;
          });
        }
        if (fullTimeDuration != null) {
          payload["extraTimeDurationForFullTime"] = fullTimeDuration;
          setState(() {
            extraTimeDurationForFullTime = fullTimeDuration;
          });
        }

        await MatchApiService.updateScore(widget.matchId, payload);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Extra time settings updated successfully'),
              backgroundColor: Color(0xFF10B981),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('Error updating extra time settings: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating settings: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  void _showPlayerSelectionModal(String teamId, List players, String action) {
    if (players.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No players available')),
      );
      return;
    }

    // Filter out players who are marked as "isOut" (sent off)
    List activePlayers = players.where((player) {
      // Check in scoreCard for isOut status
      for (var teamScore in scoreCard) {
        if (teamScore['teamId'] == teamId) {
          final scorecardPlayers = teamScore['players'] as List? ?? [];
          for (var scorecardPlayer in scorecardPlayers) {
            if (scorecardPlayer['playerId'] == player['playerId']) {
              return !(scorecardPlayer['isOut'] ?? false);
            }
          }
        }
      }
      return true;
    }).toList();

    if (activePlayers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No active players available')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    action == 'inc' ? 'Select Goal Scorer' : 'Remove Goal From',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: activePlayers.length,
                  itemBuilder: (context, index) {
                    final player = activePlayers[index];
                    final playerName = player['playerName'] ?? 'Unknown';
                    final playerId = player['playerId'];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF10B981),
                        child: Text(
                          playerName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        playerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                        if (action == 'inc') {
                          _incrementScore(teamId, playerId);
                        } else {
                          _decrementScore(teamId, playerId);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHalfTimeModal() {
    _timer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Half-Time Reached',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'The first half has ended. Proceed to half-time break?',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _startTimer();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _updateMatchStatus('break');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFullTimeModal() {
    _timer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Full-Time Reached',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'The match has ended. Would you like to end the game?',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _startTimer();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _endGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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

  Future<void> _updateMatchStatus(String status) async {
    try {
      final firstTeam = teams.isNotEmpty ? teams[0] : null;
      final firstPlayer = firstTeam != null &&
              firstTeam['players'] != null &&
              (firstTeam['players'] as List).isNotEmpty
          ? firstTeam['players'][0]
          : null;

      if (firstTeam != null && firstPlayer != null) {
        final payload = {
          "teamId": firstTeam['teamId'],
          "playerId": firstPlayer['playerId'],
          "goals": 0,
          "currentStatus": status,
        };

        await MatchApiService.updateScore(widget.matchId, payload);

        setState(() {
          currentStatus = status;
        });

        if (status == 'break') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HalfTimeScreen(
                matchId: widget.matchId,
                matchName: matchName,
                teamScores: teamScores,
                teams: teams,
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Error updating match status: $e');
    }
  }

  Future<void> _updateMatchCancel(String status, String reson) async {
    try {
      final firstTeam = teams.isNotEmpty ? teams[0] : null;
      final firstPlayer = firstTeam != null &&
              firstTeam['players'] != null &&
              (firstTeam['players'] as List).isNotEmpty
          ? firstTeam['players'][0]
          : null;

      if (firstTeam != null && firstPlayer != null) {
        final payload = {"status": status, "cancelReason": reson};

        await MatchApiService.updateScore(widget.matchId, payload);

        setState(() {
          currentStatus = status;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ViewMatchScreen(),
          ),
        );
      }
    } catch (e) {
      print('Error updating match status: $e');
    }
  }

  Future<void> _incrementScore(String teamId, String playerId) async {
    setState(() {
      teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
    });

    try {
      final payload = {
        "teamId": teamId,
        "playerId": playerId,
        "goals": 1,
        "action": "inc"
      };

      await MatchApiService.updateScore(widget.matchId, payload);
    } catch (e) {
      print('Error incrementing score: $e');
      setState(() {
        teamScores[teamId] = (teamScores[teamId] ?? 1) - 1;
      });
    }
  }

  Future<void> _decrementScore(String teamId, String playerId) async {
    if ((teamScores[teamId] ?? 0) > 0) {
      setState(() {
        teamScores[teamId] = (teamScores[teamId] ?? 0) - 1;
      });

      try {
        final payload = {
          "teamId": teamId,
          "playerId": playerId,
          "goals": 1,
          "action": "dec"
        };

        await MatchApiService.updateScore(widget.matchId, payload);
      } catch (e) {
        print('Error decrementing score: $e');
        setState(() {
          teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
        });
      }
    }
  }

  Future<void> _endGame() async {
    try {
      String winner = '';
      if (teams.length == 2) {
        final team1Id = teams[0]['teamId'] as String;
        final team2Id = teams[1]['teamId'] as String;
        final score1 = teamScores[team1Id] ?? 0;
        final score2 = teamScores[team2Id] ?? 0;

        if (score1 > score2) {
          winner = _getTeamName(0);
        } else if (score2 > score1) {
          winner = _getTeamName(1);
        }
      }

      final firstTeam = teams.isNotEmpty ? teams[0] : null;
      final firstPlayer = firstTeam != null &&
              firstTeam['players'] != null &&
              (firstTeam['players'] as List).isNotEmpty
          ? firstTeam['players'][0]
          : null;

      if (firstTeam != null && firstPlayer != null) {
        final team1Id = teams[0]['teamId'] as String;
        final team2Id =
            teams.length > 1 ? teams[1]['teamId'] as String : team1Id;
        final score1 = teamScores[team1Id] ?? 0;
        final score2 = teamScores[team2Id] ?? 0;

        final payload = {
          "teamId": firstTeam['teamId'],
          "playerId": firstPlayer['playerId'],
          "goals": 0,
          "status": "finished",
          "finalScore": {
            "teamA": score1,
            "teamB": score2,
          },
          "timeElapsed": _elapsedTime.inMinutes,
        };

        await MatchApiService.updateScore(widget.matchId, payload);
      }

      final gameResult = winner.isNotEmpty ? '$winner Wins!' : 'Draw!';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameSummaryScreen(
            matchName: matchName,
            finalScores: teamScores,
            gameDuration: _elapsedTime,
            gameResult: gameResult,
            matchId: widget.matchId,
          ),
        ),
      );
    } catch (e) {
      print('Error ending game: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error ending game: $e')),
      );
    }
  }

  void _showEndGameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                _endGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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

  void _showStopDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Stop Match',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'Do you want to stop the match?',
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
                _showStopOptionsDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Stop',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showStopOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Match Options',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: const Text(
            'Choose what you want to do with the match:',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showCancelReasonDialog();
              },
              child: const Text(
                'Cancel Match',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateMatchStatus('break'); // Go to break
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Go to Break',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCancelReasonDialog() {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Cancel Match',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          content: TextField(
            controller: reasonController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter reason for canceling the match',
              border: OutlineInputBorder(),
            ),
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
                final reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  Navigator.of(context).pop();
                  _updateMatchCancel('cancel', reason); // Pass reason
                } else {
                  // Optionally show a toast/snackbar to enter reason
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a reason')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
