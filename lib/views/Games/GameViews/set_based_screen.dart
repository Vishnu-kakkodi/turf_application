// import 'package:booking_application/views/Games/GameViews/create_games.dart';
// import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
// import 'package:booking_application/views/Games/sport_congig.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   // Fetch single match data
//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglebatmintonmatch/$matchId'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['match'];
//       } else {
//         throw Exception('Failed to load match data');
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       rethrow;
//     }
//   }

//   // Update badminton match (increment/decrement points)
//   static Future<void> updateBadmintonScore(
//     String matchId,
//     String teamId,
//     String playerId,
//     int points,
//     String action, // 'inc' or 'dec'
//   ) async {
//     try {
//       final payload = {
//         "teamId": teamId,
//         "playerId": playerId,
//         "points": points,
//         "action": action,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update badminton score');
//       }
//     } catch (e) {
//       print('Error updating badminton score: $e');
//       rethrow;
//     }
//   }

//   // Update current set
//   static Future<void> updateCurrentSet(
//     String matchId,
//     int currentSet,
//   ) async {
//     try {
//       final payload = {
//         "currentSet": currentSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update current set');
//       }
//     } catch (e) {
//       print('Error updating current set: $e');
//       rethrow;
//     }
//   }

//   // Finish match
//   static Future<void> finishMatch(String matchId) async {
//     try {
//       final payload = {
//         "status": "finished",
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to finish match');
//       }
//     } catch (e) {
//       print('Error finishing match: $e');
//       rethrow;
//     }
//   }

//   // Legacy update match status (kept for compatibility)
//   static Future<void> updateMatchStatus(
//     String userId,
//     String matchId,
//     Map<String, dynamic> payload,
//   ) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/users/footballstatus/$userId/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update match status');
//       }
//     } catch (e) {
//       print('Error updating match status: $e');
//       rethrow;
//     }
//   }
// }

// // Socket Service Class
// class SocketService {
//   static IO.Socket? socket;
//   static const String socketUrl = 'http://31.97.206.144:3081';

//   static void initSocket() {
//     socket = IO.io(socketUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     socket?.on('connect', (_) {
//       print('Socket connected: ${socket?.id}');
//     });

//     socket?.on('disconnect', (_) {
//       print('Socket disconnected');
//     });
//   }

//   static void joinMatch(String matchId) {
//     socket?.emit('join-match', matchId);
//     print('Joined match room: $matchId');
//   }

//   // Listen to badminton match fetched event
//   static void listenToBadmintonMatchFetched(Function(Map<String, dynamic>) callback) {
//     socket?.on('badminton:match:fetched', (data) {
//       print('Badminton match fetched: $data');
//       callback(data);
//     });
//   }

//   // Listen to badminton match updated event
//   static void listenToBadmintonMatchUpdated(Function(Map<String, dynamic>) callback) {
//     socket?.on('badminton:match:updated', (data) {
//       print('Badminton match updated: $data');
//       callback(data);
//     });
//   }

//   // Legacy listeners (keeping for backward compatibility)
//   static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('liveScoreUpdate', (data) {
//       print('Live score update received: $data');
//       callback(data);
//     });
//   }

//   static void listenToSingleMatchData(Function(Map<String, dynamic>) callback) {
//     socket?.on('singleMatchData', (data) {
//       print('Single match data received: $data');
//       callback(data);
//     });
//   }

//   static void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//   }
// }

// // Game Summary Screen for displaying final results
// class GameSummaryScreen extends StatelessWidget {
//   final String sportName;
//   final List<String> participants;
//   final Map<String, int> finalScores;
//   final Map<String, int> setsWon;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.sportName,
//     required this.participants,
//     required this.finalScores,
//     required this.setsWon,
//     required this.gameDuration,
//     required this.gameResult,
//     required this.matchId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Game Summary',
//           style: TextStyle(
//             color: Color(0xFF1F2937),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF374151)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Game result header
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: gameResult.contains('Draw') ? const Color(0xFFF3F4F6) : const Color(0xFFDCFCE7),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: gameResult.contains('Draw') ? const Color(0xFFE5E7EB) : const Color(0xFF10B981),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     gameResult.contains('Draw') ? Icons.handshake : Icons.emoji_events,
//                     size: 48,
//                     color: gameResult.contains('Draw') ? const Color(0xFF6B7280) : const Color(0xFF10B981),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     gameResult,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$sportName Match',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Sets Won Display
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8FAFC),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE2E8F0)),
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Final Sets',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...participants.map((participant) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           participant,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF374151),
//                           ),
//                         ),
//                         Text(
//                           '${setsWon[participant] ?? 0} sets',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF3B82F6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<GameProvider>().updateMatchStatus(matchId, "completed");
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     child: const Text(
//                       'New Game',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Scorecard Screen with Set-Based Scoring
// class SetBasedScreen extends StatefulWidget {
//   final String matchId;

//   const SetBasedScreen({
//     super.key,
//     required this.matchId,
//   });

//   @override
//   State<SetBasedScreen> createState() => _SetBasedScreenState();
// }

// class _SetBasedScreenState extends State<SetBasedScreen> {
//   late Map<String, int> scores;
//   late Map<String, int> setsWon;
//   late bool isMatchEnded;
//   late String matchWinner;
//   late Stopwatch stopwatch;
//   late int currentSet;
//   late Duration initialElapsedTime;
//   late int setsToWin;
//   late int pointsPerSet;
//   late int winBy;
//   late bool allowDeuce;
//   late int maxDeucePoint;

//   // API related fields
//   Map<String, dynamic>? matchData;
//   bool isLoading = true;
//   List<String> teamIds = [];
//   List<String> playerIds = [];
//   List<String> participants = [];
//   String userId = '';
//   String sportName = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeSocket();
//     _fetchMatchData();
//   }

//   void _initializeSocket() {
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);

//     // Listen to badminton match fetched event
//     SocketService.listenToBadmintonMatchFetched((data) {
//       if (mounted) {
//         print('Received badminton:match:fetched event');
//         final match = data['match'];
        
//         if (match != null) {
//           setState(() {
//             matchData = match;
//             _updateFromMatchData();
//           });
//         }
//       }
//     });

//     // Listen to badminton match updated event
//     SocketService.listenToBadmintonMatchUpdated((updatedMatch) {
//       if (mounted) {
//         print('Received badminton:match:updated event');
//         setState(() {
//           matchData = updatedMatch;
//           _updateFromMatchData();
//           _updateScoresFromMatchData();
//         });
//       }
//     });

//     // Legacy listeners for backward compatibility
//     SocketService.listenToLiveScoreUpdate((data) {
//       if (mounted) {
//         setState(() {
//           if (data['teamScores'] != null) {
//             _updateScoresFromSocket(data['teamScores']);
//           }
//         });
//       }
//     });

//     SocketService.listenToSingleMatchData((data) {
//       if (mounted) {
//         setState(() {
//           matchData = data['match'];
//           _updateFromMatchData();
//         });
//       }
//     });
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           isLoading = false;
//           _initializeGameFromApi();
//         });
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading match data: $e')),
//         );
//       }
//     }
//   }

//   void _initializeGameFromApi() {
//     if (matchData == null) return;

//     // Extract userId
//     if (matchData!['createdBy'] != null) {
//       userId = matchData!['createdBy']['_id'] ?? '';
//     }

//     // Extract sport name
//     if (matchData!['categoryId'] != null) {
//       sportName = matchData!['categoryId']['name'] ?? 'Match';
//     }

//     // Extract match settings
//     pointsPerSet = matchData!['pointsPerSet'] ?? 21;
//     winBy = matchData!['winBy'] ?? 2;
//     allowDeuce = matchData!['allowDeuce'] ?? true;
//     maxDeucePoint = matchData!['maxDeucePoint'] ?? 30;

//     // Extract team IDs, player IDs, and create participant names
//     if (matchData!['teams'] != null) {
//       final teams = matchData!['teams'] as List;
//       teamIds = teams.map((team) => team['teamId'].toString()).toList();
      
//       playerIds = [];
//       participants = [];
      
//       for (var team in teams) {
//         String teamName = team['teamName'] ?? 'Team ${participants.length + 1}';
//         participants.add(teamName);
        
//         if (team['players'] != null && (team['players'] as List).isNotEmpty) {
//           final firstPlayer = (team['players'] as List)[0];
//           playerIds.add(firstPlayer['playerId'].toString());
//         } else {
//           playerIds.add('');
//         }
//       }
//     }

//     // Initialize scores from current set data
//     _initializeScoresFromSets();

//     // Get setsToWin from scoringTemplate or totalSets
//     if (matchData!['scoringTemplate'] != null) {
//       setsToWin = matchData!['scoringTemplate']['setsToWin'] ?? 2;
//     } else {
//       final totalSets = matchData!['totalSets'] ?? 3;
//       setsToWin = (totalSets / 2).ceil();
//     }

//     currentSet = matchData!['currentSet'] ?? 1;
//     isMatchEnded = matchData!['status'] == 'finished';
//     matchWinner = '';

//     // Initialize time
//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     stopwatch = Stopwatch();
//     if (matchData!['status'] == 'live') {
//       stopwatch.start();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//       });
//     }
//   }

//   void _initializeScoresFromSets() {
//     scores = {for (String participant in participants) participant: 0};
//     setsWon = {for (String participant in participants) participant: 0};

//     if (matchData!['sets'] != null) {
//       final sets = matchData!['sets'] as List;
      
//       // Get current set scores
//       if (sets.isNotEmpty && matchData!['currentSet'] != null) {
//         final currentSetIndex = (matchData!['currentSet'] as int) - 1;
//         if (currentSetIndex < sets.length) {
//           final currentSetData = sets[currentSetIndex];
//           if (currentSetData['score'] != null) {
//             final score = currentSetData['score'];
//             if (score['teamA'] != null && participants.isNotEmpty) {
//               scores[participants[0]] = score['teamA']['score'] ?? 0;
//             }
//             if (score['teamB'] != null && participants.length > 1) {
//               scores[participants[1]] = score['teamB']['score'] ?? 0;
//             }
//           }
//         }
//       }

//       // Count sets won by each team
//       for (var set in sets) {
//         if (set['winner'] != null) {
//           String? winnerName = set['winner'];
//           if (winnerName != null && setsWon.containsKey(winnerName)) {
//             setsWon[winnerName] = (setsWon[winnerName] ?? 0) + 1;
//           }
//         }
//       }
//     }

//     // Also check finalScore for sets won
//     if (matchData!['finalScore'] != null) {
//       final finalScore = matchData!['finalScore'];
//       if (finalScore['teamA'] != null && participants.isNotEmpty) {
//         setsWon[participants[0]] = finalScore['teamA']['score'] ?? 0;
//       }
//       if (finalScore['teamB'] != null && participants.length > 1) {
//         setsWon[participants[1]] = finalScore['teamB']['score'] ?? 0;
//       }
//     }
//   }

//   void _updateScoresFromSocket(Map<String, dynamic> teamScores) {
//     teamScores.forEach((teamId, score) {
//       final index = teamIds.indexOf(teamId);
//       if (index >= 0 && index < participants.length) {
//         scores[participants[index]] = score;
//       }
//     });
//   }

//   void _updateScoresFromMatchData() {
//     if (matchData == null) return;

//     // Update scores from sets
//     _initializeScoresFromSets();
//   }

//   void _updateFromMatchData() {
//     if (matchData == null) return;

//     final status = matchData!['status'] ?? 'live';
//     isMatchEnded = status == 'finished';

//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     currentSet = matchData!['currentSet'] ?? currentSet;
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     SocketService.dispose();
//     super.dispose();
//   }

//   Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

//   // Check if current set can be ended
//   bool _canEndCurrentSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Both scores must reach at least the pointsPerSet
//     if (score1 < pointsPerSet && score2 < pointsPerSet) {
//       return false;
//     }

//     // Check if any team has reached the winning condition
//     final diff = (score1 - score2).abs();

//     // If one team reached pointsPerSet and has winBy advantage
//     if ((score1 >= pointsPerSet || score2 >= pointsPerSet) && diff >= winBy) {
//       return true;
//     }

//     // Deuce scenario: if allowDeuce is true
//     if (allowDeuce && (score1 >= pointsPerSet || score2 >= pointsPerSet)) {
//       // Check if we're at maxDeucePoint
//       if (score1 >= maxDeucePoint || score2 >= maxDeucePoint) {
//         return true;
//       }
      
//       // Or if someone has winBy advantage
//       if (diff >= winBy) {
//         return true;
//       }
//     }

//     return false;
//   }

//   String _getSetStatusMessage() {
//     if (scores.isEmpty || participants.length < 2) return '';

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;
//     final diff = (score1 - score2).abs();
//     final maxScore = score1 > score2 ? score1 : score2;

//     if (maxScore < pointsPerSet) {
//       return 'First to $pointsPerSet points wins';
//     }

//     // Deuce scenario
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       if (maxScore >= maxDeucePoint) {
//         return 'Maximum deuce point reached!';
//       }
//       return 'Deuce! Need to win by $winBy (Max: $maxDeucePoint)';
//     }

//     if (diff < winBy) {
//       return 'Need to win by $winBy points';
//     }

//     return 'Set point reached!';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF3B82F6),
//           ),
//         ),
//       );
//     }

//     if (matchData == null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text('Error'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 64, color: Colors.red),
//               SizedBox(height: 16),
//               Text('Failed to load match data'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Go Back'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _buildSetBasedScorecard(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '$sportName Match',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       participants.join(' vs '),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 2),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFEF4444),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Text(
//                         'LIVE',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               _buildActionButtons(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         // InkWell(
//         //   onTap: _showNewGameDialog,
//         //   borderRadius: BorderRadius.circular(8),
//         //   child: Container(
//         //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         //     decoration: BoxDecoration(
//         //       color: const Color(0xFFF3F4F6),
//         //       borderRadius: BorderRadius.circular(8),
//         //       border: Border.all(color: const Color(0xFFE5E7EB)),
//         //     ),
//         //     child: const Text(
//         //       'New Game',
//         //       style: TextStyle(
//         //         color: Color(0xFF374151),
//         //         fontWeight: FontWeight.w500,
//         //         fontSize: 12,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         InkWell(
//           onTap: _showEndGameDialog,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEF4444),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'End Game',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSetBasedScorecard() {
//     final canEndSet = _canEndCurrentSet();
//     final statusMessage = _getSetStatusMessage();

//     return Column(
//       children: [
//         const SizedBox(height: 16),
//         _buildSetInfo(),
//         const SizedBox(height: 12),
//         // Status message
//         if (statusMessage.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: canEndSet ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: canEndSet ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   canEndSet ? Icons.check_circle : Icons.info,
//                   color: canEndSet ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     statusMessage,
//                     style: TextStyle(
//                       color: canEndSet ? const Color(0xFF065F46) : const Color(0xFF92400E),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: participants.map((participant) {
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: const Color(0xFFE5E7EB)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: _buildSetParticipantCard(participant),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ElevatedButton(
//             onPressed: canEndSet ? _endCurrentSet : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: canEndSet ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               canEndSet ? 'End Current Set' : 'Reach Set Point to Continue',
//               style: TextStyle(
//                 color: canEndSet ? Colors.white : const Color(0xFF9CA3AF),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildSetParticipantCard(String participant) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF10B981).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${scores[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Points',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//             const Text(
//               '/',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Color(0xFF9CA3AF),
//               ),
//             ),
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF3B82F6),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF3B82F6).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${setsWon[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Sets Won',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEF4444),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFFEF4444).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: () => _decrementScore(participant),
//                 icon: const Icon(Icons.remove, color: Colors.white, size: 20),
//               ),
//             ),
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF10B981),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF10B981).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: () => _incrementScore(participant),
//                 icon: const Icon(Icons.add, color: Colors.white, size: 20),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTimer() {
//     return StreamBuilder(
//       stream: Stream.periodic(const Duration(seconds: 1)),
//       builder: (context, snapshot) {
//         final elapsed = totalElapsedTime;
//         final minutes = elapsed.inMinutes;
//         final seconds = elapsed.inSeconds % 60;

