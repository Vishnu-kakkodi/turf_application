
import 'package:booking_application/views/Cricket/live_match_screen.dart';
import 'package:booking_application/views/Cricket/match_toss_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewMatchesScreen extends StatefulWidget {
  const ViewMatchesScreen({super.key});

  @override
  State<ViewMatchesScreen> createState() => _ViewMatchesScreenState();
}

class _ViewMatchesScreenState extends State<ViewMatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  List<Match> _liveMatches = [];
  List<Match> _scheduledMatches = [];
  List<Match> _completedMatches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/getmatches'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          List<Match> allMatches = (data['matches'] as List)
              .map((matchData) => Match.fromJson(matchData))
              .toList();

          setState(() {
            _liveMatches = allMatches.where((m) => m.status == MatchStatus.live).toList();
            _scheduledMatches = allMatches.where((m) => m.status == MatchStatus.scheduled).toList();
            _completedMatches = allMatches.where((m) => m.status == MatchStatus.completed).toList();
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Failed to load matches');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cricket Matches',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF333333)),
            onPressed: _fetchMatches,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF2E7D32),
          indicatorWeight: 3,
          labelColor: const Color(0xFF2E7D32),
          unselectedLabelColor: const Color(0xFF666666),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B6B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Text('Live'),
                ],
              ),
            ),
            const Tab(text: 'Scheduled'),
            const Tab(text: 'Completed'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2E7D32),
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildLiveMatchesTab(),
                _buildScheduledMatchesTab(),
                _buildCompletedMatchesTab(),
              ],
            ),
    );
  }

  Widget _buildLiveMatchesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          if (_liveMatches.isEmpty)
            _buildEmptyState(
              'No live matches at the moment',
              Icons.sports_cricket,
              const Color(0xFFFF6B6B),
            )
          else
            ..._liveMatches.map((match) => GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LiveMatchScreen(
    matchId: match.id,
                          )));
                },
                child: _buildMatchCard(match))),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildScheduledMatchesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          if (_scheduledMatches.isEmpty)
            _buildEmptyState(
              'No scheduled matches',
              Icons.schedule,
              const Color(0xFF2E7D32),
            )
          else
            ..._scheduledMatches.map((match) => GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchTossScreen(
                            team1: match.team1,
                            team2: match.team2,
                                          matchId: match.id,
              userId:"6884add9466d0e6a78245550"
                          )));
                },
                child: _buildMatchCard(match))),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCompletedMatchesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          if (_completedMatches.isEmpty)
            _buildEmptyState(
              'No completed matches yet',
              Icons.check_circle_outline,
              const Color(0xFF4CAF50),
            )
          else
            ..._completedMatches.map((match) => _buildMatchCard(match)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: color.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Match Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Team Names
                  Text(
                    '${match.team1.teamName} vs ${match.team2.teamName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Match Details
                  Row(
                    children: [
                      _buildInfoChip('${match.overs} Overs'),
                      const SizedBox(width: 8),
                      _buildInfoChip(match.matchFormat),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildInfoChip(match.matchType),
                  if (match.tournamentName != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          size: 14,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            match.tournamentName!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF666666),
                              fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Action Button or Status
            _buildMatchAction(match),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF666666),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMatchAction(Match match) {
    switch (match.status) {
      case MatchStatus.live:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B6B),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B6B).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.circle,
                size: 8,
                color: Colors.white,
              ),
              SizedBox(width: 6),
              Text(
                'LIVE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );

      case MatchStatus.scheduled:
        return Container(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              _startMatch(match);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
              shadowColor: const Color(0xFF2E7D32).withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Start Match',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );

      case MatchStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF666666),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.check_circle,
                size: 14,
                color: Colors.white,
              ),
              SizedBox(width: 6),
              Text(
                'COMPLETED',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
    }
  }

  void _startMatch(Match match) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MatchTossScreen(
              team1: match.team1,
              team2: match.team2,
              matchId: match.id,
              userId:"6884add9466d0e6a78245550"
            )));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// // Data Models
// class Team {
//   final String id;
//   final String teamName;
//   final List<Player> players;

//   Team({
//     required this.id,
//     required this.teamName,
//     required this.players,
//   });

