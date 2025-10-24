import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VolleyballScorecardScreen extends StatefulWidget {
  final String matchId;

  const VolleyballScorecardScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  @override
  State<VolleyballScorecardScreen> createState() => _VolleyballScorecardScreenState();
}

class _VolleyballScorecardScreenState extends State<VolleyballScorecardScreen> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _matchData;

  @override
  void initState() {
    super.initState();
    _fetchMatchData();
  }

  Future<void> _fetchMatchData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/completedvolleyball/${widget.matchId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _matchData = data['match'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load match data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: const Text('Match Scorecard'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _error != null
              ? _buildErrorState()
              : _buildMatchContent(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading match data...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchMatchData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchContent() {
    final scoreCard = _matchData!['scoreCard'] as List;
    final teamA = scoreCard[0];
    final teamB = scoreCard[1];
    final sets = _matchData!['sets'] as List;
    final winner = _matchData!['winner'];
    final winnerTeamId = winner['teamId'];

    return RefreshIndicator(
      onRefresh: _fetchMatchData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Match Header Card
            _buildMatchHeader(),
            const SizedBox(height: 16),

            // Final Score Card
            _buildFinalScore(teamA, teamB, winnerTeamId),
            const SizedBox(height: 16),

            // Sets Breakdown
            _buildSetsBreakdown(sets),
            const SizedBox(height: 16),

            // Team Rosters
            // _buildTeamRosters(teamA, teamB, winnerTeamId),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchHeader() {
    final matchName = _matchData!['name'];
    final createdAt = DateTime.parse(_matchData!['createdAt']);
    final startTime = DateTime.parse(_matchData!['startTime']);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    matchName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Finished',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '${createdAt.day}/${createdAt.month}/${createdAt.year}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 24),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalScore(Map teamA, Map teamB, String winnerTeamId) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Final Score',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Team A
                Expanded(
                  child: _buildTeamScore(
                    teamA['teamName'],
                    teamA['teamPoints'].toString(),
                    teamA['teamId'] == winnerTeamId,
                  ),
                ),
                const Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                // Team B
                Expanded(
                  child: _buildTeamScore(
                    teamB['teamName'],
                    teamB['teamPoints'].toString(),
                    teamB['teamId'] == winnerTeamId,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamScore(String teamName, String score, bool isWinner) {
    return Column(
      children: [
        Text(
          score,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: isWinner ? Colors.amber.shade600 : Colors.grey.shade700,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              teamName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (isWinner) ...[
              const SizedBox(width: 8),
              Icon(Icons.emoji_events, color: Colors.amber.shade600, size: 24),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSetsBreakdown(List sets) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Breakdown',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...sets.map((set) => _buildSetItem(set)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSetItem(Map set) {
    final teamAScore = set['score']['teamA'];
    final teamBScore = set['score']['teamB'];
    final winner = set['winner'];
    final setNumber = set['setNumber'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Set $setNumber',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Winner: $winner',
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      teamAScore['score'].toString(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: winner == teamAScore['name']
                            ? Colors.indigo
                            : Colors.grey,
                      ),
                    ),
                    Text(
                      teamAScore['name'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Text('-', style: TextStyle(fontSize: 20, color: Colors.grey)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      teamBScore['score'].toString(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: winner == teamBScore['name']
                            ? Colors.indigo
                            : Colors.grey,
                      ),
                    ),
                    Text(
                      teamBScore['name'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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

  Widget _buildTeamRosters(Map teamA, Map teamB, String winnerTeamId) {
    return Column(
      children: [
        _buildTeamRoster(teamA, teamA['teamId'] == winnerTeamId),
        const SizedBox(height: 16),
        _buildTeamRoster(teamB, teamB['teamId'] == winnerTeamId),
      ],
    );
  }

  Widget _buildTeamRoster(Map team, bool isWinner) {
    final players = team['players'] as List;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.group, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  team['teamName'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isWinner) ...[
                  const Spacer(),
                  Icon(Icons.emoji_events, color: Colors.amber.shade600, size: 20),
                ],
              ],
            ),
            const SizedBox(height: 16),
            ...players.asMap().entries.map((entry) {
              final idx = entry.key;
              final player = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.indigo.shade200,
                      child: Text(
                        '${idx + 1}',
                        style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      player['playerName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}