//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1F2937),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Match Time',
//                     style: TextStyle(
//                       color: Color(0xFF9CA3AF),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         if (stopwatch.isRunning) {
//                           stopwatch.stop();
//                         } else {
//                           stopwatch.start();
//                         }
//                       });
//                     },
//                     icon: Icon(
//                       stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         stopwatch.reset();
//                         initialElapsedTime = Duration.zero;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.refresh,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSetInfo() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.sports_tennis,
//             color: const Color(0xFF3B82F6),
//             size: 20,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             'Set $currentSet | First to $pointsPerSet (Win by $winBy)',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _incrementScore(String participant) async {
//     final participantIndex = participants.indexOf(participant);
//     if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//     setState(() {
//       scores[participant] = (scores[participant] ?? 0) + 1;
//     });

//     // Update via API
//     try {
//       await MatchApiService.updateBadmintonScore(
//         widget.matchId,
//         teamIds[participantIndex],
//         playerIds[participantIndex],
//         1,
//         'inc',
//       );
//     } catch (e) {
//       print('Error incrementing score: $e');
//       // Revert on error
//       setState(() {
//         scores[participant] = (scores[participant] ?? 1) - 1;
//       });
//     }
//   }

//   void _decrementScore(String participant) async {
//     if ((scores[participant] ?? 0) > 0) {
//       final participantIndex = participants.indexOf(participant);
//       if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//       setState(() {
//         scores[participant] = (scores[participant] ?? 0) - 1;
//       });

//       // Update via API
//       try {
//         await MatchApiService.updateBadmintonScore(
//           widget.matchId,
//           teamIds[participantIndex],
//           playerIds[participantIndex],
//           1,
//           'dec',
//         );
//       } catch (e) {
//         print('Error decrementing score: $e');
//         // Revert on error
//         setState(() {
//           scores[participant] = (scores[participant] ?? 0) + 1;
//         });
//       }
//     }
//   }

//   void _endCurrentSet() async {
//     if (!_canEndCurrentSet()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Cannot end set yet. Reach set point first.')),
//       );
//       return;
//     }

//     // Determine set winner
//     String setWinner = '';
//     int highestScore = 0;

//     scores.forEach((participant, score) {
//       if (score > highestScore) {
//         highestScore = score;
//         setWinner = participant;
//       }
//     });

//     final nextSet = currentSet + 1;

//     // Update current set via API
//     try {
//       await MatchApiService.updateCurrentSet(widget.matchId, nextSet);
      
//       setState(() {
//         if (setWinner.isNotEmpty) {
//           setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
//         }

//         // Check if match is won before moving to next set
//         bool matchWon = false;
//         setsWon.forEach((participant, sets) {
//           if (sets >= setsToWin) {
//             matchWon = true;
//           }
//         });

//         if (matchWon) {
//           _checkSetWinCondition();
//         } else {
//           // Reset scores for next set
//           scores = {for (String participant in participants) participant: 0};
//           currentSet = nextSet;
//         }
//       });

//       if (!isMatchEnded) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Set $currentSet-1 completed! $setWinner won the set.')),
//         );
//       }
//     } catch (e) {
//       print('Error ending current set: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to end set: $e')),
//       );
//     }
//   }

//   void _checkSetWinCondition() {
//     // Check if any participant has won enough sets (majority)
//     String? winner;
//     setsWon.forEach((participant, sets) {
//       if (sets >= setsToWin) {
//         winner = participant;
//       }
//     });

//     if (winner != null) {
//       _endGame(winner!);
//     }
//   }

//   void _endGame(String winner) async {
//     setState(() {
//       isMatchEnded = true;
//       matchWinner = winner;
//     });

//     stopwatch.stop();

//     // Update API to finish match
//     try {
//       await MatchApiService.finishMatch(widget.matchId);
      
//       // Navigate to summary after successful API call
//       _navigateToSummary();
//     } catch (e) {
//       print('Error finishing match: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to finish match: $e')),
//       );
//     }
//   }

//   void _navigateToSummary() {
//     final gameResult = isMatchEnded
//         ? (matchWinner.isNotEmpty ? '$matchWinner Wins!' : 'Draw!')
//         : 'Game Ended';

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GameSummaryScreen(
//           sportName: sportName,
//           participants: participants,
//           finalScores: scores,
//           setsWon: setsWon,
//           gameDuration: totalElapsedTime,
//           gameResult: gameResult,
//           matchId: widget.matchId,
//         ),
//       ),
//     );
//   }

//   void _showEndGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'End Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to end this game? This action cannot be undone.',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _endGame('');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEF4444),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'End Game',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showNewGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'New Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to start a new game? Current progress will be lost.',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 context.read<GameProvider>().updateMatchStatus(widget.matchId, "completed");
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => ViewMatchScreen()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3B82F6),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'New Game',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }














// import 'package:booking_application/views/Games/GameViews/create_games.dart';
// import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
// import 'package:booking_application/views/Games/sport_congig.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   // Fetch single match data
//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglebatmintonmatch/$matchId'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['match'];
//       } else {
//         throw Exception('Failed to load match data');
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       rethrow;
//     }
//   }

//   // Update badminton match (increment/decrement points)
//   static Future<void> updateBadmintonScore(
//     String matchId,
//     String teamId,
//     String playerId,
//     int points,
//     String action, // 'inc' or 'dec'
//   ) async {
//     try {
//       final payload = {
//         "teamId": teamId,
//         "playerId": playerId,
//         "points": points,
//         "action": action,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update badminton score');
//       }
//     } catch (e) {
//       print('Error updating badminton score: $e');
//       rethrow;
//     }
//   }

//   // Update current set and points per set
//   static Future<void> updateCurrentSetAndPoints(
//     String matchId,
//     int currentSet,
//     int pointsPerSet,
//   ) async {
//     try {
//       final payload = {
//         "currentSet": currentSet,
//         "pointPerSet": pointsPerSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update current set and points');
//       }
//     } catch (e) {
//       print('Error updating current set and points: $e');
//       rethrow;
//     }
//   }

//   // Update points per set only
//   static Future<void> updatePointsPerSet(
//     String matchId,
//     int pointsPerSet,
//   ) async {
//     try {
//       final payload = {
//         "pointPerSet": pointsPerSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update points per set');
//       }
//     } catch (e) {
//       print('Error updating points per set: $e');
//       rethrow;
//     }
//   }

//   // Finish match
//   static Future<void> finishMatch(String matchId) async {
//     try {
//       final payload = {
//         "Status": "finished",
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to finish match');
//       }
//     } catch (e) {
//       print('Error finishing match: $e');
//       rethrow;
//     }
//   }

//   // Cancel match
//   static Future<bool> cancelMatch(String matchId, String reason) async {
//     try {
//       final payload = {
//         "reason": reason,
//         "Status": "cancel",
//       };

//      print("Payload: ${jsonEncode(payload)}");

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       print("Response status: ${response.statusCode}");

//       if (response.statusCode != 200) {
//         return false;
//       }else{
//         return true;
//       }
//     } catch (e) {
//       print('Error canceling match: $e');
//       rethrow;
//     }
//   }

//   // Legacy update match status (kept for compatibility)
//   static Future<void> updateMatchStatus(
//     String userId,
//     String matchId,
//     Map<String, dynamic> payload,
//   ) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/users/footballstatus/$userId/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update match status');
//       }
//     } catch (e) {
//       print('Error updating match status: $e');
//       rethrow;
//     }
//   }
// }

// // Socket Service Class
// class SocketService {
//   static IO.Socket? socket;
//   static const String socketUrl = 'http://31.97.206.144:3081';

//   static void initSocket() {
//     socket = IO.io(socketUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     socket?.on('connect', (_) {
//       print('Socket connected: ${socket?.id}');
//     });

//     socket?.on('disconnect', (_) {
//       print('Socket disconnected');
//     });
//   }

//   static void joinMatch(String matchId) {
//     socket?.emit('join-match', matchId);
//     print('Joined match room: $matchId');
//   }

//   // Listen to badminton match fetched event
//   static void listenToBadmintonMatchFetched(Function(Map<String, dynamic>) callback) {
//     socket?.on('badminton:match:fetched', (data) {
//       print('Badminton match fetched: $data');
//       callback(data);
//     });
//   }

//   // Listen to badminton match updated event
//   static void listenToBadmintonMatchUpdated(Function(Map<String, dynamic>) callback) {
//     socket?.on('badminton:match:updated', (data) {
//       print('Badminton match updated: $data');
//       callback(data);
//     });
//   }

//   // Legacy listeners (keeping for backward compatibility)
//   static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('liveScoreUpdate', (data) {
//       print('Live score update received: $data');
//       callback(data);
//     });
//   }

//   static void listenToSingleMatchData(Function(Map<String, dynamic>) callback) {
//     socket?.on('singleMatchData', (data) {
//       print('Single match data received: $data');
//       callback(data);
//     });
//   }

//   static void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//   }
// }

// // Game Summary Screen for displaying final results
// class GameSummaryScreen extends StatelessWidget {
//   final String sportName;
//   final List<String> participants;
//   final Map<String, int> finalScores;
//   final Map<String, int> setsWon;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.sportName,
//     required this.participants,
//     required this.finalScores,
//     required this.setsWon,
//     required this.gameDuration,
//     required this.gameResult,
//     required this.matchId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Game Summary',
//           style: TextStyle(
//             color: Color(0xFF1F2937),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF374151)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Game result header
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: gameResult.contains('Draw') ? const Color(0xFFF3F4F6) : const Color(0xFFDCFCE7),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: gameResult.contains('Draw') ? const Color(0xFFE5E7EB) : const Color(0xFF10B981),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     gameResult.contains('Draw') ? Icons.handshake : Icons.emoji_events,
//                     size: 48,
//                     color: gameResult.contains('Draw') ? const Color(0xFF6B7280) : const Color(0xFF10B981),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     gameResult,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$sportName Match',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Sets Won Display
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8FAFC),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE2E8F0)),
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Final Sets',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...participants.map((participant) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           participant,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF374151),
//                           ),
//                         ),
//                         Text(
//                           '${setsWon[participant] ?? 0} sets',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF3B82F6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<GameProvider>().updateMatchStatus(matchId, "completed");
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     child: const Text(
//                       'New Game',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Scorecard Screen with Set-Based Scoring
// class SetBasedScreen extends StatefulWidget {
//   final String matchId;

//   const SetBasedScreen({
//     super.key,
//     required this.matchId,
//   });

//   @override
//   State<SetBasedScreen> createState() => _SetBasedScreenState();
// }

// class _SetBasedScreenState extends State<SetBasedScreen> {
//   late Map<String, int> scores;
//   late Map<String, int> setsWon;
//   late bool isMatchEnded;
//   late String matchWinner;
//   late Stopwatch stopwatch;
//   late int currentSet;
//   late Duration initialElapsedTime;
//   late int setsToWin;
//   late int pointsPerSet;
//   late int winBy;
//   late bool allowDeuce;
//   late int maxDeucePoint;

//   // API related fields
//   Map<String, dynamic>? matchData;
//   bool isLoading = true;
//   List<String> teamIds = [];
//   List<String> playerIds = [];
//   List<String> participants = [];
//   String userId = '';
//   String sportName = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeSocket();
//     _fetchMatchData();
//   }

//   void _initializeSocket() {
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);

//     // Listen to badminton match fetched event
//     SocketService.listenToBadmintonMatchFetched((data) {
//       if (mounted) {
//         print('Received badminton:match:fetched event');
//         final match = data['match'];
        
//         if (match != null) {
//           setState(() {
//             matchData = match;
//             _updateFromMatchData();
//           });
//         }
//       }
//     });

//     // Listen to badminton match updated event
//     SocketService.listenToBadmintonMatchUpdated((updatedMatch) {
//       if (mounted) {
//         print('Received badminton:match:updated event');
//         setState(() {
//           matchData = updatedMatch;
//           _updateFromMatchData();
//           _updateScoresFromMatchData();
//         });
//       }
//     });

//     // Legacy listeners for backward compatibility
//     SocketService.listenToLiveScoreUpdate((data) {
//       if (mounted) {
//         setState(() {
//           if (data['teamScores'] != null) {
//             _updateScoresFromSocket(data['teamScores']);
//           }
//         });
//       }
//     });

//     SocketService.listenToSingleMatchData((data) {
//       if (mounted) {
//         setState(() {
//           matchData = data['match'];
//           _updateFromMatchData();
//         });
//       }
//     });
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           isLoading = false;
//           _initializeGameFromApi();
//         });
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading match data: $e')),
//         );
//       }
//     }
//   }

//   void _initializeGameFromApi() {
//     if (matchData == null) return;

//     // Extract userId
//     if (matchData!['createdBy'] != null) {
//       userId = matchData!['createdBy']['_id'] ?? '';
//     }

//     // Extract sport name
//     if (matchData!['categoryId'] != null) {
//       sportName = matchData!['categoryId']['name'] ?? 'Match';
//     }

//     // Extract match settings
//     pointsPerSet = matchData!['pointsPerSet'] ?? 21;
//     winBy = matchData!['winBy'] ?? 2;
//     allowDeuce = matchData!['allowDeuce'] ?? true;
//     maxDeucePoint = matchData!['maxDeucePoint'] ?? 30;