//   factory Team.fromJson(Map<String, dynamic> json) {
//     return Team(
//       id: json['_id'] ?? '',
//       teamName: json['teamName'] ?? 'Unknown Team',
//       players: (json['players'] as List?)
//           ?.map((player) => Player.fromJson(player))
//           .toList() ?? [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'teamName': teamName,
//       'players': players.map((p) => p.toJson()).toList(),
//     };
//   }
// }

// class Player {
//   final String id;
//   final String name;

//   Player({
//     required this.id,
//     required this.name,
//   });

//   factory Player.fromJson(Map<String, dynamic> json) {
//     return Player(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? 'Unknown Player',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//     };
//   }
// }

// class Match {
//   final String id;
//   final Team team1;
//   final Team team2;
//   final int overs;
//   final String matchFormat;
//   final String matchType;
//   final String? tournamentName;
//   MatchStatus status;

//   Match({
//     required this.id,
//     required this.team1,
//     required this.team2,
//     required this.overs,
//     required this.matchFormat,
//     required this.matchType,
//     this.tournamentName,
//     required this.status,
//   });

//   factory Match.fromJson(Map<String, dynamic> json) {
//     // Map API status to enum
//     MatchStatus status;
//     String apiStatus = json['status'] ?? 'Upcoming';
    
//     if (apiStatus == 'Live' || apiStatus == 'Ongoing') {
//       status = MatchStatus.live;
//     } else if (apiStatus == 'Upcoming' || apiStatus == 'Scheduled') {
//       status = MatchStatus.scheduled;
//     } else {
//       status = MatchStatus.completed;
//     }

//     return Match(
//       id: json['_id'] ?? '',
//       team1: Team.fromJson(json['team1'] ?? {}),
//       team2: Team.fromJson(json['team2'] ?? {}),
//       overs: json['overs'] ?? 20,
//       matchFormat: json['matchFormat'] ?? 'T20',
//       matchType: json['matchType'] ?? 'Friendly',
//       tournamentName: json['tournamentId']?['name'],
//       status: status,
//     );
//   }
// }

// enum MatchStatus {
//   live,
//   scheduled,
//   completed,
// }









// Data Models
class Team {
  final String id;
  final String teamName;
  final List<Player> players;

  Team({
    required this.id,
    required this.teamName,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'] ?? '',
      teamName: json['teamName'] ?? 'Unknown Team',
      players: (json['players'] as List?)
          ?.map((player) => Player.fromJson(player))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'teamName': teamName,
      'players': players.map((p) => p.toJson()).toList(),
    };
  }
}

class Player {
  final String id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown Player',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Match {
  final String id;
  final Team team1;
  final Team team2;
  final double overs;  // Changed from int to double
  final String matchFormat;
  final String matchType;
  final String? tournamentName;
  MatchStatus status;

  Match({
    required this.id,
    required this.team1,
    required this.team2,
    required this.overs,
    required this.matchFormat,
    required this.matchType,
    this.tournamentName,
    required this.status,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    // Map API status to enum
    MatchStatus status;
    String apiStatus = json['status'] ?? 'Upcoming';
    
    if (apiStatus == 'Live' || apiStatus == 'Ongoing') {
      status = MatchStatus.live;
    } else if (apiStatus == 'Upcoming' || apiStatus == 'Scheduled') {
      status = MatchStatus.scheduled;
    } else {
      status = MatchStatus.completed;
    }

    // Handle overs conversion - can be int or double
    double overs = 20.0;
    if (json['overs'] != null) {
      if (json['overs'] is int) {
        overs = (json['overs'] as int).toDouble();
      } else if (json['overs'] is double) {
        overs = json['overs'] as double;
      }
    }

    return Match(
      id: json['_id'] ?? '',
      team1: Team.fromJson(json['team1'] ?? {}),
      team2: Team.fromJson(json['team2'] ?? {}),
      overs: overs,
      matchFormat: json['matchFormat'] ?? 'T20',
      matchType: json['matchType'] ?? 'Friendly',
      tournamentName: json['tournamentId']?['name'],
      status: status,
    );
  }
}

enum MatchStatus {
  live,
  scheduled,
  completed,
}