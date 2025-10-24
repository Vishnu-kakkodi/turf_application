
// import 'package:booking_application/views/Cricket/live_match_screen.dart';
// import 'package:booking_application/views/Cricket/match_toss_screen.dart';
// import 'package:booking_application/views/Cricket/views/completed_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ViewMatchesScreen extends StatefulWidget {
//   const ViewMatchesScreen({super.key});

//   @override
//   State<ViewMatchesScreen> createState() => _ViewMatchesScreenState();
// }

// class _ViewMatchesScreenState extends State<ViewMatchesScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
  
//   List<Match> _liveMatches = [];
//   List<Match> _scheduledMatches = [];
//   List<Match> _completedMatches = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _fetchMatches();
//   }

//   Future<void> _fetchMatches() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:3081/users/getmatches'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         if (data['success'] == true) {
//           List<Match> allMatches = (data['matches'] as List)
//               .map((matchData) => Match.fromJson(matchData))
//               .toList();

//           setState(() {
//             _liveMatches = allMatches.where((m) => m.status == MatchStatus.live).toList();
//             _scheduledMatches = allMatches.where((m) => m.status == MatchStatus.scheduled).toList();
//             _completedMatches = allMatches.where((m) => m.status == MatchStatus.completed).toList();
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         _showSnackBar('Failed to load matches');
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showSnackBar('Error: ${e.toString()}');
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Cricket Matches',
//           style: TextStyle(
//             color: Color(0xFF333333),
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Color(0xFF333333)),
//             onPressed: _fetchMatches,
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xFF2E7D32),
//           indicatorWeight: 3,
//           labelColor: const Color(0xFF2E7D32),
//           unselectedLabelColor: const Color(0xFF666666),
//           labelStyle: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.normal,
//           ),
//           tabs: [
//             Tab(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 8,
//                     height: 8,
//                     margin: const EdgeInsets.only(right: 8),
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFFF6B6B),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const Text('Live'),
//                 ],
//               ),
//             ),
//             const Tab(text: 'Scheduled'),
//             const Tab(text: 'Completed'),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF2E7D32),
//               ),
//             )
//           : TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildLiveMatchesTab(),
//                 _buildScheduledMatchesTab(),
//                 _buildCompletedMatchesTab(),
//               ],
//             ),
//     );
//   }

//   Widget _buildLiveMatchesTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           if (_liveMatches.isEmpty)
//             _buildEmptyState(
//               'No live matches at the moment',
//               Icons.sports_cricket,
//               const Color(0xFFFF6B6B),
//             )
//           else
//             ..._liveMatches.map((match) => GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => LiveMatchScreen(
//     matchId: match.id,
//                           )));
//                 },
//                 child: _buildMatchCard(match))),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }

//   Widget _buildScheduledMatchesTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           if (_scheduledMatches.isEmpty)
//             _buildEmptyState(
//               'No scheduled matches',
//               Icons.schedule,
//               const Color(0xFF2E7D32),
//             )
//           else
//             ..._scheduledMatches.map((match) => GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => MatchTossScreen(
//                             team1: match.team1,
//                             team2: match.team2,
//                                           matchId: match.id,
//               userId:"6884add9466d0e6a78245550"
//                           )));
//                 },
//                 child: _buildMatchCard(match))),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }

//   Widget _buildCompletedMatchesTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           if (_completedMatches.isEmpty)
//             _buildEmptyState(
//               'No completed matches yet',
//               Icons.check_circle_outline,
//               const Color(0xFF4CAF50),
//             )
//           else
//             ..._completedMatches.map((match) => _buildMatchCard(match)),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState(String message, IconData icon, Color color) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 60),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 64,
//             color: color.withOpacity(0.5),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Color(0xFF666666),
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMatchCard(Match match) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: const Color(0xFFE0E0E0),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             // Match Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Team Names
//                   Text(
//                     '${match.team1.teamName} vs ${match.team2.teamName}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF333333),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   // Match Details
//                   Row(
//                     children: [
//                       _buildInfoChip('${match.overs} Overs'),
//                       const SizedBox(width: 8),
//                       _buildInfoChip(match.matchFormat),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   _buildInfoChip(match.matchType),
//                   if (match.tournamentName != null) ...[
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.emoji_events,
//                           size: 14,
//                           color: Color(0xFF666666),
//                         ),
//                         const SizedBox(width: 4),
//                         Flexible(
//                           child: Text(
//                             match.tournamentName!,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF666666),
//                               fontStyle: FontStyle.italic,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ],
//               ),
//             ),