//     // Extract team IDs, player IDs, and create participant names
//     if (matchData!['teams'] != null) {
//       final teams = matchData!['teams'] as List;
//       teamIds = teams.map((team) => team['teamId'].toString()).toList();
      
//       playerIds = [];
//       participants = [];
      
//       for (var team in teams) {
//         String teamName = team['teamName'] ?? 'Team ${participants.length + 1}';
//         participants.add(teamName);
        
//         if (team['players'] != null && (team['players'] as List).isNotEmpty) {
//           final firstPlayer = (team['players'] as List)[0];
//           playerIds.add(firstPlayer['playerId'].toString());
//         } else {
//           playerIds.add('');
//         }
//       }
//     }

//     // Initialize scores from current set data
//     _initializeScoresFromSets();

//     // Get setsToWin from scoringTemplate or totalSets
//     if (matchData!['scoringTemplate'] != null) {
//       setsToWin = matchData!['scoringTemplate']['setsToWin'] ?? 2;
//     } else {
//       final totalSets = matchData!['totalSets'] ?? 3;
//       setsToWin = (totalSets / 2).ceil();
//     }

//     currentSet = matchData!['currentSet'] ?? 1;
//     isMatchEnded = matchData!['status'] == 'finished';
//     matchWinner = '';

//     // Initialize time
//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     stopwatch = Stopwatch();
//     if (matchData!['status'] == 'live') {
//       stopwatch.start();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//       });
//     }
//   }

//   void _initializeScoresFromSets() {
//     scores = {for (String participant in participants) participant: 0};
//     setsWon = {for (String participant in participants) participant: 0};

//     if (matchData!['sets'] != null) {
//       final sets = matchData!['sets'] as List;
      
//       // Get current set scores
//       if (sets.isNotEmpty && matchData!['currentSet'] != null) {
//         final currentSetIndex = (matchData!['currentSet'] as int) - 1;
//         if (currentSetIndex < sets.length) {
//           final currentSetData = sets[currentSetIndex];
//           if (currentSetData['score'] != null) {
//             final score = currentSetData['score'];
//             if (score['teamA'] != null && participants.isNotEmpty) {
//               scores[participants[0]] = score['teamA']['score'] ?? 0;
//             }
//             if (score['teamB'] != null && participants.length > 1) {
//               scores[participants[1]] = score['teamB']['score'] ?? 0;
//             }
//           }
//         }
//       }

//       // Count sets won by each team
//       for (var set in sets) {
//         if (set['winner'] != null) {
//           String? winnerName = set['winner'];
//           if (winnerName != null && setsWon.containsKey(winnerName)) {
//             setsWon[winnerName] = (setsWon[winnerName] ?? 0) + 1;
//           }
//         }
//       }
//     }

//     // Also check finalScore for sets won
//     if (matchData!['finalScore'] != null) {
//       final finalScore = matchData!['finalScore'];
//       if (finalScore['teamA'] != null && participants.isNotEmpty) {
//         setsWon[participants[0]] = finalScore['teamA']['score'] ?? 0;
//       }
//       if (finalScore['teamB'] != null && participants.length > 1) {
//         setsWon[participants[1]] = finalScore['teamB']['score'] ?? 0;
//       }
//     }
//   }

//   void _updateScoresFromSocket(Map<String, dynamic> teamScores) {
//     teamScores.forEach((teamId, score) {
//       final index = teamIds.indexOf(teamId);
//       if (index >= 0 && index < participants.length) {
//         scores[participants[index]] = score;
//       }
//     });
//   }

//   void _updateScoresFromMatchData() {
//     if (matchData == null) return;

//     // Update scores from sets
//     _initializeScoresFromSets();
//   }

//   void _updateFromMatchData() {
//     if (matchData == null) return;

//     final status = matchData!['status'] ?? 'live';
//     isMatchEnded = status == 'finished';

//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     currentSet = matchData!['currentSet'] ?? currentSet;
//     pointsPerSet = matchData!['pointsPerSet'] ?? pointsPerSet;
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     SocketService.dispose();
//     super.dispose();
//   }

//   Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

//   // Check if current set can be ended
//   bool _canEndCurrentSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Check if we need to adjust pointsPerSet due to deuce
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       // Both players have reached deuce threshold
//       final maxScore = score1 > score2 ? score1 : score2;
      
//       // If scores are equal and below maxDeucePoint, we need to increase pointsPerSet
//       if (score1 == score2 && score1 < maxDeucePoint) {
//         return false; // Cannot end set until pointsPerSet is adjusted
//       }
      
//       // Check if someone has reached the adjusted pointsPerSet with winBy advantage
//       if (maxScore >= pointsPerSet && (score1 - score2).abs() >= winBy) {
//         return true;
//       }
      
//       // Check if maxDeucePoint is reached
//       if (maxScore >= maxDeucePoint) {
//         return true;
//       }
      
//       return false;
//     }

//     // Normal scenario: check if any team has reached pointsPerSet with winBy advantage
//     if ((score1 >= pointsPerSet || score2 >= pointsPerSet) && (score1 - score2).abs() >= winBy) {
//       return true;
//     }

//     return false;
//   }

//   // Check if we need to adjust pointsPerSet due to deuce
//   bool _needToAdjustPointsPerSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Check if both players have reached deuce threshold and scores are equal
//     if (allowDeuce && 
//         score1 >= (pointsPerSet - 1) && 
//         score2 >= (pointsPerSet - 1) && 
//         score1 == score2 && 
//         score1 < maxDeucePoint) {
//       return true;
//     }

//     return false;
//   }

//   String _getSetStatusMessage() {
//     if (scores.isEmpty || participants.length < 2) return '';

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;
//     final diff = (score1 - score2).abs();
//     final maxScore = score1 > score2 ? score1 : score2;

//     if (_needToAdjustPointsPerSet()) {
//       return 'Deuce! Adjust points per set to ${pointsPerSet + 1} to continue';
//     }

//     if (maxScore < pointsPerSet) {
//       return 'First to $pointsPerSet points wins';
//     }

//     // Deuce scenario
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       if (maxScore >= maxDeucePoint) {
//         return 'Maximum deuce point reached!';
//       }
//       return 'Deuce! Need to win by $winBy (Max: $maxDeucePoint)';
//     }

//     if (diff < winBy) {
//       return 'Need to win by $winBy points';
//     }

//     return 'Set point reached!';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF3B82F6),
//           ),
//         ),
//       );
//     }

//     if (matchData == null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text('Error'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 64, color: Colors.red),
//               SizedBox(height: 16),
//               Text('Failed to load match data'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Go Back'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _buildSetBasedScorecard(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '$sportName Match',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       participants.join(' vs '),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 2),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFEF4444),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Text(
//                         'LIVE',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               _buildActionButtons(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         if (_needToAdjustPointsPerSet())
//           InkWell(
//             onTap: _adjustPointsPerSet,
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF59E0B),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Text(
//                 'Adjust Points',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//         InkWell(
//           onTap: _showEndGameOptions,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEF4444),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'End Game',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSetBasedScorecard() {
//     final canEndSet = _canEndCurrentSet();
//     final needAdjustPoints = _needToAdjustPointsPerSet();
//     final statusMessage = _getSetStatusMessage();

//     return Column(
//       children: [
//         const SizedBox(height: 16),
//         _buildSetInfo(),
//         const SizedBox(height: 12),
//         // Status message
//         if (statusMessage.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: canEndSet ? const Color(0xFFDCFCE7) : 
//                      needAdjustPoints ? const Color(0xFFFEF3C7) : const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: canEndSet ? const Color(0xFF10B981) : 
//                        needAdjustPoints ? const Color(0xFFF59E0B) : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   canEndSet ? Icons.check_circle : 
//                   needAdjustPoints ? Icons.warning : Icons.info,
//                   color: canEndSet ? const Color(0xFF10B981) : 
//                          needAdjustPoints ? const Color(0xFFF59E0B) : const Color(0xFF6B7280),
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     statusMessage,
//                     style: TextStyle(
//                       color: canEndSet ? const Color(0xFF065F46) : 
//                              needAdjustPoints ? const Color(0xFF92400E) : const Color(0xFF374151),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: participants.map((participant) {
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: const Color(0xFFE5E7EB)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: _buildSetParticipantCard(participant),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ElevatedButton(
//             onPressed: canEndSet && !needAdjustPoints ? _endCurrentSet : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: canEndSet && !needAdjustPoints ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               needAdjustPoints ? 'Adjust Points to Continue' : 
//               canEndSet ? 'End Current Set' : 'Reach Set Point to Continue',
//               style: TextStyle(
//                 color: canEndSet && !needAdjustPoints ? Colors.white : const Color(0xFF9CA3AF),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildSetParticipantCard(String participant) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF10B981).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${scores[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Points',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//             const Text(
//               '/',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Color(0xFF9CA3AF),
//               ),
//             ),
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF3B82F6),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF3B82F6).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${setsWon[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Sets Won',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEF4444),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFFEF4444).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: () => _decrementScore(participant),
//                 icon: const Icon(Icons.remove, color: Colors.white, size: 20),
//               ),
//             ),
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF10B981),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF10B981).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: () => _incrementScore(participant),
//                 icon: const Icon(Icons.add, color: Colors.white, size: 20),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTimer() {
//     return StreamBuilder(
//       stream: Stream.periodic(const Duration(seconds: 1)),
//       builder: (context, snapshot) {
//         final elapsed = totalElapsedTime;
//         final minutes = elapsed.inMinutes;
//         final seconds = elapsed.inSeconds % 60;

//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1F2937),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Match Time',
//                     style: TextStyle(
//                       color: Color(0xFF9CA3AF),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         if (stopwatch.isRunning) {
//                           stopwatch.stop();
//                         } else {
//                           stopwatch.start();
//                         }
//                       });
//                     },
//                     icon: Icon(
//                       stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         stopwatch.reset();
//                         initialElapsedTime = Duration.zero;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.refresh,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSetInfo() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.sports_tennis,
//             color: const Color(0xFF3B82F6),
//             size: 20,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             'Set $currentSet | First to $pointsPerSet (Win by $winBy)',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _incrementScore(String participant) async {
//     final participantIndex = participants.indexOf(participant);
//     if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//     setState(() {
//       scores[participant] = (scores[participant] ?? 0) + 1;
//     });

//     // Update via API
//     try {
//       await MatchApiService.updateBadmintonScore(
//         widget.matchId,
//         teamIds[participantIndex],
//         playerIds[participantIndex],
//         1,
//         'inc',
//       );
//     } catch (e) {
//       print('Error incrementing score: $e');
//       // Revert on error
//       setState(() {
//         scores[participant] = (scores[participant] ?? 1) - 1;
//       });
//     }
//   }

//   void _decrementScore(String participant) async {
//     if ((scores[participant] ?? 0) > 0) {
//       final participantIndex = participants.indexOf(participant);
//       if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//       setState(() {
//         scores[participant] = (scores[participant] ?? 0) - 1;
//       });

//       // Update via API
//       try {
//         await MatchApiService.updateBadmintonScore(
//           widget.matchId,
//           teamIds[participantIndex],
//           playerIds[participantIndex],
//           1,
//           'dec',
//         );
//       } catch (e) {
//         print('Error decrementing score: $e');
//         // Revert on error
//         setState(() {
//           scores[participant] = (scores[participant] ?? 0) + 1;
//         });
//       }
//     }
//   }

//   void _adjustPointsPerSet() async {
//     if (!_needToAdjustPointsPerSet()) return;

//     final newPointsPerSet = pointsPerSet + 1;

//     try {
//       await MatchApiService.updatePointsPerSet(widget.matchId, newPointsPerSet);
      
//       setState(() {
//         pointsPerSet = newPointsPerSet;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Points per set adjusted to $newPointsPerSet')),
//       );
//     } catch (e) {
//       print('Error adjusting points per set: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to adjust points: $e')),
//       );
//     }
//   }

//   void _endCurrentSet() async {
//     if (!_canEndCurrentSet() || _needToAdjustPointsPerSet()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Cannot end set yet. Adjust points or reach set point first.')),
//       );
//       return;
//     }

//     // Determine set winner
//     String setWinner = '';
//     int highestScore = 0;

//     scores.forEach((participant, score) {
//       if (score > highestScore) {
//         highestScore = score;
//         setWinner = participant;
//       }
//     });

//     final nextSet = currentSet + 1;

//     // Update current set via API
//     try {
//       await MatchApiService.updateCurrentSetAndPoints(widget.matchId, nextSet, pointsPerSet);
      
//       setState(() {
//         if (setWinner.isNotEmpty) {
//           setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
//         }

//         // Check if match is won before moving to next set
//         bool matchWon = false;
//         setsWon.forEach((participant, sets) {
//           if (sets >= setsToWin) {
//             matchWon = true;
//           }
//         });

//         if (matchWon) {
//           _checkSetWinCondition();
//         } else {
//           // Reset scores for next set and reset pointsPerSet to original
//           scores = {for (String participant in participants) participant: 0};
//           currentSet = nextSet;
//           pointsPerSet = matchData!['pointsPerSet'] ?? 21; // Reset to original
//         }
//       });

//       if (!isMatchEnded) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Set ${currentSet-1} completed! $setWinner won the set.')),
//         );
//       }
//     } catch (e) {
//       print('Error ending current set: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to end set: $e')),
//       );
//     }
//   }

//   void _checkSetWinCondition() {
//     // Check if any participant has won enough sets (majority)
//     String? winner;
//     setsWon.forEach((participant, sets) {
//       if (sets >= setsToWin) {
//         winner = participant;
//       }
//     });

//     if (winner != null) {
//       _endGame(winner!);
//     }
//   }

//   void _endGame(String winner) async {
//     setState(() {
//       isMatchEnded = true;
//       matchWinner = winner;
//     });

//     stopwatch.stop();

//     // Update API to finish match
//     try {
//       await MatchApiService.finishMatch(widget.matchId);
      
//       // Navigate to summary after successful API call
//       _navigateToSummary();
//     } catch (e) {
//       print('Error finishing match: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to finish match: $e')),
//       );
//     }
//   }

