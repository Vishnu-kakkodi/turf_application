import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BadmintonScoreCardScreen extends StatefulWidget {
  final String matchId;

  const BadmintonScoreCardScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  @override
  State<BadmintonScoreCardScreen> createState() =>
      _BadmintonScoreCardScreenState();
}

class _BadmintonScoreCardScreenState extends State<BadmintonScoreCardScreen> {
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  Map<String, dynamic>? matchData;

  @override
  void initState() {
    super.initState();
    _fetchMatchData();
  }

  Future<void> _fetchMatchData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://31.97.206.144:3081/users/completedbadminton/${widget.matchId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() {
            matchData = data;
            isLoading = false;
          });
        } else {
          setState(() {
            hasError = true;
            errorMessage = data['message'] ?? 'Failed to load match data';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasError = true;
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Failed to connect: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Match Results'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? _buildErrorView()
              : _buildScoreCard(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Error Loading Match',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchMatchData,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    final match = matchData!['match'];
    final winner = match['winner'];
    final sets = match['sets'] as List;
    final scoreCard = match['scoreCard'] as List;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Winner Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[700]!, Colors.green[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 48,
                ),
                const SizedBox(height: 8),
                Text(
                  '${winner['teamName']} Wins!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  winner['players'].map((p) => p['playerName']).join(' & '),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Final Score Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Final Score',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...scoreCard.map((team) => _buildTeamScore(
                          team['teamName'],
                          team['teamPoints'].toString(),
                          team['players'],
                          team['teamId'] == winner['teamId'],
                        )),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sets Breakdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set-by-Set Results',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...sets.map((set) => _buildSetRow(set)).toList(),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Match Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Match Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Match Name', match['name']),
                    _buildDetailRow('Category', match['categoryId']['name']),
                    _buildDetailRow('Created By', match['createdBy']['name']),
                    _buildDetailRow('Total Sets', match['totalSets'].toString()),
                    _buildDetailRow(
                        'Points Per Set', match['pointsPerSet'].toString()),
                    _buildDetailRow('Win By', match['winBy'].toString()),
                    _buildDetailRow(
                        'Deuce Allowed', match['allowDeuce'] ? 'Yes' : 'No'),
                    if (match['allowDeuce'])
                      _buildDetailRow('Max Deuce Point',
                          match['maxDeucePoint'].toString()),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTeamScore(
      String teamName, String score, List players, bool isWinner) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isWinner ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isWinner ? Colors.green[300]! : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      teamName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isWinner ? Colors.green[800] : Colors.black87,
                      ),
                    ),
                    if (isWinner) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.emoji_events,
                          color: Colors.amber[700], size: 20),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  players.map((p) => p['playerName']).join(', '),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isWinner ? Colors.green[800] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetRow(Map<String, dynamic> set) {
    final score = set['score'];
    final teamA = score['teamA'];
    final teamB = score['teamB'];
    final setNumber = set['setNumber'];
    final winnerName = set['winner'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set $setNumber',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  teamA['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: teamA['name'] == winnerName
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                '${teamA['score']}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: teamA['name'] == winnerName
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: teamA['name'] == winnerName
                      ? Colors.green[700]
                      : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  teamB['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: teamB['name'] == winnerName
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                '${teamB['score']}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: teamB['name'] == winnerName
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: teamB['name'] == winnerName
                      ? Colors.green[700]
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Usage Example:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => BadmintonScoreCardScreen(
//       matchId: '68fb951e5c170b117769d17d',
//     ),
//   ),
// );