//             // Action Button or Status
//             _buildMatchAction(match),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: const Color(0xFFE0E0E0),
//           width: 1,
//         ),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Color(0xFF666666),
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildMatchAction(Match match) {
//     switch (match.status) {
//       case MatchStatus.live:
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFF6B6B),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFFF6B6B).withOpacity(0.3),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(
//                 Icons.circle,
//                 size: 8,
//                 color: Colors.white,
//               ),
//               SizedBox(width: 6),
//               Text(
//                 'LIVE',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         );

//       case MatchStatus.scheduled:
//         return Container(
//           height: 40,
//           child: ElevatedButton(
//             onPressed: () {
//               _startMatch(match);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2E7D32),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 2,
//               shadowColor: const Color(0xFF2E7D32).withOpacity(0.3),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Text(
//                   'Start Match',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );

//       case MatchStatus.completed:
//         return GestureDetector(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>CompletedScreen()));
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 102, 255, 138),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Icon(
//                   Icons.check_circle,
//                   size: 14,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   'VIEW',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }
//   }

//   void _startMatch(Match match) {
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => MatchTossScreen(
//               team1: match.team1,
//               team2: match.team2,
//               matchId: match.id,
//               userId:"6884add9466d0e6a78245550"
//             )));
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: const Color(0xFF2E7D32),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
// }

// // // Data Models
// // class Team {
// //   final String id;
// //   final String teamName;
// //   final List<Player> players;

// //   Team({
// //     required this.id,
// //     required this.teamName,
// //     required this.players,
// //   });

// //   factory Team.fromJson(Map<String, dynamic> json) {
// //     return Team(
// //       id: json['_id'] ?? '',
// //       teamName: json['teamName'] ?? 'Unknown Team',
// //       players: (json['players'] as List?)
// //           ?.map((player) => Player.fromJson(player))
// //           .toList() ?? [],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       '_id': id,
// //       'teamName': teamName,
// //       'players': players.map((p) => p.toJson()).toList(),
// //     };
// //   }
// // }

// // class Player {
// //   final String id;
// //   final String name;

// //   Player({
// //     required this.id,
// //     required this.name,
// //   });

// //   factory Player.fromJson(Map<String, dynamic> json) {
// //     return Player(
// //       id: json['_id'] ?? '',
// //       name: json['name'] ?? 'Unknown Player',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       '_id': id,
// //       'name': name,
// //     };
// //   }
// // }

// // class Match {
// //   final String id;
// //   final Team team1;
// //   final Team team2;
// //   final int overs;
// //   final String matchFormat;
// //   final String matchType;
// //   final String? tournamentName;
// //   MatchStatus status;

// //   Match({
// //     required this.id,
// //     required this.team1,
// //     required this.team2,
// //     required this.overs,
// //     required this.matchFormat,
// //     required this.matchType,
// //     this.tournamentName,
// //     required this.status,
// //   });

// //   factory Match.fromJson(Map<String, dynamic> json) {
// //     // Map API status to enum
// //     MatchStatus status;
// //     String apiStatus = json['status'] ?? 'Upcoming';
    
// //     if (apiStatus == 'Live' || apiStatus == 'Ongoing') {
// //       status = MatchStatus.live;
// //     } else if (apiStatus == 'Upcoming' || apiStatus == 'Scheduled') {
// //       status = MatchStatus.scheduled;
// //     } else {
// //       status = MatchStatus.completed;
// //     }

// //     return Match(
// //       id: json['_id'] ?? '',
// //       team1: Team.fromJson(json['team1'] ?? {}),
// //       team2: Team.fromJson(json['team2'] ?? {}),
// //       overs: json['overs'] ?? 20,
// //       matchFormat: json['matchFormat'] ?? 'T20',
// //       matchType: json['matchType'] ?? 'Friendly',
// //       tournamentName: json['tournamentId']?['name'],
// //       status: status,
// //     );
// //   }
// // }

// // enum MatchStatus {
// //   live,
// //   scheduled,
// //   completed,
// // }









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
//   final double overs;  // Changed from int to double
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

//     // Handle overs conversion - can be int or double
//     double overs = 20.0;
//     if (json['overs'] != null) {
//       if (json['overs'] is int) {
//         overs = (json['overs'] as int).toDouble();
//       } else if (json['overs'] is double) {
//         overs = json['overs'] as double;
//       }
//     }

//     return Match(
//       id: json['_id'] ?? '',
//       team1: Team.fromJson(json['team1'] ?? {}),
//       team2: Team.fromJson(json['team2'] ?? {}),
//       overs: overs,
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



























import 'package:booking_application/views/Cricket/views/live_match_screen.dart';
import 'package:booking_application/views/Cricket/views/match_toss_screen.dart';
import 'package:booking_application/views/Cricket/views/completed_screen.dart';
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Cricket Matches',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Live updates & schedules',
              style: TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1A1A1A), size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Color(0xFF1A1A1A), size: 22),
              onPressed: _fetchMatches,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF00A86B),
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: const Color(0xFF00A86B),
              unselectedLabelColor: const Color(0xFF8E8E93),
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          color: _tabController.index == 0 
                              ? const Color(0xFFFF3B30) 
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text('LIVE'),
                    ],
                  ),
                ),
                const Tab(text: 'SCHEDULED'),
                const Tab(text: 'COMPLETED'),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Color(0xFF00A86B),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading matches...',
                    style: TextStyle(
                      color: Color(0xFF8E8E93),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
    return _liveMatches.isEmpty
        ? _buildEmptyState(
            'No live matches',
            'Check back later for live cricket action',
            Icons.sports_cricket_rounded,
            const Color(0xFFFF3B30),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _liveMatches.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveMatchScreen(
                      matchId: _liveMatches[index].id,
                    ),
                  ),
                );
              },
              child: _buildMatchCard(_liveMatches[index]),
            ),
          );
  }

  Widget _buildScheduledMatchesTab() {
    return _scheduledMatches.isEmpty
        ? _buildEmptyState(
            'No scheduled matches',
            'New matches will appear here',
            Icons.event_note_rounded,
            const Color(0xFF00A86B),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _scheduledMatches.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchTossScreen(
                      team1: _scheduledMatches[index].team1,
                      team2: _scheduledMatches[index].team2,
                      matchId: _scheduledMatches[index].id,
                      userId: "6884add9466d0e6a78245550",
                    ),
                  ),
                );
              },
              child: _buildMatchCard(_scheduledMatches[index]),
            ),
          );
  }

  Widget _buildCompletedMatchesTab() {
    return _completedMatches.isEmpty
        ? _buildEmptyState(
            'No completed matches',
            'Match results will appear here',
            Icons.history_rounded,
            const Color(0xFF34C759),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _completedMatches.length,
            itemBuilder: (context, index) => _buildMatchCard(_completedMatches[index]),
          );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 48,
              color: color.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8E8E93),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Match Header with Tournament
          if (match.tournamentName != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      size: 16,
                      color: Color(0xFFFFB800),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      match.tournamentName!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1A1A1A),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          
          // Main Match Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Teams Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.team1.teamName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: -0.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A86B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF00A86B),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            match.team2.teamName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: -0.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Match Details & Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Match Info Chips
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _buildModernChip(
                            '${match.overs.toStringAsFixed(match.overs.truncateToDouble() == match.overs ? 0 : 1)} Overs',
                            Icons.schedule_rounded,
                          ),
                          _buildModernChip(
                            match.matchFormat,
                            Icons.sports_cricket_rounded,
                          ),
                          _buildModernChip(
                            match.matchType,
                            Icons.category_rounded,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Action Button
                    _buildMatchAction(match),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: const Color(0xFF8E8E93),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchAction(Match match) {
    switch (match.status) {
      case MatchStatus.live:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF3B30), Color(0xFFFF6B60)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF3B30).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
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
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        );

      case MatchStatus.scheduled:
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00A86B), Color(0xFF00C97F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00A86B).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              _startMatch(match);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.play_arrow_rounded, size: 18),
                SizedBox(width: 4),
                Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );

      case MatchStatus.completed:
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompletedScreen(matchId: match.id,)),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF34C759).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF34C759),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: Color(0xFF34C759),
                ),
                SizedBox(width: 6),
                Text(
                  'View',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF34C759),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  void _startMatch(Match match) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MatchTossScreen(
          team1: match.team1,
          team2: match.team2,
          matchId: match.id,
          userId: "6884add9466d0e6a78245550",
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00A86B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

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
  final double overs;
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
    MatchStatus status;
    String apiStatus = json['status'] ?? 'Upcoming';
    
    if (apiStatus == 'Live' || apiStatus == 'Ongoing') {
      status = MatchStatus.live;
    } else if (apiStatus == 'Upcoming' || apiStatus == 'Scheduled') {
      status = MatchStatus.scheduled;
    } else {
      status = MatchStatus.completed;
    }

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