//   void _navigateToSummary() {
//     final gameResult = isMatchEnded
//         ? (matchWinner.isNotEmpty ? '$matchWinner Wins!' : 'Draw!')
//         : 'Game Ended';

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GameSummaryScreen(
//           sportName: sportName,
//           participants: participants,
//           finalScores: scores,
//           setsWon: setsWon,
//           gameDuration: totalElapsedTime,
//           gameResult: gameResult,
//           matchId: widget.matchId,
//         ),
//       ),
//     );
//   }

//   void _showEndGameOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'End Game Options',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Choose how you want to end the game:',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showCancelGameDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFEF4444),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text(
//                     'Cancel Game',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showCompleteGameDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF10B981),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text(
//                     'Complete Game',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Back',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showCancelGameDialog() {
//     final TextEditingController reasonController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Cancel Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Please provide a reason for canceling the game:',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: reasonController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter reason...',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//                 maxLines: 3,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Back',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (reasonController.text.trim().isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Please enter a reason')),
//                   );
//                   return;
//                 }

//                 Navigator.of(context).pop();
                
//                 try {
//                   bool result = await MatchApiService.cancelMatch(widget.matchId, reasonController.text.trim());
//                   if(result){
//                     ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Game cancelled successfully')),
//                   );
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                   );
//                   }else{
//                                        ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Can not cancell')),
//                                        );
//                   }
//                 } catch (e) {
//                   print('Error canceling game: $e');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Failed to cancel game: $e')),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEF4444),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'Cancel Game',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showCompleteGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Complete Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to mark this game as completed?',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _endGame('');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF10B981),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'Complete',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }






















// import 'package:booking_application/views/Games/GameViews/create_games.dart';
// import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
// import 'package:booking_application/views/Games/sport_congig.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// // Custom SnackBar for better toast messages
// void showCustomSnackBar(BuildContext context, String message, {bool isError = false}) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       duration: const Duration(seconds: 3),
//     ),
//   );
// }

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   // Fetch single match data
//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglebatmintonmatch/$matchId'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['match'];
//       } else {
//         throw Exception('Failed to load match data');
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       rethrow;
//     }
//   }

//   // Update badminton match (increment/decrement points)
//   static Future<void> updateBadmintonScore(
//     String matchId,
//     String teamId,
//     String playerId,
//     int points,
//     String action, // 'inc' or 'dec'
//   ) async {
//     try {
//       final payload = {
//         "teamId": teamId,
//         "playerId": playerId,
//         "points": points,
//         "action": action,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update badminton score');
//       }
//     } catch (e) {
//       print('Error updating badminton score: $e');
//       rethrow;
//     }
//   }

//   // Update current set and points per set
//   static Future<void> updateCurrentSetAndPoints(
//     String matchId,
//     int currentSet,
//     int pointsPerSet,
//   ) async {
//     try {
//       final payload = {
//         "currentSet": currentSet,
//         "pointPerSet": pointsPerSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update current set and points');
//       }
//     } catch (e) {
//       print('Error updating current set and points: $e');
//       rethrow;
//     }
//   }

//   // Update points per set only
//   static Future<void> updatePointsPerSet(
//     String matchId,
//     int pointsPerSet,
//   ) async {
//     try {
//       final payload = {
//         "pointPerSet": pointsPerSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update points per set');
//       }
//     } catch (e) {
//       print('Error updating points per set: $e');
//       rethrow;
//     }
//   }

//   // Finish match
//   static Future<void> finishMatch(String matchId) async {
//     try {
//       final payload = {
//         "Status": "finished",
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to finish match');
//       }
//     } catch (e) {
//       print('Error finishing match: $e');
//       rethrow;
//     }
//   }

//   // Cancel match
//   static Future<void> cancelMatch(String matchId, String reason) async {
//     try {
//       final payload = {
//         "reason": reason,
//         "Status": "cancel",
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to cancel match');
//       }
//     } catch (e) {
//       print('Error canceling match: $e');
//       rethrow;
//     }
//   }
// }

// // Socket Service Class
// class SocketService {
//   static IO.Socket? socket;
//   static const String socketUrl = 'http://31.97.206.144:3081';

//   static void initSocket() {
//     socket = IO.io(socketUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     socket?.on('connect', (_) {
//       print('Socket connected: ${socket?.id}');
//     });

//     socket?.on('disconnect', (_) {
//       print('Socket disconnected');
//     });
//   }

//   static void joinMatch(String matchId) {
//     socket?.emit('join-match', matchId);
//     print('Joined match room: $matchId');
//   }

//   // Listen to badminton match fetched event
//   static void listenToBadmintonMatchFetched(Function(Map<String, dynamic>) callback) {
//     socket?.on('badminton:match:fetched', (data) {
//       print('Badminton match fetched: $data');
//       callback(data);
//     });
//   }

//   // Listen to badminton match updated event
//   static void listenToBadmintonMatchUpdated(Function(Map<String, dynamic>) callback) {
//     socket?.on('badminton:match:updated', (data) {
//       print('Badminton match updated: $data');
//       callback(data);
//     });
//   }

//   static void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//   }
// }

// // Game Summary Screen for displaying final results
// class GameSummaryScreen extends StatelessWidget {
//   final String sportName;
//   final List<String> participants;
//   final Map<String, int> finalScores;
//   final Map<String, int> setsWon;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.sportName,
//     required this.participants,
//     required this.finalScores,
//     required this.setsWon,
//     required this.gameDuration,
//     required this.gameResult,
//     required this.matchId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Game Summary',
//           style: TextStyle(
//             color: Color(0xFF1F2937),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF374151)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Game result header
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: gameResult.contains('Draw') ? const Color(0xFFF3F4F6) : const Color(0xFFDCFCE7),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: gameResult.contains('Draw') ? const Color(0xFFE5E7EB) : const Color(0xFF10B981),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     gameResult.contains('Draw') ? Icons.handshake : Icons.emoji_events,
//                     size: 48,
//                     color: gameResult.contains('Draw') ? const Color(0xFF6B7280) : const Color(0xFF10B981),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     gameResult,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$sportName Match',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Sets Won Display
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8FAFC),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE2E8F0)),
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Final Sets',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...participants.map((participant) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           participant,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF374151),
//                           ),
//                         ),
//                         Text(
//                           '${setsWon[participant] ?? 0} sets',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF3B82F6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<GameProvider>().updateMatchStatus(matchId, "completed");
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     child: const Text(
//                       'New Game',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Set Completion Modal
// class SetCompletionModal extends StatelessWidget {
//   final String setWinner;
//   final int setNumber;
//   final Function() onContinue;

//   const SetCompletionModal({
//     super.key,
//     required this.setWinner,
//     required this.setNumber,
//     required this.onContinue,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.emoji_events,
//               size: 64,
//               color: const Color(0xFFF59E0B),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Set $setNumber Completed!',
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '$setWinner won the set',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: onContinue,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF3B82F6),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   'Continue to Next Set',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Match Completion Modal
// class MatchCompletionModal extends StatelessWidget {
//   final String matchWinner;
//   final Function() onFinish;

//   const MatchCompletionModal({
//     super.key,
//     required this.matchWinner,
//     required this.onFinish,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.emoji_events,
//               size: 64,
//               color: const Color(0xFF10B981),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Match Completed!',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '$matchWinner Wins the Match!',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: onFinish,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF10B981),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   'View Summary',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Adjust Points Modal
// class AdjustPointsModal extends StatefulWidget {
//   final int currentPointsPerSet;
//   final int maxDeucePoint;
//   final Function(int) onAdjust;

//   const AdjustPointsModal({
//     super.key,
//     required this.currentPointsPerSet,
//     required this.maxDeucePoint,
//     required this.onAdjust,
//   });

//   @override
//   State<AdjustPointsModal> createState() => _AdjustPointsModalState();
// }

// class _AdjustPointsModalState extends State<AdjustPointsModal> {
//   late int selectedPoints;
//   final TextEditingController _customPointsController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     selectedPoints = widget.currentPointsPerSet + 1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.tune,
//               size: 48,
//               color: Color(0xFF3B82F6),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Adjust Points Per Set',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Deuce detected! Please adjust the points per set to continue.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Quick selection buttons
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 for (int points = widget.currentPointsPerSet + 1; 
//                      points <= widget.maxDeucePoint; 
//                      points++)
//                   ChoiceChip(
//                     label: Text('$points points'),
//                     selected: selectedPoints == points,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedPoints = points;
//                       });
//                     },
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Custom input
//             TextField(
//               controller: _customPointsController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Custom Points',
//                 hintText: 'Enter points...',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.check),
//                   onPressed: () {
//                     final customPoints = int.tryParse(_customPointsController.text);
//                     if (customPoints != null && 
//                         customPoints > widget.currentPointsPerSet && 
//                         customPoints <= widget.maxDeucePoint) {
//                       setState(() {
//                         selectedPoints = customPoints;
//                       });
//                     }
//                   },
//                 ),
//               ),
//               onChanged: (value) {
//                 final points = int.tryParse(value);
//                 if (points != null && points > widget.currentPointsPerSet && points <= widget.maxDeucePoint) {
//                   setState(() {
//                     selectedPoints = points;
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Color(0xFF6B7280)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       widget.onAdjust(selectedPoints);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       'Adjust',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Scorecard Screen with Set-Based Scoring
// class SetBasedScreen extends StatefulWidget {
//   final String matchId;

//   const SetBasedScreen({
//     super.key,
//     required this.matchId,
//   });

//   @override
//   State<SetBasedScreen> createState() => _SetBasedScreenState();
// }

// class _SetBasedScreenState extends State<SetBasedScreen> {
//   late Map<String, int> scores;
//   late Map<String, int> setsWon;
//   late bool isMatchEnded;
//   late String matchWinner;
//   late Stopwatch stopwatch;
//   late int currentSet;
//   late Duration initialElapsedTime;
//   late int setsToWin;
//   late int pointsPerSet;
//   late int winBy;
//   late bool allowDeuce;
//   late int maxDeucePoint;
//   late int totalSets;

//   // API related fields
//   Map<String, dynamic>? matchData;
//   bool isLoading = true;
//   List<String> teamIds = [];
//   List<String> playerIds = [];
//   List<String> participants = [];
//   String userId = '';
//   String sportName = '';

//   // Button state management
//   bool _isButtonDisabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeSocket();
//     _fetchMatchData();
//   }

//   void _initializeSocket() {
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);

//     SocketService.listenToBadmintonMatchFetched((data) {
//       if (mounted) {
//         print('Received badminton:match:fetched event');
//         final match = data['match'];
        
//         if (match != null) {
//           setState(() {
//             matchData = match;
//             _updateFromMatchData();
//           });
//         }
//       }
//     });

//     SocketService.listenToBadmintonMatchUpdated((updatedMatch) {
//       if (mounted) {
//         print('Received badminton:match:updated event');
//         setState(() {
//           matchData = updatedMatch;
//           _updateFromMatchData();
//           _updateScoresFromMatchData();
//         });
//       }
//     });
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           isLoading = false;
//           _initializeGameFromApi();
//         });
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//         showCustomSnackBar(context, 'Error loading match data: $e', isError: true);
//       }
//     }
//   }

//   // void _initializeGameFromApi() {
//   //   if (matchData == null) return;

//   //   // Extract userId
//   //   if (matchData!['createdBy'] != null) {
//   //     userId = matchData!['createdBy']['_id'] ?? '';
//   //   }

//   //   // Extract sport name
//   //   if (matchData!['categoryId'] != null) {
//   //     sportName = matchData!['categoryId']['name'] ?? 'Match';
//   //   }

//   //   // Extract match settings
//   //   pointsPerSet = matchData!['pointsPerSet'] ?? 21;
//   //   winBy = matchData!['winBy'] ?? 2;
//   //   allowDeuce = matchData!['allowDeuce'] ?? true;
//   //   maxDeucePoint = matchData!['maxDeucePoint'] ?? 30;
//   //   totalSets = matchData!['totalSets'] ?? 3;

//   //   // Extract team IDs, player IDs, and create participant names
//   //   if (matchData!['teams'] != null) {
//   //     final teams = matchData!['teams'] as List;
//   //     teamIds = teams.map((team) => team['teamId'].toString()).toList();
      
//   //     playerIds = [];
//   //     participants = [];
      
//   //     for (var team in teams) {
//   //       String teamName = team['teamName'] ?? 'Team ${participants.length + 1}';
//   //       participants.add(teamName);
        
//   //       if (team['players'] != null && (team['players'] as List).isNotEmpty) {
//   //         final firstPlayer = (team['players'] as List)[0];
//   //         playerIds.add(firstPlayer['playerId'].toString());
//   //       } else {
//   //         playerIds.add('');
//   //       }
//   //     }
//   //   }

//   //   // Initialize scores from current set data
//   //   _initializeScoresFromSets();

//   //   // Get setsToWin from scoringTemplate or totalSets
//   //   if (matchData!['scoringTemplate'] != null) {
//   //     setsToWin = matchData!['scoringTemplate']['setsToWin'] ?? 2;
//   //   } else {
//   //     setsToWin = (totalSets / 2).ceil();
//   //   }

//   //   currentSet = matchData!['currentSet'] ?? 1;
//   //   isMatchEnded = matchData!['status'] == 'finished';
//   //   matchWinner = '';

//   //   // Initialize time
//   //   final timeElapsed = matchData!['timeElapsed'] ?? 0;
//   //   initialElapsedTime = Duration(minutes: timeElapsed);

//   //   stopwatch = Stopwatch();
//   //   if (matchData!['status'] == 'live') {
//   //     stopwatch.start();
//   //     WidgetsBinding.instance.addPostFrameCallback((_) {
//   //       context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//   //     });
//   //   }
//   // }


//   void _initializeGameFromApi() {
//   if (matchData == null) return;

//   // Extract userId
//   if (matchData!['createdBy'] != null) {
//     userId = matchData!['createdBy']['_id'] ?? '';
//   }

//   // Extract sport name
//   if (matchData!['categoryId'] != null) {
//     sportName = matchData!['categoryId']['name'] ?? 'Match';
//   }

//   // Extract match settings
//   pointsPerSet = matchData!['pointsPerSet'] ?? 21;
//   winBy = matchData!['winBy'] ?? 2;
//   allowDeuce = matchData!['allowDeuce'] ?? true;
//   maxDeucePoint = matchData!['maxDeucePoint'] ?? 30;
//   totalSets = matchData!['totalSets'] ?? 3;

//   // Extract team IDs, player IDs, and create participant names
//   final isTeamMatch = matchData!['isTeamMatch'] ?? false;
//   teamIds = [];
//   playerIds = [];
//   participants = [];

//   if (isTeamMatch) {
//     // Team match structure
//     if (matchData!['teams'] != null) {
//       final teams = matchData!['teams'] as List;
//       teamIds = teams.map((team) => team['teamId'].toString()).toList();
      
//       for (var team in teams) {
//         String teamName = team['teamName'] ?? 'Team ${participants.length + 1}';
//         participants.add(teamName);
        
//         if (team['players'] != null && (team['players'] as List).isNotEmpty) {
//           final firstPlayer = (team['players'] as List)[0];
//           playerIds.add(firstPlayer['playerId'].toString());
//         } else {
//           playerIds.add('');
//         }
//       }
//     }
//   } else {
//     // Single player match structure
//     if (matchData!['teams'] != null) {
//       final players = matchData!['teams'] as List;
      
