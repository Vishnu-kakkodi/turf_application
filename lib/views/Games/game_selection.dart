// import 'package:booking_application/views/Games/create_games.dart';
// import 'package:booking_application/views/Games/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/games_view_screen.dart';
// import 'package:booking_application/views/Games/sport_congig.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // Game Summary Screen for displaying final results
// class GameSummaryScreen extends StatelessWidget {
//   final SportConfig sportConfig;
//   final List<String> participants;
//   final Map<String, int> finalScores;
//   final Map<String, int>? finalSetsWon;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.sportConfig,
//     required this.participants,
//     required this.finalScores,
//     this.finalSetsWon,
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
//                     '${sportConfig.displayName} Match',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Final scores and navigation buttons would go here
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Update match status to completed in provider
//                       context.read<GameProvider>().updateMatchStatus(matchId, MatchStatus.completed);
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

// // Enhanced Match Data class to store live game state
// class LiveMatchData {
//   final String matchId;
//   final Map<String, int> scores;
//   final Map<String, int> setsWon;
//   final int currentSet;
//   final Duration elapsedTime;
//   final bool isTimerRunning;
//   final String currentPeriod;
//   final bool isMatchEnded;
//   final String matchWinner;

//   LiveMatchData({
//     required this.matchId,
//     required this.scores,
//     required this.setsWon,
//     required this.currentSet,
//     required this.elapsedTime,
//     required this.isTimerRunning,
//     required this.currentPeriod,
//     required this.isMatchEnded,
//     required this.matchWinner,
//   });

//   LiveMatchData copyWith({
//     Map<String, int>? scores,
//     Map<String, int>? setsWon,
//     int? currentSet,
//     Duration? elapsedTime,
//     bool? isTimerRunning,
//     String? currentPeriod,
//     bool? isMatchEnded,
//     String? matchWinner,
//   }) {
//     return LiveMatchData(
//       matchId: matchId,
//       scores: scores ?? this.scores,
//       setsWon: setsWon ?? this.setsWon,
//       currentSet: currentSet ?? this.currentSet,
//       elapsedTime: elapsedTime ?? this.elapsedTime,
//       isTimerRunning: isTimerRunning ?? this.isTimerRunning,
//       currentPeriod: currentPeriod ?? this.currentPeriod,
//       isMatchEnded: isMatchEnded ?? this.isMatchEnded,
//       matchWinner: matchWinner ?? this.matchWinner,
//     );
//   }
// }

// // Scorecard Screen with Provider Integration
// class ScorecardScreen extends StatefulWidget {
//   final SportConfig sportConfig;
//   final List<String> participants;
//   final int? setFormat;
//   final String matchId;
//   final LiveMatchData? existingMatchData; // For continuing live matches

//   const ScorecardScreen({
//     super.key,
//     required this.sportConfig,
//     required this.participants,
//     this.setFormat,
//     required this.matchId,
//     this.existingMatchData,
//   });

//   @override
//   State<ScorecardScreen> createState() => _ScorecardScreenState();
// }

// class _ScorecardScreenState extends State<ScorecardScreen> {
//   late Map<String, int> scores;
//   late Map<String, int> setsWon;
//   late int currentSet;
//   late bool isMatchEnded;
//   late String matchWinner;
//   late Stopwatch stopwatch;
//   late String currentPeriod;
//   late Duration initialElapsedTime;

//   @override
//   void initState() {
//     super.initState();
//     _initializeGame();
//   }

//   void _initializeGame() {
//     if (widget.existingMatchData != null) {
//       // Continue existing live match
//       final existingData = widget.existingMatchData!;
//       scores = Map<String, int>.from(existingData.scores);
//       setsWon = Map<String, int>.from(existingData.setsWon);
//       currentSet = existingData.currentSet;
//       isMatchEnded = existingData.isMatchEnded;
//       matchWinner = existingData.matchWinner;
//       currentPeriod = existingData.currentPeriod;
//       initialElapsedTime = existingData.elapsedTime;
      
//       // Setup stopwatch with existing elapsed time
//       stopwatch = Stopwatch();
//       if (existingData.isTimerRunning) {
//         stopwatch.start();
//       }
//     } else {
//       // Start new match
//       scores = {for (String participant in widget.participants) participant: 0};
//       setsWon = {for (String participant in widget.participants) participant: 0};
//       currentSet = 1;
//       isMatchEnded = false;
//       matchWinner = '';
//       currentPeriod = '1st Half';
//       initialElapsedTime = Duration.zero;
//       stopwatch = Stopwatch()..start();
      
//       // Update match status to live when starting
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<GameProvider>().updateMatchStatus(widget.matchId, MatchStatus.live);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     super.dispose();
//   }

//   Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

//   // Save current match state (you can call this periodically or on important events)
//   void _saveMatchState() {
//     // This could be enhanced to save to local storage or backend
//     final matchData = LiveMatchData(
//       matchId: widget.matchId,
//       scores: scores,
//       setsWon: setsWon,
//       currentSet: currentSet,
//       elapsedTime: totalElapsedTime,
//       isTimerRunning: stopwatch.isRunning,
//       currentPeriod: currentPeriod,
//       isMatchEnded: isMatchEnded,
//       matchWinner: matchWinner,
//     );
//     // You can extend GameProvider to store this data
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _buildScorecard(),
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
//                       '${widget.sportConfig.displayName} Match',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.participants.join(' vs '),
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
//         InkWell(
//           onTap: _showNewGameDialog,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xFFE5E7EB)),
//             ),
//             child: const Text(
//               'New Game',
//               style: TextStyle(
//                 color: Color(0xFF374151),
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ),
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

