import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FootballCompleted extends StatefulWidget {
  final String matchId;

  const FootballCompleted({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  @override
  State<FootballCompleted> createState() => _FootballCompletedState();
}

class _FootballCompletedState extends State<FootballCompleted> {
  bool _isLoading = true;
  MatchDetails? _matchDetails;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchMatchDetails();
  }

  Future<void> _fetchMatchDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://31.97.206.144:3081/users/getcompletedmatch/${widget.matchId}'),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _matchDetails = MatchDetails.fromJson(data['match']);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load match details';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _errorMessage = 'Error loading match: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
        title: const Text(
          'Match Scorecard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.share),
          //   onPressed: () {
          //     // Share functionality
          //   },
          // ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
              ),
            )
          : _errorMessage != null
              ? _buildErrorState()
              : _matchDetails != null
                  ? RefreshIndicator(
                      onRefresh: _fetchMatchDetails,
                      color: const Color(0xFF2E7D32),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            _buildMatchHeader(),
                            _buildFinalScore(),
                            _buildScoreBreakdown(),
                            _buildTeamStats(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : const Center(child: Text('No data available')),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage ?? 'Something went wrong',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _fetchMatchDetails,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E7D32),
            Color(0xFF1B5E20),
          ],
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  _matchDetails!.status.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _matchDetails!.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _matchDetails!.categoryName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.white70),
              const SizedBox(width: 6),
              Text(
                _formatDate(_matchDetails!.startedAt),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalScore() {
    final teamA = _matchDetails!.teams[0];
    final teamB = _matchDetails!.teams[1];
    final scoreA = _matchDetails!.finalScore.teamA;
    final scoreB = _matchDetails!.finalScore.teamB;
    final isTeamAWinner = scoreA > scoreB;
    final isTeamBWinner = scoreB > scoreA;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.emoji_events, color: Color(0xFF2E7D32), size: 20),
                SizedBox(width: 8),
                Text(
                  'Final Score',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isTeamAWinner
                                ? [Color(0xFF2E7D32), Color(0xFF1B5E20)]
                                : [Colors.grey[400]!, Colors.grey[500]!],
                          ),
                        ),
                        child: const Icon(
                          Icons.sports_soccer,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        teamA.teamName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isTeamAWinner ? FontWeight.bold : FontWeight.w600,
                          color: isTeamAWinner ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        scoreA.toString(),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: isTeamAWinner ? const Color(0xFF2E7D32) : const Color(0xFF999999),
                        ),
                      ),
                      if (isTeamAWinner)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'WINNER',
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isTeamBWinner
                                ? [Color(0xFF2E7D32), Color(0xFF1B5E20)]
                                : [Colors.grey[400]!, Colors.grey[500]!],
                          ),
                        ),
                        child: const Icon(
                          Icons.sports_soccer,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        teamB.teamName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isTeamBWinner ? FontWeight.bold : FontWeight.w600,
                          color: isTeamBWinner ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        scoreB.toString(),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: isTeamBWinner ? const Color(0xFF2E7D32) : const Color(0xFF999999),
                        ),
                      ),
                      if (isTeamBWinner)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'WINNER',
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
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBreakdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.bar_chart, color: Color(0xFF2E7D32), size: 20),
                SizedBox(width: 8),
                Text(
                  'Score Breakdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildScoreRow(
                  'Half Time',
                  _matchDetails!.halfTimeScore.teamA,
                  _matchDetails!.halfTimeScore.teamB,
                  Icons.timer,
                ),
                const Divider(height: 24),
                _buildScoreRow(
                  'Second Half',
                  _matchDetails!.secondHalfScore.teamA,
                  _matchDetails!.secondHalfScore.teamB,
                  Icons.schedule,
                ),
                if (_matchDetails!.extraTimeScore.teamA > 0 ||
                    _matchDetails!.extraTimeScore.teamB > 0) ...[
                  const Divider(height: 24),
                  _buildScoreRow(
                    'Extra Time',
                    _matchDetails!.extraTimeScore.teamA,
                    _matchDetails!.extraTimeScore.teamB,
                    Icons.add_circle_outline,
                  ),
                ],
                if (_matchDetails!.penaltyScore.teamA > 0 ||
                    _matchDetails!.penaltyScore.teamB > 0) ...[
                  const Divider(height: 24),
                  _buildScoreRow(
                    'Penalties',
                    _matchDetails!.penaltyScore.teamA,
                    _matchDetails!.penaltyScore.teamB,
                    Icons.sports_soccer,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, int scoreA, int scoreB, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF666666)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            scoreA.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            scoreB.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.people, color: Color(0xFF2E7D32), size: 20),
                SizedBox(width: 8),
                Text(
                  'Team Statistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _matchDetails!.scoreCard.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final team = _matchDetails!.scoreCard[index];
              return _buildTeamCard(team, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(TeamScore team, int index) {
    final teamInfo = _matchDetails!.teams[index];
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
          ),
        ),
        child: const Icon(Icons.sports_soccer, color: Colors.white, size: 24),
      ),
      title: Text(
        teamInfo.teamName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
      subtitle: Text(
        '${team.players.length} players • ${team.teamGoals} goals',
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF666666),
        ),
      ),
      children: [
        ...team.players.map((player) => _buildPlayerCard(player)).toList(),
      ],
    );
  }

  Widget _buildPlayerCard(Player player) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF2E7D32),
            child: Text(
              player.playerName[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.playerName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (player.goals > 0) ...[
                      Icon(Icons.sports_soccer, size: 14, color: Colors.green[700]),
                      const SizedBox(width: 4),
                      Text(
                        '${player.goals} ${player.goals == 1 ? 'goal' : 'goals'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (player.warningCards.yellow > 0) ...[
                      if (player.goals > 0) const SizedBox(width: 12),
                      Container(
                        width: 12,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${player.warningCards.yellow}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                    if (player.warningCards.red > 0) ...[
                      const SizedBox(width: 12),
                      Container(
                        width: 12,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${player.warningCards.red}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (player.isOut)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'OUT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Model Classes
class MatchDetails {
  final String id;
  final String name;
  final String categoryName;
  final String status;
  final String currentStatus;
  final DateTime startedAt;
  final Score halfTimeScore;
  final Score secondHalfScore;
  final Score extraTimeScore;
  final Score finalScore;
  final Score penaltyScore;
  final List<TeamScore> scoreCard;
  final List<Team> teams;

  MatchDetails({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.status,
    required this.currentStatus,
    required this.startedAt,
    required this.halfTimeScore,
    required this.secondHalfScore,
    required this.extraTimeScore,
    required this.finalScore,
    required this.penaltyScore,
    required this.scoreCard,
    required this.teams,
  });

  factory MatchDetails.fromJson(Map<String, dynamic> json) {
    return MatchDetails(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      categoryName: json['categoryId']['name'] ?? '',
      status: json['status'] ?? '',
      currentStatus: json['currentStatus'] ?? '',
      startedAt: DateTime.parse(json['startedAt']),
      halfTimeScore: Score.fromJson(json['halfTimeScore'] ?? {}),
      secondHalfScore: Score.fromJson(json['secondHalfScore'] ?? {}),
      extraTimeScore: Score.fromJson(json['extraTimeScore'] ?? {}),
      finalScore: Score.fromJson(json['finalScore'] ?? {}),
      penaltyScore: Score.fromJson(json['penaltyScore'] ?? {}),
      scoreCard: (json['scoreCard'] as List?)
              ?.map((e) => TeamScore.fromJson(e))
              .toList() ??
          [],
      teams:
          (json['teams'] as List?)?.map((e) => Team.fromJson(e)).toList() ?? [],
    );
  }
}

class Score {
  final int teamA;
  final int teamB;

  Score({required this.teamA, required this.teamB});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      teamA: json['teamA'] ?? 0,
      teamB: json['teamB'] ?? 0,
    );
  }
}

class TeamScore {
  final String teamId;
  final int teamGoals;
  final List<Player> players;

  TeamScore({
    required this.teamId,
    required this.teamGoals,
    required this.players,
  });

  factory TeamScore.fromJson(Map<String, dynamic> json) {
    return TeamScore(
      teamId: json['teamId'] ?? '',
      teamGoals: json['teamGoals'] ?? 0,
      players: (json['players'] as List?)
              ?.map((e) => Player.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Player {
  final String playerId;
  final String playerName;
  final int goals;
  final bool isOut;
  final WarningCards warningCards;

  Player({
    required this.playerId,
    required this.playerName,
    required this.goals,
    required this.isOut,
    required this.warningCards,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerId: json['playerId'] ?? '',
      playerName: json['playerName'] ?? '',
      goals: json['goals'] ?? 0,
      isOut: json['isOut'] ?? false,
      warningCards: WarningCards.fromJson(json['warningCards'] ?? {}),
    );
  }
}

class WarningCards {
  final int yellow;
  final int red;

  WarningCards({required this.yellow, required this.red});

  factory WarningCards.fromJson(Map<String, dynamic> json) {
    return WarningCards(
      yellow: json['yellow'] ?? 0,
      red: json['red'] ?? 0,
    );
  }
}

class Team {
  final String teamId;
  final String teamName;
  final List<TeamPlayer> players;

  Team({
    required this.teamId,
    required this.teamName,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'] ?? '',
      teamName: json['teamName'] ?? '',
      players: (json['players'] as List?)
              ?.map((e) => TeamPlayer.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class TeamPlayer {
  final String playerId;
  final String playerName;
  final String avatar;

  TeamPlayer({
    required this.playerId,
    required this.playerName,
    required this.avatar,
  });

  factory TeamPlayer.fromJson(Map<String, dynamic> json) {
    return TeamPlayer(
      playerId: json['playerId'] ?? '',
      playerName: json['playerName'] ?? '',
      avatar: json['avatar'] ?? 'default-avatar.jpg',
    );
  }
}