//       for (var player in players) {
//         String playerName = player['playerName'] ?? 'Player ${participants.length + 1}';
//         participants.add(playerName);
//         playerIds.add(player['playerId'].toString());
//         teamIds.add(''); // Single players don't have team IDs
//       }
//     }
//   }

//   // Initialize scores from current set data
//   _initializeScoresFromSets();

//   // Get setsToWin from scoringTemplate or totalSets
//   if (matchData!['scoringTemplate'] != null) {
//     setsToWin = matchData!['scoringTemplate']['setsToWin'] ?? 2;
//   } else {
//     setsToWin = (totalSets / 2).ceil();
//   }

//   currentSet = matchData!['currentSet'] ?? 1;
//   isMatchEnded = matchData!['status'] == 'finished';
//   matchWinner = '';

//   // Initialize time
//   final timeElapsed = matchData!['timeElapsed'] ?? 0;
//   initialElapsedTime = Duration(minutes: timeElapsed);

//   stopwatch = Stopwatch();
//   if (matchData!['status'] == 'live') {
//     stopwatch.start();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//     });
//   }
// }

//   // void _initializeScoresFromSets() {
//   //   scores = {for (String participant in participants) participant: 0};
//   //   setsWon = {for (String participant in participants) participant: 0};

//   //   if (matchData!['sets'] != null) {
//   //     final sets = matchData!['sets'] as List;
      
//   //     // Get current set scores
//   //     if (sets.isNotEmpty && matchData!['currentSet'] != null) {
//   //       final currentSetIndex = (matchData!['currentSet'] as int) - 1;
//   //       if (currentSetIndex < sets.length) {
//   //         final currentSetData = sets[currentSetIndex];
//   //         if (currentSetData['score'] != null) {
//   //           final score = currentSetData['score'];
//   //           if (score['teamA'] != null && participants.isNotEmpty) {
//   //             scores[participants[0]] = score['teamA']['score'] ?? 0;
//   //           }
//   //           if (score['teamB'] != null && participants.length > 1) {
//   //             scores[participants[1]] = score['teamB']['score'] ?? 0;
//   //           }
//   //         }
//   //       }
//   //     }

//   //     // Count sets won by each team
//   //     for (var set in sets) {
//   //       if (set['winner'] != null) {
//   //         String? winnerName = set['winner'];
//   //         if (winnerName != null && setsWon.containsKey(winnerName)) {
//   //           setsWon[winnerName] = (setsWon[winnerName] ?? 0) + 1;
//   //         }
//   //       }
//   //     }
//   //   }

//   //   // Also check finalScore for sets won
//   //   if (matchData!['finalScore'] != null) {
//   //     final finalScore = matchData!['finalScore'];
//   //     if (finalScore['teamA'] != null && participants.isNotEmpty) {
//   //       setsWon[participants[0]] = finalScore['teamA']['score'] ?? 0;
//   //     }
//   //     if (finalScore['teamB'] != null && participants.length > 1) {
//   //       setsWon[participants[1]] = finalScore['teamB']['score'] ?? 0;
//   //     }
//   //   }
//   // }


//   void _initializeScoresFromSets() {
//   scores = {for (String participant in participants) participant: 0};
//   setsWon = {for (String participant in participants) participant: 0};

//   if (matchData!['sets'] != null) {
//     final sets = matchData!['sets'] as List;
//     final isTeamMatch = matchData!['isTeamMatch'] ?? false;
    
//     // Get current set scores
//     if (sets.isNotEmpty && matchData!['currentSet'] != null) {
//       final currentSetIndex = (matchData!['currentSet'] as int) - 1;
//       if (currentSetIndex < sets.length) {
//         final currentSetData = sets[currentSetIndex];
//         if (currentSetData['score'] != null) {
//           final score = currentSetData['score'];
          
//           if (isTeamMatch) {
//             // Team match score structure
//             if (score['teamA'] != null && participants.isNotEmpty) {
//               final teamAScore = score['teamA'];
//               if (teamAScore is Map) {
//                 scores[participants[0]] = teamAScore['score'] ?? 0;
//               }
//             }
//             if (score['teamB'] != null && participants.length > 1) {
//               final teamBScore = score['teamB'];
//               if (teamBScore is Map) {
//                 scores[participants[1]] = teamBScore['score'] ?? 0;
//               }
//             }
//           } else {
//             // Single player match score structure
//             if (score['playerA'] != null && participants.isNotEmpty) {
//               scores[participants[0]] = score['playerA'] ?? 0;
//             }
//             if (score['playerB'] != null && participants.length > 1) {
//               scores[participants[1]] = score['playerB'] ?? 0;
//             }
//           }
//         }
//       }
//     }

//     // Count sets won by each team/player
//     for (var set in sets) {
//       if (set['winner'] != null) {
//         String? winnerName = set['winner'];
//         if (winnerName != null && setsWon.containsKey(winnerName)) {
//           setsWon[winnerName] = (setsWon[winnerName] ?? 0) + 1;
//         }
//       }
//     }
//   }

//   // Also check finalScore for sets won
//   if (matchData!['finalScore'] != null) {
//     final finalScore = matchData!['finalScore'];
//     final isTeamMatch = matchData!['isTeamMatch'] ?? false;
    
//     if (isTeamMatch) {
//       if (finalScore['teamA'] != null && participants.isNotEmpty) {
//         final teamAScore = finalScore['teamA'];
//         if (teamAScore is Map) {
//           setsWon[participants[0]] = teamAScore['score'] ?? 0;
//         }
//       }
//       if (finalScore['teamB'] != null && participants.length > 1) {
//         final teamBScore = finalScore['teamB'];
//         if (teamBScore is Map) {
//           setsWon[participants[1]] = teamBScore['score'] ?? 0;
//         }
//       }
//     } else {
//       // Single player final score structure
//       if (finalScore['teamA'] != null && participants.isNotEmpty) {
//         setsWon[participants[0]] = finalScore['teamA'] ?? 0;
//       }
//       if (finalScore['teamB'] != null && participants.length > 1) {
//         setsWon[participants[1]] = finalScore['teamB'] ?? 0;
//       }
//     }
//   }
// }

//   void _updateScoresFromMatchData() {
//     if (matchData == null) return;
//     _initializeScoresFromSets();
//   }

//   void _updateFromMatchData() {
//     if (matchData == null) return;

//     final status = matchData!['status'] ?? 'live';
//     isMatchEnded = status == 'finished';

//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     currentSet = matchData!['currentSet'] ?? currentSet;
//     pointsPerSet = matchData!['pointsPerSet'] ?? pointsPerSet;
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     SocketService.dispose();
//     super.dispose();
//   }

//   Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

//   // Check if current set can be ended
//   bool _canEndCurrentSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Check if we need to adjust pointsPerSet due to deuce
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       // Both players have reached deuce threshold
//       final maxScore = score1 > score2 ? score1 : score2;
      
//       // If scores are equal and below maxDeucePoint, we need to increase pointsPerSet
//       if (score1 == score2 && score1 < maxDeucePoint) {
//         return false; // Cannot end set until pointsPerSet is adjusted
//       }
      
//       // Check if someone has reached the adjusted pointsPerSet with winBy advantage
//       if (maxScore >= pointsPerSet && (score1 - score2).abs() >= winBy) {
//         return true;
//       }
      
//       // Check if maxDeucePoint is reached
//       if (maxScore >= maxDeucePoint) {
//         return true;
//       }
      
//       return false;
//     }

//     // Normal scenario: check if any team has reached pointsPerSet with winBy advantage
//     if ((score1 >= pointsPerSet || score2 >= pointsPerSet) && (score1 - score2).abs() >= winBy) {
//       return true;
//     }

//     return false;
//   }

//   // Check if we need to adjust pointsPerSet due to deuce
//   bool _needToAdjustPointsPerSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Check if both players have reached deuce threshold and scores are equal
//     if (allowDeuce && 
//         score1 >= (pointsPerSet - 1) && 
//         score2 >= (pointsPerSet - 1) && 
//         score1 == score2 && 
//         score1 < maxDeucePoint) {
//       return true;
//     }

//     return false;
//   }

//   // Check if we're at max deuce point
//   bool _isAtMaxDeucePoint() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     return allowDeuce && 
//            score1 >= (maxDeucePoint - 1) && 
//            score2 >= (maxDeucePoint - 1);
//   }

//   String _getSetStatusMessage() {
//     if (scores.isEmpty || participants.length < 2) return '';

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;
//     final diff = (score1 - score2).abs();
//     final maxScore = score1 > score2 ? score1 : score2;

//     if (_needToAdjustPointsPerSet()) {
//       return 'Deuce! Adjust points per set to continue';
//     }

//     if (_isAtMaxDeucePoint()) {
//       return 'Maximum deuce! First to reach $maxDeucePoint wins';
//     }

//     if (maxScore < pointsPerSet) {
//       return 'First to $pointsPerSet points wins';
//     }

//     // Deuce scenario
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       if (maxScore >= maxDeucePoint) {
//         return 'Maximum deuce point reached!';
//       }
//       return 'Deuce! Need to win by $winBy (Max: $maxDeucePoint)';
//     }

//     if (diff < winBy) {
//       return 'Need to win by $winBy points';
//     }

//     return 'Set point reached!';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF3B82F6),
//           ),
//         ),
//       );
//     }

//     if (matchData == null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text('Error'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 64, color: Colors.red),
//               SizedBox(height: 16),
//               Text('Failed to load match data'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Go Back'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _buildSetBasedScorecard(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '$sportName Match',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       participants.join(' vs '),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 2),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFEF4444),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Text(
//                         'LIVE',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               _buildActionButtons(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     final needAdjustPoints = _needToAdjustPointsPerSet();
    
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         if (needAdjustPoints)
//           InkWell(
//             onTap: _showAdjustPointsModal,
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF59E0B),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Text(
//                 'Adjust Points',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//         InkWell(
//           onTap: _showEndGameOptions,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEF4444),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'End Game',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSetBasedScorecard() {
//     final canEndSet = _canEndCurrentSet();
//     final needAdjustPoints = _needToAdjustPointsPerSet();
//     final isAtMaxDeuce = _isAtMaxDeucePoint();
//     final statusMessage = _getSetStatusMessage();

//     // Determine if buttons should be disabled
//     final shouldDisableButtons = _isButtonDisabled || needAdjustPoints;

//     return Column(
//       children: [
//         const SizedBox(height: 16),
//         _buildSetInfo(),
//         const SizedBox(height: 12),
//         // Status message
//         if (statusMessage.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: canEndSet ? const Color(0xFFDCFCE7) : 
//                      needAdjustPoints ? const Color(0xFFFEF3C7) : 
//                      isAtMaxDeuce ? const Color(0xFFFEE2E2) : const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: canEndSet ? const Color(0xFF10B981) : 
//                        needAdjustPoints ? const Color(0xFFF59E0B) : 
//                        isAtMaxDeuce ? const Color(0xFFEF4444) : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   canEndSet ? Icons.check_circle : 
//                   needAdjustPoints ? Icons.warning : 
//                   isAtMaxDeuce ? Icons.priority_high : Icons.info,
//                   color: canEndSet ? const Color(0xFF10B981) : 
//                          needAdjustPoints ? const Color(0xFFF59E0B) : 
//                          isAtMaxDeuce ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     statusMessage,
//                     style: TextStyle(
//                       color: canEndSet ? const Color(0xFF065F46) : 
//                              needAdjustPoints ? const Color(0xFF92400E) : 
//                              isAtMaxDeuce ? const Color(0xFF991B1B) : const Color(0xFF374151),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: participants.map((participant) {
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: const Color(0xFFE5E7EB)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: _buildSetParticipantCard(participant, shouldDisableButtons),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ElevatedButton(
//             onPressed: canEndSet && !needAdjustPoints ? _endCurrentSet : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: canEndSet && !needAdjustPoints ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               needAdjustPoints ? 'Adjust Points to Continue' : 
//               canEndSet ? 'End Current Set' : 'Reach Set Point to Continue',
//               style: TextStyle(
//                 color: canEndSet && !needAdjustPoints ? Colors.white : const Color(0xFF9CA3AF),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildSetParticipantCard(String participant, bool buttonsDisabled) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF10B981).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${scores[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Points',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//             const Text(
//               '/',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Color(0xFF9CA3AF),
//               ),
//             ),
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF3B82F6),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF3B82F6).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${setsWon[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Sets Won',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444)).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: buttonsDisabled ? null : () => _decrementScore(participant),
//                 icon: Icon(Icons.remove, color: Colors.white, size: 20),
//               ),
//             ),
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF10B981),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF10B981)).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: buttonsDisabled ? null : () => _incrementScore(participant),
//                 icon: Icon(Icons.add, color: Colors.white, size: 20),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSetInfo() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.sports_tennis,
//             color: const Color(0xFF3B82F6),
//             size: 20,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             'Set $currentSet of $totalSets | First to $pointsPerSet (Win by $winBy)',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _incrementScore(String participant) async {
//     if (_isButtonDisabled) return;

//     final participantIndex = participants.indexOf(participant);
//     if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//     _setButtonDisabled(true);

//     try {
//       await MatchApiService.updateBadmintonScore(
//         widget.matchId,
//         teamIds[participantIndex],
//         playerIds[participantIndex],
//         1,
//         'inc',
//       );
      
//       // Score will be updated via socket listener
//       showCustomSnackBar(context, 'Point added to $participant');
//     } catch (e) {
//       print('Error incrementing score: $e');
//       showCustomSnackBar(context, 'Failed to add point: $e', isError: true);
//     } finally {
//       _setButtonDisabled(false);
//     }
//   }

//   void _decrementScore(String participant) async {
//     if (_isButtonDisabled || (scores[participant] ?? 0) <= 0) return;

//     final participantIndex = participants.indexOf(participant);
//     if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//     _setButtonDisabled(true);

//     try {
//       await MatchApiService.updateBadmintonScore(
//         widget.matchId,
//         teamIds[participantIndex],
//         playerIds[participantIndex],
//         1,
//         'dec',
//       );
      
//       // Score will be updated via socket listener
//       showCustomSnackBar(context, 'Point removed from $participant');
//     } catch (e) {
//       print('Error decrementing score: $e');
//       showCustomSnackBar(context, 'Failed to remove point: $e', isError: true);
//     } finally {
//       _setButtonDisabled(false);
//     }
//   }

//   void _setButtonDisabled(bool disabled) {
//     if (mounted) {
//       setState(() {
//         _isButtonDisabled = disabled;
//       });
//     }
//   }