//   Widget _buildScorecard() {
//     switch (widget.sportConfig.scoreType) {
//       case ScoreType.winBased:
//       case ScoreType.pointBased:
//         return _buildWinBasedScorecard();
//       case ScoreType.goalBased:
//         return _buildGoalBasedScorecard(); // Fixed: now calls the correct method
//       case ScoreType.setBased:
//         return _buildSetBasedScorecard();
//     }
//   }

//   // Win-based/Point-based Scorecard
//   Widget _buildWinBasedScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: widget.participants.length > 2
//               ? Column(
//                   children: widget.participants.map((participant) {
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: const Color(0xFFE5E7EB)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.08),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: _buildParticipantCard(participant, true),
//                     );
//                   }).toList(),
//                 )
//               : Row(
//                   children: widget.participants.map((participant) {
//                     return Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: const Color(0xFFE5E7EB)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.08),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: _buildParticipantCard(participant, true),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   // Goal-based Scorecard - Now properly implemented
//   Widget _buildGoalBasedScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 16),
//         _buildPeriodSelector(),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: widget.participants.length > 2
//               ? Column(
//                   children: widget.participants.map((participant) {
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: const Color(0xFFE5E7EB)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.08),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: _buildGoalParticipantCard(participant),
//                     );
//                   }).toList(),
//                 )
//               : Row(
//                   children: widget.participants.map((participant) {
//                     return Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: const Color(0xFFE5E7EB)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.08),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: _buildGoalParticipantCard(participant),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   // Set-based Scorecard
//   Widget _buildSetBasedScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 16),
//         _buildSetInfo(),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: widget.participants.length > 2
//               ? Column(
//                   children: widget.participants.map((participant) {
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: const Color(0xFFE5E7EB)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.08),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: _buildSetParticipantCard(participant),
//                     );
//                   }).toList(),
//                 )
//               : Row(
//                   children: widget.participants.map((participant) {
//                     return Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: const Color(0xFFE5E7EB)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.08),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: _buildSetParticipantCard(participant),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//         ),
//         const SizedBox(height: 20),
//         Container(
//           width: 200,
//           height: 48,
//           child: ElevatedButton(
//             onPressed: _endCurrentSet,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF3B82F6),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 2,
//             ),
//             child: Text(
//               'End Set $currentSet',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildParticipantCard(String participant, bool showButton) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Points',
//           style: const TextStyle(
//             fontSize: 14,
//             color: Color(0xFF6B7280),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           width: 70,
//           height: 70,
//           decoration: BoxDecoration(
//             color: const Color(0xFF10B981),
//             borderRadius: BorderRadius.circular(35),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF10B981).withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               '${scores[participant]}',
//               style: const TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         if (showButton) ...[
//           const SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             height: 44,
//             child: ElevatedButton(
//               onPressed: () => _awardPoint(participant),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3B82F6),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 2,
//               ),
//               child: const Text(
//                 'Award Point',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildGoalParticipantCard(String participant) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 16),
//         Container(
//           width: 90,
//           height: 90,
//           decoration: BoxDecoration(
//             color: const Color(0xFF10B981),
//             borderRadius: BorderRadius.circular(45),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF10B981).withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               '${scores[participant]}',
//               style: const TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           'Goals',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF6B7280),
//           ),
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

//   Widget _buildSetParticipantCard(String participant) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981),
//                     borderRadius: BorderRadius.circular(30),
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
//                         fontSize: 20,
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
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF6B7280),
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF6B7280).withOpacity(0.2),
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
//                         fontSize: 20,
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
//                       _saveMatchState();
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
//                       _saveMatchState();
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