//   void _showAdjustPointsModal() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AdjustPointsModal(
//           currentPointsPerSet: pointsPerSet,
//           maxDeucePoint: maxDeucePoint,
//           onAdjust: (newPoints) async {
//             try {
//               await MatchApiService.updatePointsPerSet(widget.matchId, newPoints);
//               setState(() {
//                 pointsPerSet = newPoints;
//               });
//               showCustomSnackBar(context, 'Points per set adjusted to $newPoints');
//             } catch (e) {
//               print('Error adjusting points per set: $e');
//               showCustomSnackBar(context, 'Failed to adjust points: $e', isError: true);
//             }
//           },
//         );
//       },
//     );
//   }

//   void _endCurrentSet() async {
//     if (!_canEndCurrentSet() || _needToAdjustPointsPerSet()) {
//       showCustomSnackBar(context, 'Cannot end set yet. Adjust points or reach set point first.', isError: true);
//       return;
//     }

//     // Determine set winner
//     String setWinner = '';
//     int highestScore = 0;

//     scores.forEach((participant, score) {
//       if (score > highestScore) {
//         highestScore = score;
//         setWinner = participant;
//       }
//     });

//     final nextSet = currentSet + 1;
//     final isLastSet = nextSet > totalSets;

//     try {
//       if (isLastSet) {
//         // Final set - finish the match
//         await MatchApiService.finishMatch(widget.matchId);
        
//         setState(() {
//           if (setWinner.isNotEmpty) {
//             setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
//             matchWinner = setWinner;
//           }
//           isMatchEnded = true;
//         });

//         stopwatch.stop();
        
//         // Show match completion modal
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return MatchCompletionModal(
//               matchWinner: matchWinner,
//               onFinish: _navigateToSummary,
//             );
//           },
//         );
//       } else {
//         // Regular set - move to next set
//         await MatchApiService.updateCurrentSetAndPoints(widget.matchId, nextSet, pointsPerSet);
        
//         setState(() {
//           if (setWinner.isNotEmpty) {
//             setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
//           }
          
//           // Reset scores for next set and reset pointsPerSet to original
//           scores = {for (String participant in participants) participant: 0};
//           currentSet = nextSet;
//           pointsPerSet = matchData!['pointsPerSet'] ?? 21; // Reset to original
//         });

//         // Show set completion modal
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return SetCompletionModal(
//               setWinner: setWinner,
//               setNumber: currentSet - 1,
//               onContinue: () {
//                 Navigator.of(context).pop();
//                 showCustomSnackBar(context, 'Set ${currentSet-1} completed! $setWinner won the set.');
//               },
//             );
//           },
//         );
//       }
//     } catch (e) {
//       print('Error ending current set: $e');
//       showCustomSnackBar(context, 'Failed to end set: $e', isError: true);
//     }
//   }

//   void _navigateToSummary() {
//     final gameResult = isMatchEnded
//         ? (matchWinner.isNotEmpty ? '$matchWinner Wins!' : 'Draw!')
//         : 'Game Ended';

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GameSummaryScreen(
//           sportName: sportName,
//           participants: participants,
//           finalScores: scores,
//           setsWon: setsWon,
//           gameDuration: totalElapsedTime,
//           gameResult: gameResult,
//           matchId: widget.matchId,
//         ),
//       ),
//     );
//   }

//   void _showEndGameOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'End Game Options',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Choose how you want to end the game:',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showCancelGameDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFEF4444),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text(
//                     'Cancel Game',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showCompleteGameDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF10B981),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text(
//                     'Complete Game',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Back',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showCancelGameDialog() {
//     final TextEditingController reasonController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Cancel Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Please provide a reason for canceling the game:',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: reasonController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter reason...',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//                 maxLines: 3,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Back',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (reasonController.text.trim().isEmpty) {
//                   showCustomSnackBar(context, 'Please enter a reason', isError: true);
//                   return;
//                 }

//                 Navigator.of(context).pop();
                
//                 try {
//                   await MatchApiService.cancelMatch(widget.matchId, reasonController.text.trim());
//                   showCustomSnackBar(context, 'Game cancelled successfully');
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                   );
//                 } catch (e) {
//                   print('Error canceling game: $e');
//                   showCustomSnackBar(context, 'Failed to cancel game: $e', isError: true);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEF4444),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'Cancel Game',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showCompleteGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Complete Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to mark this game as completed?',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _endGame('');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF10B981),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'Complete',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _endGame(String winner) async {
//     setState(() {
//       isMatchEnded = true;
//       matchWinner = winner;
//     });

//     stopwatch.stop();

//     try {
//       await MatchApiService.finishMatch(widget.matchId);
//       _navigateToSummary();
//     } catch (e) {
//       print('Error finishing match: $e');
//       showCustomSnackBar(context, 'Failed to finish match: $e', isError: true);
//     }
//   }
// }




































// import 'dart:async';

// import 'package:booking_application/views/Games/GameViews/create_games.dart';
// import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
// import 'package:booking_application/views/Games/sport_congig.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Custom SnackBar for better toast messages
// void showCustomSnackBar(BuildContext context, String message, {bool isError = false}) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       duration: const Duration(seconds: 3),
//     ),
//   );
// }

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   // Fetch single match data
//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglebatmintonmatch/$matchId'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['match'];
//       } else {
//         throw Exception('Failed to load match data');
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       rethrow;
//     }
//   }

//   // Update badminton match (increment/decrement points)
//   static Future<void> updateBadmintonScore(
//     String matchId,
//     String teamId,
//     String playerId,
//     int points,
//     String action, // 'inc' or 'dec'
//   ) async {
//     try {
//       final payload = {
//         "teamId": teamId,
//         "playerId": playerId,
//         "points": points,
//         "action": action,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update badminton score');
//       }
//     } catch (e) {
//       print('Error updating badminton score: $e');
//       rethrow;
//     }
//   }

//   // Update current set and points per set
//   static Future<void> updateCurrentSetAndPoints(
//     String matchId,
//     int currentSet,
//     int pointsPerSet,
//   ) async {
//     try {
//       final payload = {
//         "currentSet": currentSet,
//         "pointPerSet": pointsPerSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update current set and points');
//       }
//     } catch (e) {
//       print('Error updating current set and points: $e');
//       rethrow;
//     }
//   }

//   // Update points per set only
//   static Future<void> updatePointsPerSet(
//     String matchId,
//     int pointsPerSet,
//   ) async {
//     try {
//       print("Point per set: ${pointsPerSet}");
//       final payload = {
//         "pointsPerSet": pointsPerSet,
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );
//             print("Response status printin: ${response.statusCode}");

//       print("Response status printin: ${response.body}");

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update points per set');
//       }
//     } catch (e) {
//       print('Error updating points per set: $e');
//       rethrow;
//     }
//   }

//   // Finish match
//   static Future<void> finishMatch(String matchId) async {
//     try {
//       final payload = {
//         "Status": "finished",
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to finish match');
//       }
//     } catch (e) {
//       print('Error finishing match: $e');
//       rethrow;
//     }
//   }

//   // Cancel match
//   static Future<void> cancelMatch(String matchId, String reason) async {
//     try {
//       final payload = {
//         "reason": reason,
//         "Status": "cancel",
//       };

//       final response = await http.put(
//         Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to cancel match');
//       }
//     } catch (e) {
//       print('Error canceling match: $e');
//       rethrow;
//     }
//   }
// }

// // Game Summary Screen for displaying final results
// class GameSummaryScreen extends StatelessWidget {
//   final String sportName;
//   final List<String> participants;
//   final Map<String, int> finalScores;
//   final Map<String, int> setsWon;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.sportName,
//     required this.participants,
//     required this.finalScores,
//     required this.setsWon,
//     required this.gameDuration,
//     required this.gameResult,
//     required this.matchId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Game Summary',
//           style: TextStyle(
//             color: Color(0xFF1F2937),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF374151)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Game result header
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: gameResult.contains('Draw') ? const Color(0xFFF3F4F6) : const Color(0xFFDCFCE7),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: gameResult.contains('Draw') ? const Color(0xFFE5E7EB) : const Color(0xFF10B981),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     gameResult.contains('Draw') ? Icons.handshake : Icons.emoji_events,
//                     size: 48,
//                     color: gameResult.contains('Draw') ? const Color(0xFF6B7280) : const Color(0xFF10B981),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     gameResult,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$sportName Match',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Sets Won Display
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8FAFC),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE2E8F0)),
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Final Sets',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...participants.map((participant) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           participant,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF374151),
//                           ),
//                         ),
//                         Text(
//                           '${setsWon[participant] ?? 0} sets',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF3B82F6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<GameProvider>().updateMatchStatus(matchId, "completed");
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     child: const Text(
//                       'New Game',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Set Completion Modal
// class SetCompletionModal extends StatelessWidget {
//   final String setWinner;
//   final int setNumber;
//   final Function() onContinue;

//   const SetCompletionModal({
//     super.key,
//     required this.setWinner,
//     required this.setNumber,
//     required this.onContinue,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.emoji_events,
//               size: 64,
//               color: const Color(0xFFF59E0B),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Set $setNumber Completed!',
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '$setWinner won the set',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: onContinue,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF3B82F6),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   'Continue to Next Set',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Match Completion Modal
// class MatchCompletionModal extends StatelessWidget {
//   final String matchWinner;
//   final Function() onFinish;

//   const MatchCompletionModal({
//     super.key,
//     required this.matchWinner,
//     required this.onFinish,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.emoji_events,
//               size: 64,
//               color: const Color(0xFF10B981),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Match Completed!',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '$matchWinner Wins the Match!',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: onFinish,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF10B981),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   'View Summary',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Adjust Points Modal
// class AdjustPointsModal extends StatefulWidget {
//   final int currentPointsPerSet;
//   final int maxDeucePoint;
//   final Function(int) onAdjust;

//   const AdjustPointsModal({
//     super.key,
//     required this.currentPointsPerSet,
//     required this.maxDeucePoint,
//     required this.onAdjust,
//   });

//   @override
//   State<AdjustPointsModal> createState() => _AdjustPointsModalState();
// }

// class _AdjustPointsModalState extends State<AdjustPointsModal> {
//   late int selectedPoints;
//   final TextEditingController _customPointsController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     selectedPoints = widget.currentPointsPerSet + 1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.tune,
//               size: 48,
//               color: Color(0xFF3B82F6),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Adjust Points Per Set',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Deuce detected! Please adjust the points per set to continue.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Quick selection buttons
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 for (int points = widget.currentPointsPerSet + 1; 
//                      points <= widget.maxDeucePoint; 
//                      points++)
//                   ChoiceChip(
//                     label: Text('$points points'),
//                     selected: selectedPoints == points,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedPoints = points;
//                       });
//                     },
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Custom input
//             TextField(
//               controller: _customPointsController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Custom Points',
//                 hintText: 'Enter points...',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.check),
//                   onPressed: () {
//                     final customPoints = int.tryParse(_customPointsController.text);
//                     if (customPoints != null && 
//                         customPoints > widget.currentPointsPerSet && 
//                         customPoints <= widget.maxDeucePoint) {
//                       setState(() {
//                         selectedPoints = customPoints;
//                       });
//                     }
//                   },
//                 ),
//               ),
//               onChanged: (value) {
//                 final points = int.tryParse(value);
//                 if (points != null && points > widget.currentPointsPerSet && points <= widget.maxDeucePoint) {
//                   setState(() {
//                     selectedPoints = points;
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Color(0xFF6B7280)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       widget.onAdjust(selectedPoints);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       'Adjust',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Scorecard Screen with Set-Based Scoring
// class SetBasedScreen extends StatefulWidget {
//   final String matchId;

//   const SetBasedScreen({
//     super.key,
//     required this.matchId,
//   });

//   @override
//   State<SetBasedScreen> createState() => _SetBasedScreenState();
// }

// class _SetBasedScreenState extends State<SetBasedScreen> {
//   late Map<String, int> scores;
//   late Map<String, int> setsWon;
//   late bool isMatchEnded;
//   late String matchWinner;
//   late Stopwatch stopwatch;
//   late int currentSet;
//   late Duration initialElapsedTime;
//   late int setsToWin;
//   late int pointsPerSet;
//   late int winBy;
//   late bool allowDeuce;
//   late int maxDeucePoint;
//   late int totalSets;

//   // API related fields
//   Map<String, dynamic>? matchData;
//   bool isLoading = true;
//   List<String> teamIds = [];
//   List<String> playerIds = [];
//   List<String> participants = [];
//   String userId = '';
//   String sportName = '';

//   // Button state management
//   bool _isButtonDisabled = false;
//   Timer? _refreshTimer;

//   @override
//   void initState() {
//     super.initState();
//     _fetchMatchData();
//     _startAutoRefresh();
//   }

//   void _startAutoRefresh() {
//     // Refresh data every 3 seconds to get real-time updates
//     _refreshTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (mounted && !isMatchEnded) {
//         _fetchMatchData();
//       }
//     });
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           if (isLoading) {
//             isLoading = false;
//             _initializeGameFromApi();
//           } else {
//             _updateFromMatchData();
//             _updateScoresFromMatchData();
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching match data: $e');
//       if (mounted && isLoading) {
//         setState(() {
//           isLoading = false;
//         });
//         showCustomSnackBar(context, 'Error loading match data: $e', isError: true);
//       }
//     }
//   }

//   void _initializeGameFromApi() {
//     if (matchData == null) return;

//     // Extract userId
//     if (matchData!['createdBy'] != null) {
//       userId = matchData!['createdBy']['_id'] ?? '';
//     }

//     // Extract sport name
//     if (matchData!['categoryId'] != null) {
//       sportName = matchData!['categoryId']['name'] ?? 'Match';
//     }

//     // Extract match settings
//     pointsPerSet = matchData!['pointsPerSet'] ?? 21;
//     winBy = matchData!['winBy'] ?? 2;
//     allowDeuce = matchData!['allowDeuce'] ?? true;
//     maxDeucePoint = matchData!['maxDeucePoint'] ?? 30;
//     totalSets = matchData!['totalSets'] ?? 3;

//     // Extract team IDs, player IDs, and create participant names
//     final isTeamMatch = matchData!['isTeamMatch'] ?? false;
//     teamIds = [];
//     playerIds = [];
//     participants = [];

//     if (isTeamMatch) {
//       // Team match structure
//       if (matchData!['teams'] != null) {
//         final teams = matchData!['teams'] as List;
//         teamIds = teams.map((team) => team['teamId'].toString()).toList();
        
//         for (var team in teams) {
//           String teamName = team['teamName'] ?? 'Team ${participants.length + 1}';
//           participants.add(teamName);
          
//           if (team['players'] != null && (team['players'] as List).isNotEmpty) {
//             final firstPlayer = (team['players'] as List)[0];
//             playerIds.add(firstPlayer['playerId'].toString());
//           } else {
//             playerIds.add('');
//           }
//         }
//       }
//     } else {
//       // Single player match structure
//       if (matchData!['teams'] != null) {
//         final players = matchData!['teams'] as List;
        
//         for (var player in players) {
//           String playerName = player['playerName'] ?? 'Player ${participants.length + 1}';
//           participants.add(playerName);
//           playerIds.add(player['playerId'].toString());
//           teamIds.add(''); // Single players don't have team IDs
//         }
//       }
//     }

//     // Initialize scores from current set data
//     _initializeScoresFromSets();

//     // Get setsToWin from scoringTemplate or totalSets
//     if (matchData!['scoringTemplate'] != null) {
//       setsToWin = matchData!['scoringTemplate']['setsToWin'] ?? 2;
//     } else {
//       setsToWin = (totalSets / 2).ceil();
//     }

//     currentSet = matchData!['currentSet'] ?? 1;
//     isMatchEnded = matchData!['status'] == 'finished';
//     matchWinner = '';

//     // Initialize time
//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     stopwatch = Stopwatch();
//     if (matchData!['status'] == 'live') {
//       stopwatch.start();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//       });
//     }
//   }

//   void _initializeScoresFromSets() {
//     scores = {for (String participant in participants) participant: 0};
//     setsWon = {for (String participant in participants) participant: 0};

//     if (matchData!['sets'] != null) {
//       final sets = matchData!['sets'] as List;
//       final isTeamMatch = matchData!['isTeamMatch'] ?? false;
      
//       // Get current set scores
//       if (sets.isNotEmpty && matchData!['currentSet'] != null) {
//         final currentSetIndex = (matchData!['currentSet'] as int) - 1;
//         if (currentSetIndex < sets.length) {
//           final currentSetData = sets[currentSetIndex];
//           if (currentSetData['score'] != null) {
//             final score = currentSetData['score'];
            
//             if (isTeamMatch) {
//               // Team match score structure
//               if (score['teamA'] != null && participants.isNotEmpty) {
//                 final teamAScore = score['teamA'];
//                 if (teamAScore is Map) {
//                   scores[participants[0]] = teamAScore['score'] ?? 0;
//                 }
//               }
//               if (score['teamB'] != null && participants.length > 1) {
//                 final teamBScore = score['teamB'];
//                 if (teamBScore is Map) {
//                   scores[participants[1]] = teamBScore['score'] ?? 0;
//                 }
//               }
//             } else {
//               // Single player match score structure
//               if (score['playerA'] != null && participants.isNotEmpty) {
//                 scores[participants[0]] = score['playerA'] ?? 0;
//               }
//               if (score['playerB'] != null && participants.length > 1) {
//                 scores[participants[1]] = score['playerB'] ?? 0;
//               }
//             }
//           }
//         }
//       }

//       // Count sets won by each team/player
//       for (var set in sets) {
//         if (set['winner'] != null) {
//           String? winnerName = set['winner'];
//           if (winnerName != null && setsWon.containsKey(winnerName)) {
//             setsWon[winnerName] = (setsWon[winnerName] ?? 0) + 1;
//           }
//         }
//       }
//     }

//     // Also check finalScore for sets won
//     if (matchData!['finalScore'] != null) {
//       final finalScore = matchData!['finalScore'];
//       final isTeamMatch = matchData!['isTeamMatch'] ?? false;
      
//       if (isTeamMatch) {
//         if (finalScore['teamA'] != null && participants.isNotEmpty) {
//           final teamAScore = finalScore['teamA'];
//           if (teamAScore is Map) {
//             setsWon[participants[0]] = teamAScore['score'] ?? 0;
//           }
//         }
//         if (finalScore['teamB'] != null && participants.length > 1) {
//           final teamBScore = finalScore['teamB'];
//           if (teamBScore is Map) {
//             setsWon[participants[1]] = teamBScore['score'] ?? 0;
//           }
//         }
//       } else {
//         // Single player final score structure
//         if (finalScore['teamA'] != null && participants.isNotEmpty) {
//           setsWon[participants[0]] = finalScore['teamA'] ?? 0;
//         }
//         if (finalScore['teamB'] != null && participants.length > 1) {
//           setsWon[participants[1]] = finalScore['teamB'] ?? 0;
//         }
//       }
//     }
//   }

//   void _updateScoresFromMatchData() {
//     if (matchData == null) return;
//     _initializeScoresFromSets();
//   }

//   void _updateFromMatchData() {
//     if (matchData == null) return;

//     final status = matchData!['status'] ?? 'live';
//     isMatchEnded = status == 'finished';

//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);

//     currentSet = matchData!['currentSet'] ?? currentSet;
//     pointsPerSet = matchData!['pointsPerSet'] ?? pointsPerSet;
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     _refreshTimer?.cancel();
//     super.dispose();
//   }

//   Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

//   // Check if current set can be ended
//   bool _canEndCurrentSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Check if we need to adjust pointsPerSet due to deuce
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       // Both players have reached deuce threshold
//       final maxScore = score1 > score2 ? score1 : score2;
      
//       // If scores are equal and below maxDeucePoint, we need to increase pointsPerSet
//       if (score1 == score2 && score1 < maxDeucePoint) {
//         return false; // Cannot end set until pointsPerSet is adjusted
//       }
      
//       // Check if someone has reached the adjusted pointsPerSet with winBy advantage
//       if (maxScore >= pointsPerSet && (score1 - score2).abs() >= winBy) {
//         return true;
//       }
      
//       // Check if maxDeucePoint is reached
//       if (maxScore >= maxDeucePoint) {
//         return true;
//       }
      
//       return false;
//     }

//     // Normal scenario: check if any team has reached pointsPerSet with winBy advantage
//     if ((score1 >= pointsPerSet || score2 >= pointsPerSet) && (score1 - score2).abs() >= winBy) {
//       return true;
//     }

//     return false;
//   }

//   // Check if we need to adjust pointsPerSet due to deuce
//   bool _needToAdjustPointsPerSet() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     // Check if both players have reached deuce threshold and scores are equal
//     if (allowDeuce && 
//         score1 >= (pointsPerSet - 1) && 
//         score2 >= (pointsPerSet - 1) && 
//         score1 == score2 && 
//         score1 < maxDeucePoint) {
//       return true;
//     }

//     return false;
//   }

//   // Check if we're at max deuce point
//   bool _isAtMaxDeucePoint() {
//     if (scores.isEmpty || participants.length < 2) return false;

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;

//     return allowDeuce && 
//            score1 >= (maxDeucePoint - 1) && 
//            score2 >= (maxDeucePoint - 1);
//   }

//   String _getSetStatusMessage() {
//     if (scores.isEmpty || participants.length < 2) return '';

//     final score1 = scores[participants[0]] ?? 0;
//     final score2 = scores[participants[1]] ?? 0;
//     final diff = (score1 - score2).abs();
//     final maxScore = score1 > score2 ? score1 : score2;

//     if (_needToAdjustPointsPerSet()) {
//       return 'Deuce! Adjust points per set to continue';
//     }

//     if (_isAtMaxDeucePoint()) {
//       return 'Maximum deuce! First to reach $maxDeucePoint wins';
//     }

//     if (maxScore < pointsPerSet) {
//       return 'First to $pointsPerSet points wins';
//     }

//     // Deuce scenario
//     if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
//       if (maxScore >= maxDeucePoint) {
//         return 'Maximum deuce point reached!';
//       }
//       return 'Deuce! Need to win by $winBy (Max: $maxDeucePoint)';
//     }

//     if (diff < winBy) {
//       return 'Need to win by $winBy points';
//     }

//     return 'Set point reached!';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF3B82F6),
//           ),
//         ),
//       );
//     }

//     if (matchData == null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text('Error'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 64, color: Colors.red),
//               SizedBox(height: 16),
//               Text('Failed to load match data'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Go Back'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _buildSetBasedScorecard(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '$sportName Match',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       participants.join(' vs '),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 2),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFEF4444),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Text(
//                         'LIVE',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               _buildActionButtons(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     final needAdjustPoints = _needToAdjustPointsPerSet();
    
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         if (needAdjustPoints)
//           InkWell(
//             onTap: _showAdjustPointsModal,
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF59E0B),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Text(
//                 'Adjust Points',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//         InkWell(
//           onTap: _showEndGameOptions,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEF4444),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'End Game',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSetBasedScorecard() {
//     final canEndSet = _canEndCurrentSet();
//     final needAdjustPoints = _needToAdjustPointsPerSet();
//     final isAtMaxDeuce = _isAtMaxDeucePoint();
//     final statusMessage = _getSetStatusMessage();

//     // Determine if buttons should be disabled
//     final shouldDisableButtons = _isButtonDisabled || needAdjustPoints;

//     return Column(
//       children: [
//         const SizedBox(height: 16),
//         _buildSetInfo(),
//         const SizedBox(height: 12),
//         // Status message
//         if (statusMessage.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: canEndSet ? const Color(0xFFDCFCE7) : 
//                      needAdjustPoints ? const Color(0xFFFEF3C7) : 
//                      isAtMaxDeuce ? const Color(0xFFFEE2E2) : const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: canEndSet ? const Color(0xFF10B981) : 
//                        needAdjustPoints ? const Color(0xFFF59E0B) : 
//                        isAtMaxDeuce ? const Color(0xFFEF4444) : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   canEndSet ? Icons.check_circle : 
//                   needAdjustPoints ? Icons.warning : 
//                   isAtMaxDeuce ? Icons.priority_high : Icons.info,
//                   color: canEndSet ? const Color(0xFF10B981) : 
//                          needAdjustPoints ? const Color(0xFFF59E0B) : 
//                          isAtMaxDeuce ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     statusMessage,
//                     style: TextStyle(
//                       color: canEndSet ? const Color(0xFF065F46) : 
//                              needAdjustPoints ? const Color(0xFF92400E) : 
//                              isAtMaxDeuce ? const Color(0xFF991B1B) : const Color(0xFF374151),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: participants.map((participant) {
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: const Color(0xFFE5E7EB)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: _buildSetParticipantCard(participant, shouldDisableButtons),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ElevatedButton(
//             onPressed: canEndSet && !needAdjustPoints ? _endCurrentSet : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: canEndSet && !needAdjustPoints ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               needAdjustPoints ? 'Adjust Points to Continue' : 
//               canEndSet ? 'End Current Set' : 'Reach Set Point to Continue',
//               style: TextStyle(
//                 color: canEndSet && !needAdjustPoints ? Colors.white : const Color(0xFF9CA3AF),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildSetParticipantCard(String participant, bool buttonsDisabled) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF10B981).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${scores[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Points',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//             const Text(
//               '/',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Color(0xFF9CA3AF),
//               ),
//             ),
//             Column(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF3B82F6),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF3B82F6).withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${setsWon[participant]}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Sets Won',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFFEF4444)).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: buttonsDisabled ? null : () => _decrementScore(participant),
//                 icon: Icon(Icons.remove, color: Colors.white, size: 20),
//               ),
//             ),
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF10B981),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (buttonsDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF10B981)).withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: buttonsDisabled ? null : () => _incrementScore(participant),
//                 icon: Icon(Icons.add, color: Colors.white, size: 20),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSetInfo() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.sports_tennis,
//             color: const Color(0xFF3B82F6),
//             size: 20,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             'Set $currentSet of $totalSets | First to $pointsPerSet (Win by $winBy)',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _incrementScore(String participant) async {
//     if (_isButtonDisabled) return;

//     final participantIndex = participants.indexOf(participant);
//     if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//     _setButtonDisabled(true);

//     try {
//       await MatchApiService.updateBadmintonScore(
//         widget.matchId,
//         teamIds[participantIndex],
//         playerIds[participantIndex],
//         1,
//         'inc',
//       );
      
//       // Refresh data to get updated scores
//       await _fetchMatchData();
//       showCustomSnackBar(context, 'Point added to $participant');
//     } catch (e) {
//       print('Error incrementing score: $e');
//       showCustomSnackBar(context, 'Failed to add point: $e', isError: true);
//     } finally {
//       _setButtonDisabled(false);
//     }
//   }

//   void _decrementScore(String participant) async {
//     if (_isButtonDisabled || (scores[participant] ?? 0) <= 0) return;

//     final participantIndex = participants.indexOf(participant);
//     if (participantIndex < 0 || participantIndex >= teamIds.length) return;

//     _setButtonDisabled(true);

//     try {
//       await MatchApiService.updateBadmintonScore(
//         widget.matchId,
//         teamIds[participantIndex],
//         playerIds[participantIndex],
//         1,
//         'dec',
//       );
      
//       // Refresh data to get updated scores
//       await _fetchMatchData();
//       showCustomSnackBar(context, 'Point removed from $participant');
//     } catch (e) {
//       print('Error decrementing score: $e');
//       showCustomSnackBar(context, 'Failed to remove point: $e', isError: true);
//     } finally {
//       _setButtonDisabled(false);
//     }
//   }

//   void _setButtonDisabled(bool disabled) {
//     if (mounted) {
//       setState(() {
//         _isButtonDisabled = disabled;
//       });
//     }
//   }

//   void _showAdjustPointsModal() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AdjustPointsModal(
//           currentPointsPerSet: pointsPerSet,
//           maxDeucePoint: maxDeucePoint,
//           onAdjust: (newPoints) async {
//             try {
//               await MatchApiService.updatePointsPerSet(widget.matchId, newPoints);
//               setState(() {
//                 pointsPerSet = newPoints;
//               });
//               showCustomSnackBar(context, 'Points per set adjusted to $newPoints');
//             } catch (e) {
//               print('Error adjusting points per set: $e');
//               showCustomSnackBar(context, 'Failed to adjust points: $e', isError: true);
//             }
//           },
//         );
//       },
//     );
//   }

//   void _endCurrentSet() async {
//     if (!_canEndCurrentSet() || _needToAdjustPointsPerSet()) {
//       showCustomSnackBar(context, 'Cannot end set yet. Adjust points or reach set point first.', isError: true);
//       return;
//     }

//     // Determine set winner
//     String setWinner = '';
//     int highestScore = 0;

//     scores.forEach((participant, score) {
//       if (score > highestScore) {
//         highestScore = score;
//         setWinner = participant;
//       }
//     });

//     final nextSet = currentSet + 1;
//     final isLastSet = nextSet > totalSets;

//     try {
//       if (isLastSet) {
//         // Final set - finish the match
//         await MatchApiService.finishMatch(widget.matchId);
        
//         setState(() {
//           if (setWinner.isNotEmpty) {
//             setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
//             matchWinner = setWinner;
//           }
//           isMatchEnded = true;
//         });

//         stopwatch.stop();
        
//         // Show match completion modal
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return MatchCompletionModal(
//               matchWinner: matchWinner,
//               onFinish: _navigateToSummary,
//             );
//           },
//         );
//       } else {
//         // Regular set - move to next set
//         await MatchApiService.updateCurrentSetAndPoints(widget.matchId, nextSet, pointsPerSet);
        
//         setState(() {
//           if (setWinner.isNotEmpty) {
//             setsWon[setWinner] = (setsWon[setWinner] ?? 0) + 1;
//           }
          
//           // Reset scores for next set and reset pointsPerSet to original
//           scores = {for (String participant in participants) participant: 0};
//           currentSet = nextSet;
//           pointsPerSet = matchData!['pointsPerSet'] ?? 21; // Reset to original
//         });

//         // Show set completion modal
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return SetCompletionModal(
//               setWinner: setWinner,
//               setNumber: currentSet - 1,
//               onContinue: () {
//                 Navigator.of(context).pop();
//                 showCustomSnackBar(context, 'Set ${currentSet-1} completed! $setWinner won the set.');
//               },
//             );
//           },
//         );
//       }
//     } catch (e) {
//       print('Error ending current set: $e');
//       showCustomSnackBar(context, 'Failed to end set: $e', isError: true);
//     }
//   }

//   void _navigateToSummary() {
//     final gameResult = isMatchEnded
//         ? (matchWinner.isNotEmpty ? '$matchWinner Wins!' : 'Draw!')
//         : 'Game Ended';

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GameSummaryScreen(
//           sportName: sportName,
//           participants: participants,
//           finalScores: scores,
//           setsWon: setsWon,
//           gameDuration: totalElapsedTime,
//           gameResult: gameResult,
//           matchId: widget.matchId,
//         ),
//       ),
//     );
//   }

//   void _showEndGameOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'End Game Options',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Choose how you want to end the game:',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showCancelGameDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFEF4444),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text(
//                     'Cancel Game',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _showCompleteGameDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF10B981),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text(
//                     'Complete Game',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Back',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showCancelGameDialog() {
//     final TextEditingController reasonController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Cancel Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Please provide a reason for canceling the game:',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: reasonController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter reason...',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//                 maxLines: 3,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Back',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (reasonController.text.trim().isEmpty) {
//                   showCustomSnackBar(context, 'Please enter a reason', isError: true);
//                   return;
//                 }

//                 Navigator.of(context).pop();
                
//                 try {
//                   await MatchApiService.cancelMatch(widget.matchId, reasonController.text.trim());
//                   showCustomSnackBar(context, 'Game cancelled successfully');
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => GameManagerScreen()),
//                   );
//                 } catch (e) {
//                   print('Error canceling game: $e');
//                   showCustomSnackBar(context, 'Failed to cancel game: $e', isError: true);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEF4444),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'Cancel Game',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showCompleteGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Complete Game',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to mark this game as completed?',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _endGame('');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF10B981),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text(
//                 'Complete',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _endGame(String winner) async {
//     setState(() {
//       isMatchEnded = true;
//       matchWinner = winner;
//     });

//     stopwatch.stop();

//     try {
//       await MatchApiService.finishMatch(widget.matchId);
//       _navigateToSummary();
//     } catch (e) {
//       print('Error finishing match: $e');
//       showCustomSnackBar(context, 'Failed to finish match: $e', isError: true);
//     }
//   }
// }





























import 'dart:async';

import 'package:booking_application/views/Games/GameViews/create_games.dart';
import 'package:booking_application/views/Games/GameViews/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/GameViews/games_view_screen.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
        Uri.parse('$baseUrl/users/getsinglebatmintonmatch/$matchId'),
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

  // Update badminton match (increment/decrement points)
  static Future<void> updateBadmintonScore(
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
        Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update badminton score');
      }
    } catch (e) {
      print('Error updating badminton score: $e');
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
        Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
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
        Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
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
        Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
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
        Uri.parse('$baseUrl/users/updatebadminton/$matchId'),
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
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFF8FAFC),
            //     borderRadius: BorderRadius.circular(16),
            //     border: Border.all(color: const Color(0xFFE2E8F0)),
            //   ),
            //   child: Column(
            //     children: [
            //       const Text(
            //         'Final Sets',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xFF1F2937),
            //         ),
            //       ),
            //       const SizedBox(height: 16),
            //       ...participants.map((participant) => Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               participant,
            //               style: const TextStyle(
            //                 fontSize: 16,
            //                 color: Color(0xFF374151),
            //               ),
            //             ),
            //             Text(
            //               '${setsWon[participant] ?? 0} sets',
            //               style: const TextStyle(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold,
            //                 color: Color(0xFF3B82F6),
            //               ),
            //             ),
            //           ],
            //         ),
            //       )),
            //     ],
            //   ),
            // ),
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

// Adjust Points Modal
class AdjustPointsModal extends StatefulWidget {
  final int currentPointsPerSet;
  final int maxDeucePoint;
  final Function(int) onAdjust;

  const AdjustPointsModal({
    super.key,
    required this.currentPointsPerSet,
    required this.maxDeucePoint,
    required this.onAdjust,
  });

  @override
  State<AdjustPointsModal> createState() => _AdjustPointsModalState();
}

class _AdjustPointsModalState extends State<AdjustPointsModal> {
  late int selectedPoints;
  final TextEditingController _customPointsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedPoints = widget.currentPointsPerSet + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.tune,
              size: 48,
              color: Color(0xFF3B82F6),
            ),
            const SizedBox(height: 16),
            const Text(
              'Adjust Points Per Set',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Deuce detected! Please adjust the points per set to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 20),
            // Quick selection buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int points = widget.currentPointsPerSet + 1; 
                     points <= widget.maxDeucePoint; 
                     points++)
                  ChoiceChip(
                    label: Text('$points points'),
                    selected: selectedPoints == points,
                    onSelected: (selected) {
                      setState(() {
                        selectedPoints = points;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // Custom input
            TextField(
              controller: _customPointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Custom Points',
                hintText: 'Enter points...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    final customPoints = int.tryParse(_customPointsController.text);
                    if (customPoints != null && 
                        customPoints > widget.currentPointsPerSet && 
                        customPoints <= widget.maxDeucePoint) {
                      setState(() {
                        selectedPoints = customPoints;
                      });
                    }
                  },
                ),
              ),
              onChanged: (value) {
                final points = int.tryParse(value);
                if (points != null && points > widget.currentPointsPerSet && points <= widget.maxDeucePoint) {
                  setState(() {
                    selectedPoints = points;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onAdjust(selectedPoints);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Adjust',
                      style: TextStyle(color: Colors.white),
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

// Scorecard Screen with Set-Based Scoring
class SetBasedScreen extends StatefulWidget {
  final String matchId;

  const SetBasedScreen({
    super.key,
    required this.matchId,
  });

  @override
  State<SetBasedScreen> createState() => _SetBasedScreenState();
}

class _SetBasedScreenState extends State<SetBasedScreen> {
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
  late int maxDeucePoint;
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
    maxDeucePoint = matchData!['maxDeucePoint'] ?? 30;
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

  // Check if current set can be ended
  bool _canEndCurrentSet() {
    if (scores.isEmpty || participants.length < 2) return false;

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;

    // Check if we need to adjust pointsPerSet due to deuce
    if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
      // Both players have reached deuce threshold
      final maxScore = score1 > score2 ? score1 : score2;
      
      // If scores are equal and below maxDeucePoint, we need to increase pointsPerSet
      if (score1 == score2 && score1 < maxDeucePoint) {
        return false; // Cannot end set until pointsPerSet is adjusted
      }
      
      // Check if someone has reached the adjusted pointsPerSet with winBy advantage
      if (maxScore >= pointsPerSet && (score1 - score2).abs() >= winBy) {
        return true;
      }
      
      // Check if maxDeucePoint is reached
      if (maxScore >= maxDeucePoint) {
        return true;
      }
      
      return false;
    }

    // Normal scenario: check if any team has reached pointsPerSet with winBy advantage
    if ((score1 >= pointsPerSet || score2 >= pointsPerSet) && (score1 - score2).abs() >= winBy) {
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
    if (allowDeuce && 
        score1 >= (pointsPerSet - 1) && 
        score2 >= (pointsPerSet - 1) && 
        score1 == score2 && 
        score1 < maxDeucePoint) {
      return true;
    }

    return false;
  }

  // Check if we're at max deuce point
  bool _isAtMaxDeucePoint() {
    if (scores.isEmpty || participants.length < 2) return false;

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;

    return allowDeuce && 
           score1 >= (maxDeucePoint - 1) && 
           score2 >= (maxDeucePoint - 1);
  }

  // Check if max deuce point is reached and set should end
  bool _isMaxDeucePointReached() {
    if (scores.isEmpty || participants.length < 2) return false;

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;

    return allowDeuce && 
           (score1 >= maxDeucePoint || score2 >= maxDeucePoint) &&
           (score1 - score2).abs() >= winBy;
  }

  // Check if buttons should be disabled
  bool _shouldDisableButtons() {
    return _isButtonDisabled || 
           isMatchEnded || 
           _isMaxDeucePointReached() ||
           (scores.isNotEmpty && participants.length >= 2 && 
            ((scores[participants[0]] ?? 0) >= maxDeucePoint || 
             (scores[participants[1]] ?? 0) >= maxDeucePoint));
  }

  String _getSetStatusMessage() {
    if (scores.isEmpty || participants.length < 2) return '';

    final score1 = scores[participants[0]] ?? 0;
    final score2 = scores[participants[1]] ?? 0;
    final diff = (score1 - score2).abs();
    final maxScore = score1 > score2 ? score1 : score2;

    if (_needToAdjustPointsPerSet()) {
      return 'Deuce! Adjust points per set to continue';
    }

    if (_isAtMaxDeucePoint()) {
      return 'Maximum deuce! First to reach $maxDeucePoint wins';
    }

    if (_isMaxDeucePointReached()) {
      return 'Maximum deuce point reached! Set completed';
    }

    if (maxScore < pointsPerSet) {
      return 'First to $pointsPerSet points wins';
    }

    // Deuce scenario
    if (allowDeuce && score1 >= (pointsPerSet - 1) && score2 >= (pointsPerSet - 1)) {
      if (maxScore >= maxDeucePoint) {
        return 'Maximum deuce point reached!';
      }
      return 'Deuce! Need to win by $winBy (Max: $maxDeucePoint)';
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
    final shouldDisableButtons = _shouldDisableButtons();
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (needAdjustPoints && !shouldDisableButtons)
          InkWell(
            onTap: _showAdjustPointsModal,
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
    final isAtMaxDeuce = _isAtMaxDeucePoint();
    final isMaxDeuceReached = _isMaxDeucePointReached();
    final statusMessage = _getSetStatusMessage();
    final shouldDisableButtons = _shouldDisableButtons();

    return Column(
      children: [
        const SizedBox(height: 16),
        _buildSetInfo(),
        const SizedBox(height: 12),
        // Status message
        if (statusMessage.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: canEndSet ? const Color(0xFFDCFCE7) : 
                     needAdjustPoints ? const Color(0xFFFEF3C7) : 
                     isAtMaxDeuce ? const Color(0xFFFEE2E2) : 
                     isMaxDeuceReached ? const Color(0xFF10B981) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: canEndSet ? const Color(0xFF10B981) : 
                       needAdjustPoints ? const Color(0xFFF59E0B) : 
                       isAtMaxDeuce ? const Color(0xFFEF4444) : 
                       isMaxDeuceReached ? const Color(0xFF10B981) : const Color(0xFFE5E7EB),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  canEndSet ? Icons.check_circle : 
                  needAdjustPoints ? Icons.warning : 
                  isAtMaxDeuce ? Icons.priority_high : 
                  isMaxDeuceReached ? Icons.emoji_events : Icons.info,
                  color: canEndSet ? const Color(0xFF10B981) : 
                         needAdjustPoints ? const Color(0xFFF59E0B) : 
                         isAtMaxDeuce ? const Color(0xFFEF4444) : 
                         isMaxDeuceReached ? const Color(0xFF10B981) : const Color(0xFF6B7280),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    statusMessage,
                    style: TextStyle(
                      color: canEndSet ? const Color(0xFF065F46) : 
                             needAdjustPoints ? const Color(0xFF92400E) : 
                             isAtMaxDeuce ? const Color(0xFF991B1B) : 
                             isMaxDeuceReached ? const Color(0xFF065F46) : const Color(0xFF374151),
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
            onPressed: (canEndSet || isMaxDeuceReached) && !needAdjustPoints ? _endCurrentSet : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: (canEndSet || isMaxDeuceReached) && !needAdjustPoints ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              needAdjustPoints ? 'Adjust Points to Continue' : 
              (canEndSet || isMaxDeuceReached) ? 'End Current Set' : 'Reach Set Point to Continue',
              style: TextStyle(
                color: (canEndSet || isMaxDeuceReached) && !needAdjustPoints ? Colors.white : const Color(0xFF9CA3AF),
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

  Widget _buildSetInfo() {
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
            Icons.sports_tennis,
            color: const Color(0xFF3B82F6),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Set $currentSet of $totalSets | First to $pointsPerSet (Win by $winBy)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  void _incrementScore(String participant) async {
    if (_shouldDisableButtons()) return;

    final participantIndex = participants.indexOf(participant);
    if (participantIndex < 0 || participantIndex >= teamIds.length) return;

    // Check if max deuce point is reached
    final currentScore = scores[participant] ?? 0;
    if (currentScore >= maxDeucePoint) {
      showCustomSnackBar(context, 'Maximum deuce point ($maxDeucePoint) reached!', isError: true);
      return;
    }

    _setButtonDisabled(true);

    try {
      await MatchApiService.updateBadmintonScore(
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
    if (_shouldDisableButtons() || (scores[participant] ?? 0) <= 0) return;

    final participantIndex = participants.indexOf(participant);
    if (participantIndex < 0 || participantIndex >= teamIds.length) return;

    _setButtonDisabled(true);

    try {
      await MatchApiService.updateBadmintonScore(
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

  void _showAdjustPointsModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdjustPointsModal(
          currentPointsPerSet: pointsPerSet,
          maxDeucePoint: maxDeucePoint,
          onAdjust: (newPoints) async {
            try {
              await MatchApiService.updatePointsPerSet(widget.matchId, newPoints);
              setState(() {
                pointsPerSet = newPoints;
              });
              showCustomSnackBar(context, 'Points per set adjusted to $newPoints');
            } catch (e) {
              print('Error adjusting points per set: $e');
              showCustomSnackBar(context, 'Failed to adjust points: $e', isError: true);
            }
          },
        );
      },
    );
  }

  void _endCurrentSet() async {
    if ((!_canEndCurrentSet() && !_isMaxDeucePointReached()) || _needToAdjustPointsPerSet()) {
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