//   Widget _buildPeriodSelector() {
//     final periods = ['1st Half', '2nd Half', 'Extra Time'];
    
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3F4F6),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: periods.map((period) {
//           final isSelected = currentPeriod == period;
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 currentPeriod = period;
//               });
//               _saveMatchState();
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 period,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : const Color(0xFF6B7280),
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
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
//             'Set $currentSet',
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           if (widget.setFormat != null) ...[
//             const SizedBox(width: 8),
//             Text(
//               '(Best of ${widget.setFormat})',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   void _awardPoint(String participant) {
//     setState(() {
//       scores[participant] = scores[participant]! + 1;
//     });
//     _saveMatchState();
//     _checkWinCondition();
//   }

//   void _incrementScore(String participant) {
//     setState(() {
//       scores[participant] = scores[participant]! + 1;
//     });
//     _saveMatchState();
//     _checkWinCondition();
//   }

//   void _decrementScore(String participant) {
//     setState(() {
//       if (scores[participant]! > 0) {
//         scores[participant] = scores[participant]! - 1;
//       }
//     });
//     _saveMatchState();
//   }

//   void _endCurrentSet() {
//     // Determine set winner
//     String setWinner = '';
//     int highestScore = 0;
    
//     scores.forEach((participant, score) {
//       if (score > highestScore) {
//         highestScore = score;
//         setWinner = participant;
//       }
//     });

//     // Award set to winner
//     setState(() {
//       if (setWinner.isNotEmpty) {
//         setsWon[setWinner] = setsWon[setWinner]! + 1;
//       }
      
//       // Reset scores for next set
//       scores = {for (String participant in widget.participants) participant: 0};
//       currentSet++;
//     });
    
//     _saveMatchState();
//     _checkSetWinCondition();
//   }

//   void _checkWinCondition() {
//     if (widget.sportConfig.scoreType == ScoreType.winBased || 
//         widget.sportConfig.scoreType == ScoreType.pointBased) {
      
//       // Check if any participant has reached the winning score
//       scores.forEach((participant, score) {
//         if (widget.sportConfig.winConditions != null && 
//             score >= widget.sportConfig.winConditions!) {
//           _endGame(participant);
//         }
//       });
//     }
//   }

//   void _checkSetWinCondition() {
//     if (widget.sportConfig.scoreType == ScoreType.setBased && widget.setFormat != null) {
//       final setsToWin = (widget.setFormat! / 2).ceil();
      
//       setsWon.forEach((participant, sets) {
//         if (sets >= setsToWin) {
//           _endGame(participant);
//         }
//       });
//     }
//   }

//   void _endGame(String winner) {
//     setState(() {
//       isMatchEnded = true;
//       matchWinner = winner;
//     });
    
//     stopwatch.stop();
//     _saveMatchState();
    
//     // Navigate to summary
//     _navigateToSummary();
//   }

//   void _navigateToSummary() {
//     final gameResult = isMatchEnded 
//         ? (matchWinner.isNotEmpty ? '$matchWinner Wins!' : 'Draw!')
//         : 'Game Ended';
    
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GameSummaryScreen(
//           sportConfig: widget.sportConfig,
//           participants: widget.participants,
//           finalScores: scores,
//           finalSetsWon: widget.sportConfig.scoreType == ScoreType.setBased ? setsWon : null,
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
//                 context.read<GameProvider>().updateMatchStatus(widget.matchId, MatchStatus.completed);
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
































// import 'package:booking_application/views/Games/create_games.dart';
// import 'package:booking_application/views/Games/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/games_view_screen.dart';
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
//         Uri.parse('$baseUrl/users/getsingle/$matchId'),
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
  
//   // Update football match status
//   static Future<void> updateFootballStatus(
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

//       print("Rrrrrrrrrrrrr${response.statusCode}");
      
//       if (response.statusCode != 200) {
//         throw Exception('Failed to update match status');
//       }
//     } catch (e) {
//       print('Error updating match status: $e');
//       rethrow;
//     }
//   }
  
//   // Add goal
//   static Future<void> addGoal(
//     String userId,
//     String matchId,
//     String teamId,
//     String action, // "increment" or "decrement"
//   ) async {
//     try {
      
//       final payload = {
//         "goalUpdate": {
//           "teamId": teamId,
//           "action": action,
//         }
//       };

//       print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT${payload['goalUpdate']?['teamId']}");
//             print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT${payload['goalUpdate']?['action']}");
//                         print("User$userId");

//             print("Match$matchId");


      
//       await updateFootballStatus(userId, matchId, payload);
//     } catch (e) {
//       print('Error adding goal: $e');
//       rethrow;
//     }
//   }
  
//   // Update half-time
//   static Future<void> updateHalfTime(
//     String userId,
//     String matchId,
//     int teamAScore,
//     int teamBScore,
//     int timeElapsed,
//   ) async {
//     try {
//       final payload = {
//         "status": "half-time",
//         "halfTimeScore": {
//           "teamA": teamAScore,
//           "teamB": teamBScore,
//         },
//         "timeElapsed": timeElapsed,
//       };
      
//       await updateFootballStatus(userId, matchId, payload);
//     } catch (e) {
//       print('Error updating half-time: $e');
//       rethrow;
//     }
//   }
  
//   // Update extra time
//   static Future<void> updateExtraTime(
//     String userId,
//     String matchId,
//     int teamAScore,
//     int teamBScore,
//     int timeElapsed,
//   ) async {
//     try {
//       final payload = {
//         "status": "extra-time",
//         "extraTimeScore": {
//           "teamA": teamAScore,
//           "teamB": teamBScore,
//         },
//         "timeElapsed": timeElapsed,
//       };
      
//       await updateFootballStatus(userId, matchId, payload);
//     } catch (e) {
//       print('Error updating extra time: $e');
//       rethrow;
//     }
//   }
  
//   // Update penalties
//   static Future<void> updatePenalties(
//     String userId,
//     String matchId,
//     int teamAScore,
//     int teamBScore,
//   ) async {
//     try {
//       final payload = {
//         "status": "penalties",
//         "penaltyScore": {
//           "teamA": teamAScore,
//           "teamB": teamBScore,
//         }
//       };
      
//       await updateFootballStatus(userId, matchId, payload);
//     } catch (e) {
//       print('Error updating penalties: $e');
//       rethrow;
//     }
//   }
  
//   // Finish match
//   static Future<void> finishMatch(
//     String userId,
//     String matchId,
//     int teamAScore,
//     int teamBScore,
//     int timeElapsed,
//   ) async {
//     try {
//       final payload = {
//         "status": "finished",
//         "finalScore": {
//           "teamA": teamAScore,
//           "teamB": teamBScore,
//         },
//         "timeElapsed": timeElapsed,
//       };
      
//       await updateFootballStatus(userId, matchId, payload);
//     } catch (e) {
//       print('Error finishing match: $e');
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
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.sportName,
//     required this.participants,
//     required this.finalScores,
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
//             // Final scores and navigation buttons would go here
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Update match status to completed in provider
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

// // Scorecard Screen with Provider Integration
// class ScorecardScreen extends StatefulWidget {
//   final String matchId;

//   const ScorecardScreen({
//     super.key,
//     required this.matchId,
//   });

//   @override
//   State<ScorecardScreen> createState() => _ScorecardScreenState();
// }

// class _ScorecardScreenState extends State<ScorecardScreen> {
//   late Map<String, int> scores;
//   late bool isMatchEnded;
//   late String matchWinner;
//   late Stopwatch stopwatch;
//   late String currentPeriod;
//   late Duration initialElapsedTime;
  
//   // API related fields
//   Map<String, dynamic>? matchData;
//   bool isLoading = true;
//   List<String> teamIds = [];
//   List<String> participants = [];
//   String userId = '';
//   String sportName = '';
//   String scoringMethod = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeSocket();
//     _fetchMatchData();
//   }

//   void _initializeSocket() {
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);
    
//     // Listen to live score updates
//     SocketService.listenToLiveScoreUpdate((data) {
//       if (mounted) {
//         setState(() {
//           // Update scores from socket data
//           if (data['teamScores'] != null) {
//             _updateScoresFromSocket(data['teamScores']);
//           }
//         });
//       }
//     });
    
//     // Listen to single match data updates
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
//     if (matchData == null) {
//       return;
//     }
    
//     // Extract userId from createdBy
//     if (matchData!['createdBy'] != null) {
//       userId = matchData!['createdBy']['_id'] ?? '';
//     }
    
//     // Extract sport name from categoryId
//     if (matchData!['categoryId'] != null) {
//       sportName = matchData!['categoryId']['name'] ?? 'Match';
//     }
    
//     // Extract scoring method
//     scoringMethod = matchData!['scoringMethod'] ?? 'Goal Based';
    
//     // Extract team IDs and create participant names
//     if (matchData!['teams'] != null) {
//       final teams = matchData!['teams'] as List;
//       teamIds = teams.map((team) => team['teamId'].toString()).toList();
      
//       // For now, use Team A and Team B as participant names
//       // You can enhance this to fetch actual team names from another API
//       participants = List.generate(
//         teams.length, 
//         (index) => 'Team ${String.fromCharCode(65 + index)}' // Team A, Team B, etc.
//       );
//     }
    
//     // Initialize scores based on scoring method
//     if (scoringMethod == 'Goal Based') {
//       // For goal-based, use finalScore or initialize to 0
//       final finalScore = matchData!['finalScore'] ?? {};
//       scores = {
//         if (participants.isNotEmpty) participants[0]: finalScore['teamA'] ?? 0,
//         if (participants.length > 1) participants[1]: finalScore['teamB'] ?? 0,
//       };
//     } else {
//       // For other types, initialize to 0
//       scores = {for (String participant in participants) participant: 0};
//     }
    
//     isMatchEnded = matchData!['status'] == 'finished';
//     matchWinner = '';
    
//     // Determine current period based on status
//     final status = matchData!['status'] ?? 'live';
//     if (status == 'half-time') {
//       currentPeriod = '2nd Half';
//     } else if (status == 'extra-time') {
//       currentPeriod = 'Extra Time';
//     } else if (status == 'penalties') {
//       currentPeriod = 'Penalties';
//     } else {
//       currentPeriod = '1st Half';
//     }
    
//     // Initialize time elapsed
//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);
    
//     stopwatch = Stopwatch();
//     if (status == 'live') {
//       stopwatch.start();
//       // Update match status to live when starting
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//       });
//     }
//   }

//   void _updateScoresFromSocket(Map<String, dynamic> teamScores) {
//     // Update local scores based on socket data
//     teamScores.forEach((teamId, score) {
//       final index = teamIds.indexOf(teamId);
//       if (index >= 0 && index < participants.length) {
//         scores[participants[index]] = score;
//       }
//     });
//   }

//   void _updateFromMatchData() {
//     if (matchData == null) return;
    
//     // Update scores from match data
//     if (scoringMethod == 'Goal Based') {
//       final finalScore = matchData!['finalScore'] ?? {};
//       if (participants.isNotEmpty) {
//         scores[participants[0]] = finalScore['teamA'] ?? 0;
//         if (participants.length > 1) {
//           scores[participants[1]] = finalScore['teamB'] ?? 0;
//         }
//       }
//     }
    
//     // Update match status
//     final status = matchData!['status'] ?? 'live';
//     isMatchEnded = status == 'finished';
    
//     // Update time elapsed
//     final timeElapsed = matchData!['timeElapsed'] ?? 0;
//     initialElapsedTime = Duration(minutes: timeElapsed);
//   }

//   @override
//   void dispose() {
//     stopwatch.stop();
//     SocketService.dispose();
//     super.dispose();
//   }

//   Duration get totalElapsedTime => initialElapsedTime + stopwatch.elapsed;

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
//                 child: _buildGoalBasedScorecard(),
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
//         InkWell(
//           onTap: _showNewGameDialog,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xFFE5E7EB)),
//             ),
//             child: const Text(
//               'New Game',
//               style: TextStyle(
//                 color: Color(0xFF374151),
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ),
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

//   // Goal-based Scorecard - Properly implemented with API integration
//   Widget _buildGoalBasedScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 16),
//         _buildPeriodSelector(),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: participants.length > 2
//               ? Column(
//                   children: participants.asMap().entries.map((entry) {
//                     final index = entry.key;
//                     final participant = entry.value;
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: const Color(0xFFE5E7EB)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.08),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: _buildGoalParticipantCard(participant, index),
//                     );
//                   }).toList(),
//                 )
//               : Row(
//                   children: participants.asMap().entries.map((entry) {
//                     final index = entry.key;
//                     final participant = entry.value;
//                     return Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: const Color(0xFFE5E7EB)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.08),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: _buildGoalParticipantCard(participant, index),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildGoalParticipantCard(String participant, int participantIndex) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           participant,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 16),
//         Container(
//           width: 90,
//           height: 90,
//           decoration: BoxDecoration(
//             color: const Color(0xFF10B981),
//             borderRadius: BorderRadius.circular(45),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF10B981).withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               '${scores[participant] ?? 0}',
//               style: const TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           'Goals',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF6B7280),
//           ),
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
//                 onPressed: () => _decrementScore(participant, participantIndex),
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
//                 onPressed: () => _incrementScore(participant, participantIndex),
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

//   Widget _buildPeriodSelector() {
//     final periods = ['1st Half', '2nd Half', 'Extra Time'];
    
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3F4F6),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: periods.map((period) {
//           final isSelected = currentPeriod == period;
//           return GestureDetector(
//             onTap: () async {
//               setState(() {
//                 currentPeriod = period;
//               });
              
//               // Update API based on period
//               if (scoringMethod == 'Goal Based') {
//                 try {
//                   final teamAScore = participants.isNotEmpty ? scores[participants[0]] ?? 0 : 0;
//                   final teamBScore = participants.length > 1 ? scores[participants[1]] ?? 0 : 0;
//                   final timeElapsed = totalElapsedTime.inMinutes;
                  
//                   if (period == '2nd Half') {
//                     await MatchApiService.updateHalfTime(
//                       userId,
//                       widget.matchId,
//                       teamAScore,
//                       teamBScore,
//                       timeElapsed,
//                     );
//                   } else if (period == 'Extra Time') {
//                     await MatchApiService.updateExtraTime(
//                       userId,
//                       widget.matchId,
//                       teamAScore,
//                       teamBScore,
//                       timeElapsed,
//                     );
//                   }
//                 } catch (e) {
//                   print('Error updating period: $e');
//                 }
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 period,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : const Color(0xFF6B7280),
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   void _incrementScore(String participant, int participantIndex) async {
//     setState(() {
//       scores[participant] = (scores[participant] ?? 0) + 1;
//     });
    
//     // Update API for goal-based scoring
//     if (scoringMethod == 'Goal Based' && participantIndex < teamIds.length) {
//       try {
//         await MatchApiService.addGoal(
//           userId,
//           widget.matchId,
//           teamIds[participantIndex],
//           'increment',
//         );
//       } catch (e) {
//         print('Error incrementing score: $e');
//       }
//     }
//   }

//   void _decrementScore(String participant, int participantIndex) async {
//     if ((scores[participant] ?? 0) > 0) {
//       setState(() {
//         scores[participant] = (scores[participant] ?? 0) - 1;
//       });
      
//       // Update API for goal-based scoring
//       if (scoringMethod == 'Goal Based' && participantIndex < teamIds.length) {
//         try {
//           await MatchApiService.addGoal(
//             userId,
//             widget.matchId,
//             teamIds[participantIndex],
//             'decrement',
//           );
//         } catch (e) {
//           print('Error decrementing score: $e');
//         }
//       }
//     }
//   }

//   void _endGame(String winner) async {
//     setState(() {
//       isMatchEnded = true;
//       matchWinner = winner;
//     });
    
//     stopwatch.stop();
    
//     // Update API to finish match
//     if (scoringMethod == 'Goal Based') {
//       try {
//         final teamAScore = participants.isNotEmpty ? scores[participants[0]] ?? 0 : 0;
//         final teamBScore = participants.length > 1 ? scores[participants[1]] ?? 0 : 0;
//         final timeElapsed = totalElapsedTime.inMinutes;
        
//         await MatchApiService.finishMatch(
//           userId,
//           widget.matchId,
//           teamAScore,
//           teamBScore,
//           timeElapsed,
//         );
//       } catch (e) {
//         print('Error finishing match: $e');
//       }
//     }
    
//     // Navigate to summary
//     _navigateToSummary();
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

// // COMMENTED OUT: Win-based/Point-based scoring (not currently used)
// /*
// Widget _buildWinBasedScorecard() {
//   return Column(
//     children: [
//       _buildTimer(),
//       const SizedBox(height: 24),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: participants.length > 2
//             ? Column(
//                 children: participants.map((participant) {
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: const Color(0xFFE5E7EB)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.08),
//                           spreadRadius: 1,
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: _buildParticipantCard(participant, true),
//                   );
//                 }).toList(),
//               )
//             : Row(
//                 children: participants.map((participant) {
//                   return Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: const Color(0xFFE5E7EB)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.08),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: _buildParticipantCard(participant, true),
//                     ),
//                   );
//                 }).toList(),
//               ),
//       ),
//       const SizedBox(height: 24),
//     ],
//   );
// }

// Widget _buildParticipantCard(String participant, bool showButton) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Text(
//         participant,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF1F2937),
//         ),
//         overflow: TextOverflow.ellipsis,
//         textAlign: TextAlign.center,
//       ),
//       const SizedBox(height: 12),
//       Text(
//         'Points',
//         style: const TextStyle(
//           fontSize: 14,
//           color: Color(0xFF6B7280),
//         ),
//       ),
//       const SizedBox(height: 12),
//       Container(
//         width: 70,
//         height: 70,
//         decoration: BoxDecoration(
//           color: const Color(0xFF10B981),
//           borderRadius: BorderRadius.circular(35),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF10B981).withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             '${scores[participant]}',
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//       if (showButton) ...[
//         const SizedBox(height: 20),
//         SizedBox(
//           width: double.infinity,
//           height: 44,
//           child: ElevatedButton(
//             onPressed: () => _awardPoint(participant),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF3B82F6),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 2,
//             ),
//             child: const Text(
//               'Award Point',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ],
//   );
// }

// void _awardPoint(String participant) {
//   setState(() {
//     scores[participant] = scores[participant]! + 1;
//   });
//   _checkWinCondition();
// }

// void _checkWinCondition() {
//   // Check if any participant has reached the winning score
//   scores.forEach((participant, score) {
//     if (score >= someWinCondition) {
//       _endGame(participant);
//     }
//   });
// }
// */

// // COMMENTED OUT: Set-based scoring (not currently used)
// /*
// Widget _buildSetBasedScorecard() {
//   return Column(
//     children: [
//       _buildTimer(),
//       const SizedBox(height: 16),
//       _buildSetInfo(),
//       const SizedBox(height: 24),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Row(
//           children: participants.map((participant) {
//             return Expanded(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: const Color(0xFFE5E7EB)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.08),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: _buildSetParticipantCard(participant),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       const SizedBox(height: 24),
//     ],
//   );
// }

// Widget _buildSetParticipantCard(String participant) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Text(
//         participant,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF1F2937),
//         ),
//         overflow: TextOverflow.ellipsis,
//         textAlign: TextAlign.center,
//       ),
//       const SizedBox(height: 20),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF10B981),
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF10B981).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     '${scores[participant]}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Points',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF6B7280),
//                 ),
//               ),
//             ],
//           ),
//           const Text(
//             '/',
//             style: TextStyle(
//               fontSize: 24,
//               color: Color(0xFF9CA3AF),
//             ),
//           ),
//           Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF6B7280),
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF6B7280).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     '${setsWon[participant]}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Sets Won',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF6B7280),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: const Color(0xFFEF4444),
//               borderRadius: BorderRadius.circular(22),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFFEF4444).withOpacity(0.2),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: IconButton(
//               onPressed: () => _decrementScore(participant, 0),
//               icon: const Icon(Icons.remove, color: Colors.white, size: 20),
//             ),
//           ),
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: const Color(0xFF10B981),
//               borderRadius: BorderRadius.circular(22),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF10B981).withOpacity(0.2),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: IconButton(
//               onPressed: () => _incrementScore(participant, 0),
//               icon: const Icon(Icons.add, color: Colors.white, size: 20),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget _buildSetInfo() {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 16),
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: const Color(0xFFF8FAFC),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: const Color(0xFFE2E8F0)),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.sports_tennis,
//           color: const Color(0xFF3B82F6),
//           size: 20,
//         ),
//         const SizedBox(width: 8),
//         Text(
//           'Set $currentSet',
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// void _endCurrentSet() {
//   // Determine set winner
//   String setWinner = '';
//   int highestScore = 0;
  
//   scores.forEach((participant, score) {
//     if (score > highestScore) {
//       highestScore = score;
//       setWinner = participant;
//     }
//   });

//   // Award set to winner
//   setState(() {
//     if (setWinner.isNotEmpty) {
//       setsWon[setWinner] = setsWon[setWinner]! + 1;
//     }
    
//     // Reset scores for next set
//     scores = {for (String participant in participants) participant: 0};
//     currentSet++;
//   });
  
//   _checkSetWinCondition();
// }

// void _checkSetWinCondition() {
//   // Check if any participant has won enough sets
//   setsWon.forEach((participant, sets) {
//     if (sets >= setsToWin) {
//       _endGame(participant);
//     }
//   });
// }
// */

















import 'package:booking_application/views/Games/create_games.dart';
import 'package:booking_application/views/Games/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/games_view_screen.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// API Service Class
class MatchApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';
  
  // Fetch single match data
  static Future<Map<String, dynamic>> getMatchData(String matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsingle/$matchId'),
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
  
  // Update football match status
  static Future<void> updateFootballStatus(
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

      print("Rrrrrrrrrrrrr${response.statusCode}");
      
      if (response.statusCode != 200) {
        throw Exception('Failed to update match status');
      }
    } catch (e) {
      print('Error updating match status: $e');
      rethrow;
    }
  }
  
  // Add goal
  static Future<void> addGoal(
    String userId,
    String matchId,
    String teamId,
    String action, // "increment" or "decrement"
  ) async {
    try {
      
      final payload = {
        "goalUpdate": {
          "teamId": teamId,
          "action": action,
        }
      };

      print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT${payload['goalUpdate']?['teamId']}");
            print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT${payload['goalUpdate']?['action']}");
                        print("User$userId");

            print("Match$matchId");


      
      await updateFootballStatus(userId, matchId, payload);
    } catch (e) {
      print('Error adding goal: $e');
      rethrow;
    }
  }
  
  // Update half-time
  static Future<void> updateHalfTime(
    String userId,
    String matchId,
    int teamAScore,
    int teamBScore,
    int timeElapsed,
  ) async {
    try {
      final payload = {
        "status": "half-time",
        "halfTimeScore": {
          "teamA": teamAScore,
          "teamB": teamBScore,
        },
        "timeElapsed": timeElapsed,
      };
      
      await updateFootballStatus(userId, matchId, payload);
    } catch (e) {
      print('Error updating half-time: $e');
      rethrow;
    }
  }
  
  // Update extra time
  static Future<void> updateExtraTime(
    String userId,
    String matchId,
    int teamAScore,
    int teamBScore,
    int timeElapsed,
  ) async {
    try {
      final payload = {
        "status": "extra-time",
        "extraTimeScore": {
          "teamA": teamAScore,
          "teamB": teamBScore,
        },
        "timeElapsed": timeElapsed,
      };
      
      await updateFootballStatus(userId, matchId, payload);
    } catch (e) {
      print('Error updating extra time: $e');
      rethrow;
    }
  }
  
  // Update penalties
  static Future<void> updatePenalties(
    String userId,
    String matchId,
    int teamAScore,
    int teamBScore,
  ) async {
    try {
      final payload = {
        "status": "penalties",
        "penaltyScore": {
          "teamA": teamAScore,
          "teamB": teamBScore,
        }
      };
      
      await updateFootballStatus(userId, matchId, payload);
    } catch (e) {
      print('Error updating penalties: $e');
      rethrow;
    }
  }
  
  // Finish match
  static Future<void> finishMatch(
    String userId,
    String matchId,
    int teamAScore,
    int teamBScore,
    int timeElapsed,
  ) async {
    try {
      final payload = {
        "status": "finished",
        "finalScore": {
          "teamA": teamAScore,
          "teamB": teamBScore,
        },
        "timeElapsed": timeElapsed,
      };
      
      await updateFootballStatus(userId, matchId, payload);
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

// Game Summary Screen for displaying final results
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
            // Final scores and navigation buttons would go here
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Update match status to completed in provider
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

// Scorecard Screen with Provider Integration
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
  late Map<String, int> scores;
  late bool isMatchEnded;
  late String matchWinner;
  late String currentPeriod;
  
  // Timer related fields
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  
  // API related fields
  Map<String, dynamic>? matchData;
  bool isLoading = true;
  List<String> teamIds = [];
  List<String> participants = [];
  String userId = '';
  String sportName = '';
  String scoringMethod = '';

  @override
  void initState() {
    super.initState();
    _initializeSocket();
    _fetchMatchData();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedTime = _calculateElapsedTime();
        });
      }
    });
  }

  void _initializeSocket() {
    SocketService.initSocket();
    SocketService.joinMatch(widget.matchId);
    
    // Listen to live score updates
    SocketService.listenToLiveScoreUpdate((data) {
      if (mounted) {
        setState(() {
          // Update scores from socket data
          if (data['teamScores'] != null) {
            _updateScoresFromSocket(data['teamScores']);
          }
          _elapsedTime = _calculateElapsedTime(); // Update time on socket updates
        });
      }
    });
    
    // Listen to single match data updates
    SocketService.listenToSingleMatchData((data) {
      if (mounted) {
        setState(() {
          matchData = data['match'];
          _updateFromMatchData();
          _elapsedTime = _calculateElapsedTime(); // Update time on data updates
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
          _elapsedTime = _calculateElapsedTime(); // Update elapsed time when data loads
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
    if (matchData == null) {
      return;
    }
    
    // Extract userId from createdBy
    if (matchData!['createdBy'] != null) {
      userId = matchData!['createdBy']['_id'] ?? '';
    }
    
    // Extract sport name from categoryId
    if (matchData!['categoryId'] != null) {
      sportName = matchData!['categoryId']['name'] ?? 'Match';
    }
    
    // Extract scoring method
    scoringMethod = matchData!['scoringMethod'] ?? 'Goal Based';
    
    // Extract team IDs and create participant names
    if (matchData!['teams'] != null) {
      final teams = matchData!['teams'] as List;
      teamIds = teams.map((team) => team['teamId'].toString()).toList();
      
      // For now, use Team A and Team B as participant names
      // You can enhance this to fetch actual team names from another API
      participants = List.generate(
        teams.length, 
        (index) => 'Team ${String.fromCharCode(65 + index)}' // Team A, Team B, etc.
      );
    }
    
    // Initialize scores based on scoring method
    if (scoringMethod == 'Goal Based') {
      // For goal-based, use finalScore or initialize to 0
      final finalScore = matchData!['finalScore'] ?? {};
      scores = {
        if (participants.isNotEmpty) participants[0]: finalScore['teamA'] ?? 0,
        if (participants.length > 1) participants[1]: finalScore['teamB'] ?? 0,
      };
    } else {
      // For other types, initialize to 0
      scores = {for (String participant in participants) participant: 0};
    }
    
    isMatchEnded = matchData!['status'] == 'finished';
    matchWinner = '';
    
    // Determine current period based on status
    final status = matchData!['status'] ?? 'live';
    if (status == 'half-time') {
      currentPeriod = '2nd Half';
    } else if (status == 'extra-time') {
      currentPeriod = 'Extra Time';
    } else if (status == 'penalties') {
      currentPeriod = 'Penalties';
    } else {
      currentPeriod = '1st Half';
    }
    
    // Update match status to live when starting
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
    });
  }

  Duration _calculateElapsedTime() {
    if (matchData == null || matchData!['kickOffTime'] == null) {
      return Duration.zero;
    }
    
    try {
      // Parse kickOffTime from API
      final kickOffTimeString = matchData!['kickOffTime'];
      final kickOffTime = DateTime.parse(kickOffTimeString);
      final now = DateTime.now().toUtc(); // Use UTC to match API time
      
      // Calculate difference
      final difference = now.difference(kickOffTime);
      
      // Return the elapsed time (can't be negative)
      return difference.isNegative ? Duration.zero : difference;
    } catch (e) {
      print('Error calculating elapsed time: $e');
      return Duration.zero;
    }
  }

  void _updateScoresFromSocket(Map<String, dynamic> teamScores) {
    // Update local scores based on socket data
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
    if (scoringMethod == 'Goal Based') {
      final finalScore = matchData!['finalScore'] ?? {};
      if (participants.isNotEmpty) {
        scores[participants[0]] = finalScore['teamA'] ?? 0;
        if (participants.length > 1) {
          scores[participants[1]] = finalScore['teamB'] ?? 0;
        }
      }
    }
    
    // Update match status
    final status = matchData!['status'] ?? 'live';
    isMatchEnded = status == 'finished';
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
                child: _buildGoalBasedScorecard(),
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

  // Goal-based Scorecard - Properly implemented with API integration
  Widget _buildGoalBasedScorecard() {
    return Column(
      children: [
        _buildTimer(),
        const SizedBox(height: 16),
        _buildPeriodSelector(),
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
                      child: _buildGoalParticipantCard(participant, index),
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
                        child: _buildGoalParticipantCard(participant, index),
                      ),
                    );
                  }).toList(),
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildGoalParticipantCard(String participant, int participantIndex) {
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
              '${scores[participant] ?? 0}',
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
                onPressed: () => _decrementScore(participant, participantIndex),
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
                onPressed: () => _incrementScore(participant, participantIndex),
                icon: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimer() {
    final minutes = _elapsedTime.inMinutes;
    final seconds = _elapsedTime.inSeconds % 60;
    
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
              Icon(
                Icons.schedule,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'LIVE',
                style: TextStyle(
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

  Widget _buildPeriodSelector() {
    final periods = ['1st Half', '2nd Half', 'Extra Time'];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: periods.map((period) {
          final isSelected = currentPeriod == period;
          return GestureDetector(
            onTap: () async {
              setState(() {
                currentPeriod = period;
              });
              
              // Update API based on period
              if (scoringMethod == 'Goal Based') {
                try {
                  final teamAScore = participants.isNotEmpty ? scores[participants[0]] ?? 0 : 0;
                  final teamBScore = participants.length > 1 ? scores[participants[1]] ?? 0 : 0;
                  final timeElapsed = _elapsedTime.inMinutes;
                  
                  if (period == '2nd Half') {
                    await MatchApiService.updateHalfTime(
                      userId,
                      widget.matchId,
                      teamAScore,
                      teamBScore,
                      timeElapsed,
                    );
                  } else if (period == 'Extra Time') {
                    await MatchApiService.updateExtraTime(
                      userId,
                      widget.matchId,
                      teamAScore,
                      teamBScore,
                      timeElapsed,
                    );
                  }
                } catch (e) {
                  print('Error updating period: $e');
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                period,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _incrementScore(String participant, int participantIndex) async {
    setState(() {
      scores[participant] = (scores[participant] ?? 0) + 1;
    });
    
    // Update API for goal-based scoring
    if (scoringMethod == 'Goal Based' && participantIndex < teamIds.length) {
      try {
        await MatchApiService.addGoal(
          userId,
          widget.matchId,
          teamIds[participantIndex],
          'increment',
        );
      } catch (e) {
        print('Error incrementing score: $e');
      }
    }
  }

  void _decrementScore(String participant, int participantIndex) async {
    if ((scores[participant] ?? 0) > 0) {
      setState(() {
        scores[participant] = (scores[participant] ?? 0) - 1;
      });
      
      // Update API for goal-based scoring
      if (scoringMethod == 'Goal Based' && participantIndex < teamIds.length) {
        try {
          await MatchApiService.addGoal(
            userId,
            widget.matchId,
            teamIds[participantIndex],
            'decrement',
          );
        } catch (e) {
          print('Error decrementing score: $e');
        }
      }
    }
  }

  void _endGame(String winner) async {
    setState(() {
      isMatchEnded = true;
      matchWinner = winner;
    });
    
    // Update API to finish match
    if (scoringMethod == 'Goal Based') {
      try {
        final teamAScore = participants.isNotEmpty ? scores[participants[0]] ?? 0 : 0;
        final teamBScore = participants.length > 1 ? scores[participants[1]] ?? 0 : 0;
        final timeElapsed = _elapsedTime.inMinutes;
        
        await MatchApiService.finishMatch(
          userId,
          widget.matchId,
          teamAScore,
          teamBScore,
          timeElapsed,
        );
      } catch (e) {
        print('Error finishing match: $e');
      }
    }
    
    // Navigate to summary
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
          gameDuration: _elapsedTime,
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
                _endGame('');
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