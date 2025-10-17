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
// import 'dart:async';
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
//   late String currentPeriod;

//   // Timer related fields
//   Timer? _timer;
//   Duration _elapsedTime = Duration.zero;

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
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           _elapsedTime = _calculateElapsedTime();
//         });
//       }
//     });
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
//           _elapsedTime = _calculateElapsedTime(); // Update time on socket updates
//         });
//       }
//     });

//     // Listen to single match data updates
//     SocketService.listenToSingleMatchData((data) {
//       if (mounted) {
//         setState(() {
//           matchData = data['match'];
//           _updateFromMatchData();
//           _elapsedTime = _calculateElapsedTime(); // Update time on data updates
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
//           _elapsedTime = _calculateElapsedTime(); // Update elapsed time when data loads
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

//     // Update match status to live when starting
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//     });
//   }

//   Duration _calculateElapsedTime() {
//     if (matchData == null || matchData!['kickOffTime'] == null) {
//       return Duration.zero;
//     }

//     try {
//       // Parse kickOffTime from API
//       final kickOffTimeString = matchData!['kickOffTime'];
//       final kickOffTime = DateTime.parse(kickOffTimeString);
//       final now = DateTime.now().toUtc(); // Use UTC to match API time

//       // Calculate difference
//       final difference = now.difference(kickOffTime);

//       // Return the elapsed time (can't be negative)
//       return difference.isNegative ? Duration.zero : difference;
//     } catch (e) {
//       print('Error calculating elapsed time: $e');
//       return Duration.zero;
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
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     SocketService.dispose();
//     super.dispose();
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
//     final minutes = _elapsedTime.inMinutes;
//     final seconds = _elapsedTime.inSeconds % 60;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F2937),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Match Time',
//                 style: TextStyle(
//                   color: Color(0xFF9CA3AF),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.schedule,
//                 color: Colors.white,
//                 size: 28,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 'LIVE',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
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
//                   final timeElapsed = _elapsedTime.inMinutes;

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

//     // Update API to finish match
//     if (scoringMethod == 'Goal Based') {
//       try {
//         final teamAScore = participants.isNotEmpty ? scores[participants[0]] ?? 0 : 0;
//         final teamBScore = participants.length > 1 ? scores[participants[1]] ?? 0 : 0;
//         final timeElapsed = _elapsedTime.inMinutes;

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
//           gameDuration: _elapsedTime,
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

// import 'package:booking_application/views/Games/create_games.dart';
// import 'package:booking_application/views/Games/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/games_view_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   // Fetch single match data using the new endpoint
//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglegamematch/$matchId'),
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

//   // Update score using the correct endpoint
//   static Future<void> updateScore(
//     String matchId,
//     Map<String, dynamic> payload,
//   ) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/users/update-score/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       print("Update score response: ${response.statusCode}");

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update score');
//       }
//     } catch (e) {
//       print('Error updating score: $e');
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

//   static void listenToMatchUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('match:update', (data) {
//       print('Match update received: $data');
//       callback(data);
//     });
//   }

//   static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('liveScoreUpdate', (data) {
//       print('Live score update received: $data');
//       callback(data);
//     });
//   }

//   static void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//   }
// }

// // Game Summary Screen
// class GameSummaryScreen extends StatelessWidget {
//   final String matchName;
//   final Map<String, int> finalScores;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.matchName,
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
//                     matchName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
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

// // Football Scorecard Screen
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
//   Timer? _timer;
//   Duration _elapsedTime = Duration.zero;

//   Map<String, dynamic>? matchData;
//   bool isLoading = true;

//   String matchName = '';
//   String currentStatus = 'live';
//   List<Map<String, dynamic>> teams = [];
//   Map<String, int> teamScores = {};

//   DateTime? kickOffTime;

// @override
// void initState() {
//   super.initState();
//   _initSetup();
// }

// Future<void> _initSetup() async {
//   await _initializeSocket();   // Wait until socket is connected
//   await _fetchMatchData();     // Wait until match data is fetched
//   _startTimer();               // Then start timer
// }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       print("lllllllllllllllllllllllllllllllllllllllll$kickOffTime");
//       if (kickOffTime != null) {
//         setState(() {
//           _elapsedTime = _calculateElapsedTime();
//         });
//       }
//     });
//   }

//   // Duration _calculateElapsedTime() {
//   //         print("lllllllllllllllllllllllllllllllllllllllll222$kickOffTime");

//   //   if (kickOffTime == null) {
//   //     return Duration.zero;
//   //   }

//   //   try {
//   //     final now = DateTime.now();
//   //               print("lllllllllllllllllllllllllllllllllllllllllnow$now");

//   //     final difference = now.difference(kickOffTime!);
//   //           print("lllllllllllllllllllllllllllllllllllllllll333${difference.isNegative ? Duration.zero : difference}");

//   //     // Return the elapsed time (can't be negative)
//   //     return difference.isNegative ? Duration.zero : difference;
//   //   } catch (e) {
//   //     print('Error calculating elapsed time: $e');
//   //     return Duration.zero;
//   //   }
//   // }

// Duration _calculateElapsedTime() {
//   if (kickOffTime == null) return Duration.zero;

//   try {
//     final now = DateTime.now(); // local
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
//           ) // manually rebuild as local (removes UTC/Z meaning)
//         : kickOffTime!;

//     print("now (local): $now");
//     print("kickoffLocal (Z removed): $kickoff");

//     final difference = now.difference(kickoff);
//     print("elapsed: ${difference.isNegative ? Duration.zero : difference}");

//     return difference.isNegative ? Duration.zero : difference;
//   } catch (e) {
//     print('Error calculating elapsed time: $e');
//     return Duration.zero;
//   }
// }

//   Future<void> _initializeSocket() async{
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);

//     // Listen to match updates
//     SocketService.listenToMatchUpdate((data) {
//       if (mounted) {
//         print('Match update received: $data');
//         setState(() {
//           _updateFromSocketData(data);
//         });
//       }
//     });

//     // Listen to live score updates
//     SocketService.listenToLiveScoreUpdate((data) {
//       if (mounted) {
//         print('Live score update: $data');
//         setState(() {
//           if (data['teamScores'] != null) {
//             final scores = data['teamScores'] as Map<String, dynamic>;
//             scores.forEach((teamId, score) {
//               teamScores[teamId] = score is int ? score : 0;
//             });
//           }
//         });
//       }
//     });
//   }

//   void _updateFromSocketData(Map<String, dynamic> data) {
//     // Update match name
//     if (data['name'] != null) {
//       matchName = data['name'];
//     }

//     // Update status
//     if (data['status'] != null) {
//       currentStatus = data['status'];
//     }

//     // Update kick off time
//     if (data['startKickTime'] != null) {
//       try {
//         setState(() {
//           kickOffTime = DateTime.parse(data['startKickTime']);
//         });
//         print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$kickOffTime");
//       } catch (e) {
//         print('Error parsing startKickTime: $e');
//       }
//     }

//     // Update live goal scores
//     if (data['liveGoalScores'] != null) {
//       final liveScores = data['liveGoalScores'] as List;
//       for (var score in liveScores) {
//         final teamId = score['teamId'] as String;
//         final goals = score['teamGoals'] as int;
//         teamScores[teamId] = goals;
//       }
//     }

//     // Update teams data
//     if (data['teams'] != null) {
//       teams = List<Map<String, dynamic>>.from(data['teams']);
//     }
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           isLoading = false;
//           _initializeFromMatchData();
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

//   void _initializeFromMatchData() {
//     if (matchData == null) return;

//     // Extract match name
//     matchName = matchData!['name'] ?? 'Football Match';

//     // Extract status
//     currentStatus = matchData!['status'] ?? 'live';

//     // Extract kick off time
//     if (matchData!['startKickTime'] != null) {
//       try {
//         kickOffTime = DateTime.parse(matchData!['startKickTime']);
//         _elapsedTime = _calculateElapsedTime();
//       } catch (e) {
//         print('Error parsing startKickTime: $e');
//       }
//     }

//     // Extract teams
//     if (matchData!['teams'] != null) {
//       teams = List<Map<String, dynamic>>.from(matchData!['teams']);
//     }

//     // Extract live goal scores
//     if (matchData!['liveGoalScores'] != null) {
//       final liveScores = matchData!['liveGoalScores'] as List;
//       for (var score in liveScores) {
//         final teamId = score['teamId'] as String;
//         final goals = score['teamGoals'] as int? ?? 0;
//         teamScores[teamId] = goals;
//       }
//     }

//     // Update match status to live in provider
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     SocketService.dispose();
//     super.dispose();
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

//     if (matchData == null || teams.isEmpty) {
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
//                 child: _buildFootballScorecard(),
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
//                       matchName,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Football Match',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
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

//   Widget _buildFootballScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 16),
//         _buildPeriodSelector(),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: teams.length == 2
//               ? Row(
//                   children: [
//                     Expanded(child: _buildTeamCard(0)),
//                     SizedBox(width: 16),
//                     Expanded(child: _buildTeamCard(1)),
//                   ],
//                 )
//               : Column(
//                   children: List.generate(
//                     teams.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: _buildTeamCard(index),
//                     ),
//                   ),
//                 ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildTeamCard(int teamIndex) {
//     if (teamIndex >= teams.length) return SizedBox.shrink();

//     final team = teams[teamIndex];
//     final teamId = team['teamId'] as String;
//     final teamName = _getTeamName(teamIndex);
//     final goals = teamScores[teamId] ?? 0;
//     final players = team['players'] as List? ?? [];

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             teamName,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             '${players.length} Players',
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               color: const Color(0xFF10B981),
//               borderRadius: BorderRadius.circular(45),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF10B981).withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 '$goals',
//                 style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Goals',
//             style: TextStyle(
//               fontSize: 14,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEF4444),
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFFEF4444).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   onPressed: () => _decrementScore(teamId, players),
//                   icon: const Icon(Icons.remove, color: Colors.white, size: 20),
//                 ),
//               ),
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF10B981),
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF10B981).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   onPressed: () => _incrementScore(teamId, players),
//                   icon: const Icon(Icons.add, color: Colors.white, size: 20),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _getTeamName(int index) {
//     if (index >= teams.length) return 'Team';

//     // Try to get team name from teams array or use default
//     final team = teams[index];
//     if (team['teamName'] != null) {
//       return team['teamName'];
//     }

//     // Fallback to Team A, Team B, etc.
//     return 'Team ${String.fromCharCode(65 + index)}';
//   }

//   Widget _buildTimer() {
//     final minutes = _elapsedTime.inMinutes;
//     final seconds = _elapsedTime.inSeconds % 60;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F2937),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Match Time',
//                 style: TextStyle(
//                   color: Color(0xFF9CA3AF),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.schedule,
//                 color: Colors.white,
//                 size: 28,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 'LIVE',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPeriodSelector() {
//     final periods = ['1st Half', '2nd Half', 'Extra Time'];
//     String currentPeriod = _getPeriodFromStatus();

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
//             onTap: () => _updatePeriod(period),
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

//   String _getPeriodFromStatus() {
//     if (currentStatus == 'half-time') return '2nd Half';
//     if (currentStatus == 'extra-time') return 'Extra Time';
//     return '1st Half';
//   }

//   Future<void> _updatePeriod(String period) async {
//     String newStatus = 'live';
//     if (period == '2nd Half') newStatus = 'half-time';
//     if (period == 'Extra Time') newStatus = 'extra-time';

//     setState(() {
//       currentStatus = newStatus;
//     });

//     try {
//       // Get first player from first team for the API call
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null && firstTeam['players'] != null && (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam == null || firstPlayer == null) return;

//       final payload = {
//         "teamId": firstTeam['teamId'],
//         "playerId": firstPlayer['playerId'],
//         "goals": 0,
//         "status": newStatus,
//         "timeElapsed": _elapsedTime.inMinutes,
//       };

//       await MatchApiService.updateScore(widget.matchId, payload);
//     } catch (e) {
//       print('Error updating period: $e');
//     }
//   }

//   Future<void> _incrementScore(String teamId, List players) async {
//     setState(() {
//       teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
//     });

//     try {
//       // Use first player for the API call
//       final firstPlayer = players.isNotEmpty ? players[0] : null;
//       if (firstPlayer == null) return;

//       final payload = {
//         "teamId": teamId,
//         "playerId": firstPlayer['playerId'],
//         "goals": 1,
//         "action": "inc"
//       };

//       await MatchApiService.updateScore(widget.matchId, payload);
//     } catch (e) {
//       print('Error incrementing score: $e');
//       // Revert on error
//       setState(() {
//         teamScores[teamId] = (teamScores[teamId] ?? 1) - 1;
//       });
//     }
//   }

//   Future<void> _decrementScore(String teamId, List players) async {
//     if ((teamScores[teamId] ?? 0) > 0) {
//       setState(() {
//         teamScores[teamId] = (teamScores[teamId] ?? 0) - 1;
//       });

//       try {
//         // Use first player for the API call
//         final firstPlayer = players.isNotEmpty ? players[0] : null;
//         if (firstPlayer == null) return;

//         final payload = {
//           "teamId": teamId,
//           "playerId": firstPlayer['playerId'],
//           "goals": 1,
//           "action": "dec"
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);
//       } catch (e) {
//         print('Error decrementing score: $e');
//         // Revert on error
//         setState(() {
//           teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
//         });
//       }
//     }
//   }

//   Future<void> _endGame() async {
//     try {
//       // Get winner
//       String winner = '';
//       if (teams.length == 2) {
//         final team1Id = teams[0]['teamId'] as String;
//         final team2Id = teams[1]['teamId'] as String;
//         final score1 = teamScores[team1Id] ?? 0;
//         final score2 = teamScores[team2Id] ?? 0;

//         if (score1 > score2) {
//           winner = _getTeamName(0);
//         } else if (score2 > score1) {
//           winner = _getTeamName(1);
//         }
//       }

//       // Get first player from first team for the API call
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null && firstTeam['players'] != null && (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         final team1Id = teams[0]['teamId'] as String;
//         final team2Id = teams.length > 1 ? teams[1]['teamId'] as String : team1Id;
//         final score1 = teamScores[team1Id] ?? 0;
//         final score2 = teamScores[team2Id] ?? 0;

//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "status": "finished",
//           "finalScore": {
//             "teamA": score1,
//             "teamB": score2,
//           },
//           "timeElapsed": _elapsedTime.inMinutes,
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);
//       }

//       // Navigate to summary
//       final gameResult = winner.isNotEmpty ? '$winner Wins!' : 'Draw!';

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GameSummaryScreen(
//             matchName: matchName,
//             finalScores: teamScores,
//             gameDuration: _elapsedTime,
//             gameResult: gameResult,
//             matchId: widget.matchId,
//           ),
//         ),
//       );
//     } catch (e) {
//       print('Error ending game: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error ending game: $e')),
//       );
//     }
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
//                 _endGame();
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

// import 'package:booking_application/views/Games/create_games.dart';
// import 'package:booking_application/views/Games/game_manager_screen.dart';
// import 'package:booking_application/views/Games/game_provider.dart';
// import 'package:booking_application/views/Games/games_view_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglegamematch/$matchId'),
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

//   static Future<void> updateScore(
//     String matchId,
//     Map<String, dynamic> payload,
//   ) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/users/update-score/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       print("Update score response: ${response.statusCode}");

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update score');
//       }
//     } catch (e) {
//       print('Error updating score: $e');
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

//   static void listenToMatchUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('match:update', (data) {
//       print('Match update received: $data');
//       callback(data);
//     });
//   }

//   static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('liveScoreUpdate', (data) {
//       print('Live score update received: $data');
//       callback(data);
//     });
//   }

//   static void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//   }
// }

// // Half-Time Break Screen
// class HalfTimeScreen extends StatelessWidget {
//   final String matchId;
//   final String matchName;
//   final Map<String, int> teamScores;
//   final List<Map<String, dynamic>> teams;

//   const HalfTimeScreen({
//     super.key,
//     required this.matchId,
//     required this.matchName,
//     required this.teamScores,
//     required this.teams,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1F2937),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.sports_soccer,
//                   size: 80,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'HALF TIME',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   matchName,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Color(0xFF9CA3AF),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 _buildScoreDisplay(),
//                 const SizedBox(height: 60),
//                 ElevatedButton(
//                   onPressed: () => _startSecondHalf(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF10B981),
//                     padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Start Second Half',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildScoreDisplay() {
//     final team1Id = teams.isNotEmpty ? teams[0]['teamId'] as String : '';
//     final team2Id = teams.length > 1 ? teams[1]['teamId'] as String : '';
//     final score1 = teamScores[team1Id] ?? 0;
//     final score2 = teamScores[team2Id] ?? 0;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 _getTeamName(0),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '$score1',
//                 style: const TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF10B981),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             '-',
//             style: TextStyle(
//               fontSize: 36,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 _getTeamName(1),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '$score2',
//                 style: const TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF10B981),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   String _getTeamName(int index) {
//     if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
//     final team = teams[index];
//     return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
//   }

//   Future<void> _startSecondHalf(BuildContext context) async {
//     try {
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//           firstTeam['players'] != null &&
//           (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "currentStatus": "second-half"
//         };

//         await MatchApiService.updateScore(matchId, payload);
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ScorecardScreen(matchId: matchId),
//         ),
//       );
//     } catch (e) {
//       print('Error starting second half: $e');
//     }
//   }
// }

// // Game Summary Screen
// class GameSummaryScreen extends StatelessWidget {
//   final String matchName;
//   final Map<String, int> finalScores;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.matchName,
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
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: gameResult.contains('Draw')
//                     ? const Color(0xFFF3F4F6)
//                     : const Color(0xFFDCFCE7),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: gameResult.contains('Draw')
//                       ? const Color(0xFFE5E7EB)
//                       : const Color(0xFF10B981),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     gameResult.contains('Draw')
//                         ? Icons.handshake
//                         : Icons.emoji_events,
//                     size: 48,
//                     color: gameResult.contains('Draw')
//                         ? const Color(0xFF6B7280)
//                         : const Color(0xFF10B981),
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
//                     matchName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
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
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Back to Games',
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

// // Football Scorecard Screen
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
//   Timer? _timer;
//   Duration _elapsedTime = Duration.zero;

//   Map<String, dynamic>? matchData;
//   bool isLoading = true;

//   String matchName = '';
//   String currentStatus = 'live';
//   List<Map<String, dynamic>> teams = [];
//   Map<String, int> teamScores = {};
//   List<Map<String, dynamic>> scoreCard = [];

//   DateTime? kickOffTime;
//   int totalDuration = 15;
//   int halfTimeDuration = 2;
//   bool extraTimeAllowed = false;
//   int extraTimeDuration = 0;
//   bool extraTimeAllowedForHalfTime = false;
//   int extraTimeDurationForHalfTime = 0;
//   bool extraTimeAllowedForFullTime = false;
//   int extraTimeDurationForFullTime = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initSetup();
//   }

//   Future<void> _initSetup() async {
//     await _initializeSocket();
//     await _fetchMatchData();
//     _checkMatchStatus();
//     _startTimer();
//   }

//   void _checkMatchStatus() {
//     if (currentStatus == 'break') {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HalfTimeScreen(
//               matchId: widget.matchId,
//               matchName: matchName,
//               teamScores: teamScores,
//               teams: teams,
//             ),
//           ),
//         );
//       });
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (kickOffTime != null && mounted) {
//         setState(() {
//           _elapsedTime = _calculateElapsedTime();
//           _checkForAutomaticBreaks();
//         });
//       }
//     });
//   }

//   void _checkForAutomaticBreaks() {
//     final minutes = _elapsedTime.inMinutes;

//     // Check for half-time
//     if (currentStatus == 'live' && minutes >= (totalDuration ~/ 2)) {
//       _showHalfTimeModal();
//     }

//     // Check for full-time
//     if (currentStatus == 'second-half' && minutes >= totalDuration) {
//       _showFullTimeModal();
//     }
//   }

//   Duration _calculateElapsedTime() {
//     if (kickOffTime == null) return Duration.zero;

//     try {
//       final now = DateTime.now();
//       final kickoff = kickOffTime!.isUtc
//           ? DateTime(
//               kickOffTime!.year,
//               kickOffTime!.month,
//               kickOffTime!.day,
//               kickOffTime!.hour,
//               kickOffTime!.minute,
//               kickOffTime!.second,
//               kickOffTime!.millisecond,
//               kickOffTime!.microsecond,
//             )
//           : kickOffTime!;

//       final difference = now.difference(kickoff);
//       return difference.isNegative ? Duration.zero : difference;
//     } catch (e) {
//       print('Error calculating elapsed time: $e');
//       return Duration.zero;
//     }
//   }

//   Future<void> _initializeSocket() async {
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);

//     SocketService.listenToMatchUpdate((data) {
//       if (mounted) {
//         setState(() {
//           _updateFromSocketData(data);
//         });
//       }
//     });

//     SocketService.listenToLiveScoreUpdate((data) {
//       if (mounted) {
//         setState(() {
//           if (data['teamScores'] != null) {
//             final scores = data['teamScores'] as Map<String, dynamic>;
//             scores.forEach((teamId, score) {
//               teamScores[teamId] = score is int ? score : 0;
//             });
//           }
//         });
//       }
//     });
//   }

//   void _updateFromSocketData(Map<String, dynamic> data) {
//     if (data['name'] != null) {
//       matchName = data['name'];
//     }

//     if (data['status'] != null || data['currentStatus'] != null) {
//       currentStatus = data['currentStatus'] ?? data['status'] ?? 'live';
//       _checkMatchStatus();
//     }

//     if (data['startKickTime'] != null) {
//       try {
//         kickOffTime = DateTime.parse(data['startKickTime']);
//       } catch (e) {
//         print('Error parsing startKickTime: $e');
//       }
//     }

//     if (data['liveGoalScores'] != null) {
//       final liveScores = data['liveGoalScores'] as List;
//       for (var score in liveScores) {
//         final teamId = score['teamId'] as String;
//         final goals = score['teamGoals'] as int;
//         teamScores[teamId] = goals;
//       }
//     }

//     if (data['scoreCard'] != null) {
//       scoreCard = List<Map<String, dynamic>>.from(data['scoreCard']);
//     }

//     if (data['teams'] != null) {
//       teams = List<Map<String, dynamic>>.from(data['teams']);
//     }
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           isLoading = false;
//           _initializeFromMatchData();
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

//   void _initializeFromMatchData() {
//     if (matchData == null) return;

//     matchName = matchData!['name'] ?? 'Football Match';
//     currentStatus = matchData!['currentStatus'] ?? matchData!['status'] ?? 'live';
//     totalDuration = matchData!['totalDuration'] ?? 15;
//     halfTimeDuration = matchData!['halfTimeDuration'] ?? 2;
//     extraTimeAllowed = matchData!['extraTimeAllowed'] ?? false;
//     extraTimeDuration = matchData!['extraTimeDuration'] ?? 0;

//     if (matchData!['startKickTime'] != null) {
//       try {
//         kickOffTime = DateTime.parse(matchData!['startKickTime']);
//         _elapsedTime = _calculateElapsedTime();
//       } catch (e) {
//         print('Error parsing startKickTime: $e');
//       }
//     }

//     if (matchData!['teams'] != null) {
//       teams = List<Map<String, dynamic>>.from(matchData!['teams']);
//     }

//     if (matchData!['liveGoalScores'] != null) {
//       final liveScores = matchData!['liveGoalScores'] as List;
//       for (var score in liveScores) {
//         final teamId = score['teamId'] as String;
//         final goals = score['teamGoals'] as int? ?? 0;
//         teamScores[teamId] = goals;
//       }
//     }

//     if (matchData!['scoreCard'] != null) {
//       scoreCard = List<Map<String, dynamic>>.from(matchData!['scoreCard']);
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     SocketService.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF3B82F6),
//           ),
//         ),
//       );
//     }

//     if (matchData == null || teams.isEmpty) {
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
//               const Icon(Icons.error_outline, size: 64, color: Colors.red),
//               const SizedBox(height: 16),
//               const Text('Failed to load match data'),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Go Back'),
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
//                 child: _buildFootballScorecard(),
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
//                       matchName,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       'Football Match',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
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
//           onTap: _showStopDialog,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xFFE5E7EB)),
//             ),
//             child: const Text(
//               'Stop',
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

//   Widget _buildFootballScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 16),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: teams.length == 2
//               ? Row(
//                   children: [
//                     Expanded(child: _buildTeamCard(0)),
//                     const SizedBox(width: 16),
//                     Expanded(child: _buildTeamCard(1)),
//                   ],
//                 )
//               : Column(
//                   children: List.generate(
//                     teams.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: _buildTeamCard(index),
//                     ),
//                   ),
//                 ),
//         ),
//         const SizedBox(height: 24),
//         _buildGoalScorecard(),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildTeamCard(int teamIndex) {
//     if (teamIndex >= teams.length) return const SizedBox.shrink();

//     final team = teams[teamIndex];
//     final teamId = team['teamId'] as String;
//     final teamName = _getTeamName(teamIndex);
//     final goals = teamScores[teamId] ?? 0;
//     final players = team['players'] as List? ?? [];

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             teamName,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             '${players.length} Players',
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               color: const Color(0xFF10B981),
//               borderRadius: BorderRadius.circular(45),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF10B981).withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 '$goals',
//                 style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Goals',
//             style: TextStyle(
//               fontSize: 14,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEF4444),
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFFEF4444).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   onPressed: () => _showPlayerSelectionModal(teamId, players, 'dec'),
//                   icon: const Icon(Icons.remove, color: Colors.white, size: 20),
//                 ),
//               ),
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF10B981),
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF10B981).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   onPressed: () => _showPlayerSelectionModal(teamId, players, 'inc'),
//                   icon: const Icon(Icons.add, color: Colors.white, size: 20),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGoalScorecard() {
//     if (scoreCard.isEmpty) return const SizedBox.shrink();

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.sports_soccer, color: Color(0xFF10B981), size: 24),
//               SizedBox(width: 8),
//               Text(
//                 'Goal Scorers',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           ...scoreCard.asMap().entries.map((entry) {
//             final teamIndex = entry.key;
//             final teamScore = entry.value;
//             final teamId = teamScore['teamId'] as String;
//             final players = teamScore['players'] as List? ?? [];

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (teamIndex > 0) const Divider(height: 24),
//                 Text(
//                   _getTeamName(teamIndex),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF374151),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 if (players.where((p) => (p['goals'] ?? 0) > 0).isEmpty)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       'No goals yet',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF9CA3AF),
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   )
//                 else
//                   ...players.where((p) => (p['goals'] ?? 0) > 0).map((player) {
//                     final playerName = player['playerName'] ?? 'Unknown';
//                     final goals = player['goals'] ?? 0;

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 28,
//                             height: 28,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF10B981),
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             child: const Icon(
//                               Icons.sports_soccer,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               playerName,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 color: Color(0xFF1F2937),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFDCFCE7),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               '$goals ${goals == 1 ? 'goal' : 'goals'}',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF10B981),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//               ],
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   String _getTeamName(int index) {
//     if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
//     final team = teams[index];
//     return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
//   }

//   Widget _buildTimer() {
//     final minutes = _elapsedTime.inMinutes;
//     final seconds = _elapsedTime.inSeconds % 60;

//     // Determine if we're in extra time
//     bool isExtraTime = false;
//     Color timerColor = const Color(0xFF1F2937);

//     if (currentStatus == 'live' && minutes >= (totalDuration ~/ 2) && extraTimeAllowedForHalfTime) {
//       isExtraTime = true;
//       timerColor = const Color(0xFF3B82F6);
//     } else if (currentStatus == 'second-half' && minutes >= totalDuration && extraTimeAllowedForFullTime) {
//       isExtraTime = true;
//       timerColor = const Color(0xFF3B82F6);
//     }

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: timerColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 isExtraTime ? 'Extra Time' : 'Match Time',
//                 style: const TextStyle(
//                   color: Color(0xFF9CA3AF),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               const Icon(
//                 Icons.schedule,
//                 color: Colors.white,
//                 size: 28,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 currentStatus == 'second-half' ? '2ND HALF' : '1ST HALF',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _showPlayerSelectionModal(String teamId, List players, String action) {
//     if (players.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No players available')),
//       );
//       return;
//     }

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     action == 'inc' ? 'Select Goal Scorer' : 'Remove Goal From',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Flexible(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: players.length,
//                   itemBuilder: (context, index) {
//                     final player = players[index];
//                     final playerName = player['playerName'] ?? 'Unknown';
//                     final playerId = player['playerId'];

//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: const Color(0xFF10B981),
//                         child: Text(
//                           playerName[0].toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         playerName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onTap: () {
//                         Navigator.pop(context);
//                         if (action == 'inc') {
//                           _incrementScore(teamId, playerId);
//                         } else {
//                           _decrementScore(teamId, playerId);
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showHalfTimeModal() {
//     _timer?.cancel();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         bool extraTimeEnabled = false;
//         int extraMinutes = 0;

//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               title: const Text(
//                 'Half-Time Reached',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'The first half has ended. Do you want to add extra time?',
//                     style: TextStyle(color: Color(0xFF6B7280)),
//                   ),
//                   const SizedBox(height: 16),
//                   SwitchListTile(
//                     title: const Text('Extra Time'),
//                     value: extraTimeEnabled,
//                     onChanged: (value) {
//                       setModalState(() {
//                         extraTimeEnabled = value;
//                         if (!value) extraMinutes = 0;
//                       });
//                     },
//                   ),
//                   if (extraTimeEnabled)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Row(
//                         children: [
//                           const Text('Duration: '),
//                           Expanded(
//                             child: Slider(
//                               value: extraMinutes.toDouble(),
//                               min: 0,
//                               max: 10,
//                               divisions: 10,
//                               label: '$extraMinutes min',
//                               onChanged: (value) {
//                                 setModalState(() {
//                                   extraMinutes = value.toInt();
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('$extraMinutes min'),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _startTimer();
//                   },
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(color: Color(0xFF6B7280)),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     await _updateHalfTimeSettings(extraTimeEnabled, extraMinutes);
//                     await _updateMatchStatus('break');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF3B82F6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showFullTimeModal() {
//     _timer?.cancel();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         bool extraTimeEnabled = false;
//         int extraMinutes = 0;

//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               title: const Text(
//                 'Full-Time Reached',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'The match has ended. Do you want to add extra time?',
//                     style: TextStyle(color: Color(0xFF6B7280)),
//                   ),
//                   const SizedBox(height: 16),
//                   SwitchListTile(
//                     title: const Text('Extra Time'),
//                     value: extraTimeEnabled,
//                     onChanged: (value) {
//                       setModalState(() {
//                         extraTimeEnabled = value;
//                         if (!value) extraMinutes = 0;
//                       });
//                     },
//                   ),
//                   if (extraTimeEnabled)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Row(
//                         children: [
//                           const Text('Duration: '),
//                           Expanded(
//                             child: Slider(
//                               value: extraMinutes.toDouble(),
//                               min: 0,
//                               max: 10,
//                               divisions: 10,
//                               label: '$extraMinutes min',
//                               onChanged: (value) {
//                                 setModalState(() {
//                                   extraMinutes = value.toInt();
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('$extraMinutes min'),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _startTimer();
//                   },
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(color: Color(0xFF6B7280)),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     if (extraTimeEnabled) {
//                       await _updateFullTimeSettings(extraTimeEnabled, extraMinutes);
//                       _startTimer();
//                     } else {
//                       await _endGame();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF3B82F6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _updateHalfTimeSettings(bool enabled, int duration) async {
//     try {
//       final payload = {
//         "extraTimeAllowedForHalfTime": enabled,
//         "extraTimeDurationForHalfTime": duration,
//       };

//       setState(() {
//         extraTimeAllowedForHalfTime = enabled;
//         extraTimeDurationForHalfTime = duration;
//       });

//       await MatchApiService.updateScore(widget.matchId, payload);
//     } catch (e) {
//       print('Error updating half-time settings: $e');
//     }
//   }

//   Future<void> _updateFullTimeSettings(bool enabled, int duration) async {
//     try {
//       final payload = {
//         "extraTimeAllowedForFullTime": enabled,
//         "extraTimeDurationForFullTime": duration,
//       };

//       setState(() {
//         extraTimeAllowedForFullTime = enabled;
//         extraTimeDurationForFullTime = duration;
//       });

//       await MatchApiService.updateScore(widget.matchId, payload);
//     } catch (e) {
//       print('Error updating full-time settings: $e');
//     }
//   }

//   Future<void> _updateMatchStatus(String status) async {
//     try {
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//           firstTeam['players'] != null &&
//           (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "currentStatus": status,
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);

//         setState(() {
//           currentStatus = status;
//         });

//         if (status == 'break') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HalfTimeScreen(
//                 matchId: widget.matchId,
//                 matchName: matchName,
//                 teamScores: teamScores,
//                 teams: teams,
//               ),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error updating match status: $e');
//     }
//   }

//   Future<void> _incrementScore(String teamId, String playerId) async {
//     setState(() {
//       teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
//     });

//     try {
//       final payload = {
//         "teamId": teamId,
//         "playerId": playerId,
//         "goals": 1,
//         "action": "inc"
//       };

//       await MatchApiService.updateScore(widget.matchId, payload);
//     } catch (e) {
//       print('Error incrementing score: $e');
//       setState(() {
//         teamScores[teamId] = (teamScores[teamId] ?? 1) - 1;
//       });
//     }
//   }

//   Future<void> _decrementScore(String teamId, String playerId) async {
//     if ((teamScores[teamId] ?? 0) > 0) {
//       setState(() {
//         teamScores[teamId] = (teamScores[teamId] ?? 0) - 1;
//       });

//       try {
//         final payload = {
//           "teamId": teamId,
//           "playerId": playerId,
//           "goals": 1,
//           "action": "dec"
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);
//       } catch (e) {
//         print('Error decrementing score: $e');
//         setState(() {
//           teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
//         });
//       }
//     }
//   }

//   Future<void> _endGame() async {
//     try {
//       String winner = '';
//       if (teams.length == 2) {
//         final team1Id = teams[0]['teamId'] as String;
//         final team2Id = teams[1]['teamId'] as String;
//         final score1 = teamScores[team1Id] ?? 0;
//         final score2 = teamScores[team2Id] ?? 0;

//         if (score1 > score2) {
//           winner = _getTeamName(0);
//         } else if (score2 > score1) {
//           winner = _getTeamName(1);
//         }
//       }

//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//           firstTeam['players'] != null &&
//           (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         final team1Id = teams[0]['teamId'] as String;
//         final team2Id = teams.length > 1 ? teams[1]['teamId'] as String : team1Id;
//         final score1 = teamScores[team1Id] ?? 0;
//         final score2 = teamScores[team2Id] ?? 0;

//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "status": "finished",
//           "finalScore": {
//             "teamA": score1,
//             "teamB": score2,
//           },
//           "timeElapsed": _elapsedTime.inMinutes,
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);
//       }

//       final gameResult = winner.isNotEmpty ? '$winner Wins!' : 'Draw!';

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GameSummaryScreen(
//             matchName: matchName,
//             finalScores: teamScores,
//             gameDuration: _elapsedTime,
//             gameResult: gameResult,
//             matchId: widget.matchId,
//           ),
//         ),
//       );
//     } catch (e) {
//       print('Error ending game: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error ending game: $e')),
//       );
//     }
//   }

//   void _showEndGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
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
//                 _endGame();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEF4444),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
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

//   void _showStopDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Stop Match',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Do you want to pause the match and go to break?',
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
//                 _updateMatchStatus('break');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3B82F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Stop',
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
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// // API Service Class
// class MatchApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';

//   static Future<Map<String, dynamic>> getMatchData(String matchId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglegamematch/$matchId'),
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

//   static Future<void> updateScore(
//     String matchId,
//     Map<String, dynamic> payload,
//   ) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/users/update-score/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       print("Update score response: ${response.statusCode}");

//       if (response.statusCode != 200) {
//         throw Exception('Failed to update score');
//       }
//     } catch (e) {
//       print('Error updating score: $e');
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

//   static void listenToMatchUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('match:update', (data) {
//       print('Match update received: $data');
//       callback(data);
//     });
//   }

//   static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
//     socket?.on('liveScoreUpdate', (data) {
//       print('Live score update received: $data');
//       callback(data);
//     });
//   }

//   static void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//   }
// }

// // Half-Time Break Screen
// class HalfTimeScreen extends StatelessWidget {
//   final String matchId;
//   final String matchName;
//   final Map<String, int> teamScores;
//   final List<Map<String, dynamic>> teams;

//   const HalfTimeScreen({
//     super.key,
//     required this.matchId,
//     required this.matchName,
//     required this.teamScores,
//     required this.teams,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1F2937),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.sports_soccer,
//                   size: 80,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'HALF TIME',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   matchName,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Color(0xFF9CA3AF),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 _buildScoreDisplay(),
//                 const SizedBox(height: 60),
//                 ElevatedButton(
//                   onPressed: () => _startSecondHalf(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF10B981),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 48, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Start Second Half',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildScoreDisplay() {
//     final team1Id = teams.isNotEmpty ? teams[0]['teamId'] as String : '';
//     final team2Id = teams.length > 1 ? teams[1]['teamId'] as String : '';
//     final score1 = teamScores[team1Id] ?? 0;
//     final score2 = teamScores[team2Id] ?? 0;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 _getTeamName(0),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '$score1',
//                 style: const TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF10B981),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             '-',
//             style: TextStyle(
//               fontSize: 36,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 _getTeamName(1),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '$score2',
//                 style: const TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF10B981),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   String _getTeamName(int index) {
//     if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
//     final team = teams[index];
//     return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
//   }

//   Future<void> _startSecondHalf(BuildContext context) async {
//     try {
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//               firstTeam['players'] != null &&
//               (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "currentStatus": "second-half"
//         };

//         await MatchApiService.updateScore(matchId, payload);
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ScorecardScreen(matchId: matchId),
//         ),
//       );
//     } catch (e) {
//       print('Error starting second half: $e');
//     }
//   }
// }

// // Game Summary Screen
// class GameSummaryScreen extends StatelessWidget {
//   final String matchName;
//   final Map<String, int> finalScores;
//   final Duration gameDuration;
//   final String gameResult;
//   final String matchId;

//   const GameSummaryScreen({
//     super.key,
//     required this.matchName,
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
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: gameResult.contains('Draw')
//                     ? const Color(0xFFF3F4F6)
//                     : const Color(0xFFDCFCE7),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: gameResult.contains('Draw')
//                       ? const Color(0xFFE5E7EB)
//                       : const Color(0xFF10B981),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     gameResult.contains('Draw')
//                         ? Icons.handshake
//                         : Icons.emoji_events,
//                     size: 48,
//                     color: gameResult.contains('Draw')
//                         ? const Color(0xFF6B7280)
//                         : const Color(0xFF10B981),
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
//                     matchName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<GameProvider>()
//                           .updateMatchStatus(matchId, "completed");
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => GameManagerScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B82F6),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Back to Games',
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

// // Football Scorecard Screen
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
//   Timer? _timer;
//   Duration _elapsedTime = Duration.zero;

//   Map<String, dynamic>? matchData;
//   bool isLoading = true;

//   String matchName = '';
//   String currentStatus = 'live';
//   List<Map<String, dynamic>> teams = [];
//   Map<String, int> teamScores = {};
//   List<Map<String, dynamic>> scoreCard = [];

//   DateTime? kickOffTime;
//   int totalDuration = 15;
//   int halfTimeDuration = 2;
//   bool extraTimeAllowed = false;
//   int extraTimeDuration = 0;
//   bool extraTimeAllowedForHalfTime = false;
//   int extraTimeDurationForHalfTime = 0;
//   bool extraTimeAllowedForFullTime = false;
//   int extraTimeDurationForFullTime = 0;

//   // Extra time tracking
//   bool isInHalfTimeExtraTime = false;
//   bool isInFullTimeExtraTime = false;
//   int extraTimeMinutes = 0;
//   int addedHalfTimeExtra = 0;
//   int addedFullTimeExtra = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initSetup();
//   }

//   Future<void> _initSetup() async {
//     await _initializeSocket();
//     await _fetchMatchData();
//     _checkMatchStatus();
//     _startTimer();
//   }

//   void _checkMatchStatus() {
//     if (currentStatus == 'break') {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HalfTimeScreen(
//               matchId: widget.matchId,
//               matchName: matchName,
//               teamScores: teamScores,
//               teams: teams,
//             ),
//           ),
//         );
//       });
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (kickOffTime != null && mounted) {
//         setState(() {
//           _elapsedTime = _calculateElapsedTime();
//           _checkForAutomaticBreaks();
//         });
//       }
//     });
//   }

//   void _checkForAutomaticBreaks() {
//     final minutes = _elapsedTime.inMinutes;
//     final halfTime = totalDuration ~/ 2;

//     // Check for half-time (without extra time)
//     if (currentStatus == 'live' &&
//         minutes >= halfTime &&
//         !extraTimeAllowedForHalfTime &&
//         !isInHalfTimeExtraTime) {
//       _showHalfTimeModal();
//     }

//     // Check for half-time extra time end
//     if (currentStatus == 'live' &&
//         isInHalfTimeExtraTime &&
//         minutes >= (halfTime + extraTimeDurationForHalfTime)) {
//       _showHalfTimeModal();
//     }

//     // Check for full-time (without extra time)
//     if (currentStatus == 'second-half' &&
//         minutes >= totalDuration &&
//         !extraTimeAllowedForFullTime &&
//         !isInFullTimeExtraTime) {
//       _showFullTimeModal();
//     }

//     // Check for full-time extra time end
//     if (currentStatus == 'second-half' &&
//         isInFullTimeExtraTime &&
//         minutes >= (totalDuration + extraTimeDurationForFullTime)) {
//       _showFullTimeModal();
//     }
//   }

//   Duration _calculateElapsedTime() {
//     if (kickOffTime == null) return Duration.zero;

//     try {
//       final now = DateTime.now();
//       final kickoff = kickOffTime!.isUtc
//           ? DateTime(
//               kickOffTime!.year,
//               kickOffTime!.month,
//               kickOffTime!.day,
//               kickOffTime!.hour,
//               kickOffTime!.minute,
//               kickOffTime!.second,
//               kickOffTime!.millisecond,
//               kickOffTime!.microsecond,
//             )
//           : kickOffTime!;

//       final difference = now.difference(kickoff);
//       return difference.isNegative ? Duration.zero : difference;
//     } catch (e) {
//       print('Error calculating elapsed time: $e');
//       return Duration.zero;
//     }
//   }

//   Future<void> _initializeSocket() async {
//     SocketService.initSocket();
//     SocketService.joinMatch(widget.matchId);

//     SocketService.listenToMatchUpdate((data) {
//       if (mounted) {
//         setState(() {
//           _updateFromSocketData(data);
//         });
//       }
//     });

//     SocketService.listenToLiveScoreUpdate((data) {
//       if (mounted) {
//         setState(() {
//           if (data['teamScores'] != null) {
//             final scores = data['teamScores'] as Map<String, dynamic>;
//             scores.forEach((teamId, score) {
//               teamScores[teamId] = score is int ? score : 0;
//             });
//           }
//         });
//       }
//     });
//   }

//   void _updateFromSocketData(Map<String, dynamic> data) {
//     if (data['name'] != null) {
//       matchName = data['name'];
//     }

//     if (data['status'] != null || data['currentStatus'] != null) {
//       currentStatus = data['currentStatus'] ?? data['status'] ?? 'live';
//       _checkMatchStatus();
//     }

//     if (data['startKickTime'] != null) {
//       try {
//         kickOffTime = DateTime.parse(data['startKickTime']);
//       } catch (e) {
//         print('Error parsing startKickTime: $e');
//       }
//     }

//     if (data['liveGoalScores'] != null) {
//       final liveScores = data['liveGoalScores'] as List;
//       for (var score in liveScores) {
//         final teamId = score['teamId'] as String;
//         final goals = score['teamGoals'] as int;
//         teamScores[teamId] = goals;
//       }
//     }

//     if (data['scoreCard'] != null) {
//       scoreCard = List<Map<String, dynamic>>.from(data['scoreCard']);
//     }

//     if (data['teams'] != null) {
//       teams = List<Map<String, dynamic>>.from(data['teams']);
//     }

//     // Update extra time settings from socket
//     if (data['extraTimeAllowedForHalfTime'] != null) {
//       extraTimeAllowedForHalfTime = data['extraTimeAllowedForHalfTime'];
//     }
//     if (data['extraTimeDurationForHalfTime'] != null) {
//       extraTimeDurationForHalfTime = data['extraTimeDurationForHalfTime'];
//     }
//     if (data['extraTimeAllowedForFullTime'] != null) {
//       extraTimeAllowedForFullTime = data['extraTimeAllowedForFullTime'];
//     }
//     if (data['extraTimeDurationForFullTime'] != null) {
//       extraTimeDurationForFullTime = data['extraTimeDurationForFullTime'];
//     }
//   }

//   Future<void> _fetchMatchData() async {
//     try {
//       final data = await MatchApiService.getMatchData(widget.matchId);

//       if (mounted) {
//         setState(() {
//           matchData = data;
//           isLoading = false;
//           _initializeFromMatchData();
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

//   void _initializeFromMatchData() {
//     if (matchData == null) return;

//     matchName = matchData!['name'] ?? 'Football Match';
//     currentStatus =
//         matchData!['currentStatus'] ?? matchData!['status'] ?? 'live';
//     totalDuration = matchData!['totalDuration'] ?? 15;
//     halfTimeDuration = matchData!['halfTimeDuration'] ?? 2;
//     extraTimeAllowed = matchData!['extraTimeAllowed'] ?? false;
//     extraTimeDuration = matchData!['extraTimeDuration'] ?? 0;
//     extraTimeAllowedForHalfTime =
//         matchData!['extraTimeAllowedForHalfTime'] ?? false;
//     extraTimeDurationForHalfTime =
//         matchData!['extraTimeDurationForHalfTime'] ?? 0;
//     extraTimeAllowedForFullTime =
//         matchData!['extraTimeAllowedForFullTime'] ?? false;
//     extraTimeDurationForFullTime =
//         matchData!['extraTimeDurationForFullTime'] ?? 0;

//     if (matchData!['startKickTime'] != null) {
//       try {
//         kickOffTime = DateTime.parse(matchData!['startKickTime']);
//         _elapsedTime = _calculateElapsedTime();
//       } catch (e) {
//         print('Error parsing startKickTime: $e');
//       }
//     }

//     if (matchData!['teams'] != null) {
//       teams = List<Map<String, dynamic>>.from(matchData!['teams']);
//     }

//     if (matchData!['liveGoalScores'] != null) {
//       final liveScores = matchData!['liveGoalScores'] as List;
//       for (var score in liveScores) {
//         final teamId = score['teamId'] as String;
//         final goals = score['teamGoals'] as int? ?? 0;
//         teamScores[teamId] = goals;
//       }
//     }

//     if (matchData!['scoreCard'] != null) {
//       scoreCard = List<Map<String, dynamic>>.from(matchData!['scoreCard']);
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<GameProvider>().updateMatchStatus(widget.matchId, "live");
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     SocketService.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF3B82F6),
//           ),
//         ),
//       );
//     }

//     if (matchData == null || teams.isEmpty) {
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
//               const Icon(Icons.error_outline, size: 64, color: Colors.red),
//               const SizedBox(height: 16),
//               const Text('Failed to load match data'),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Go Back'),
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
//                 child: _buildFootballScorecard(),
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
//                       matchName,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       'Football Match',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF6B7280),
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 2),
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
//     final minutes = _elapsedTime.inMinutes;
//     final halfTime = totalDuration ~/ 2;

//     print("lllllllllllllllllllllllllllMinutes$minutes");
//     print("lllllllllllllllllllllllllllHalftime$halfTime");

//     // Enable extra time button only when reaching half-time or full-time
//     bool canAddExtraTime = false;
//     if (currentStatus == 'first-half' && minutes >= halfTime) {
//       canAddExtraTime = true;
//     } else if (currentStatus == 'second-half' && minutes >= totalDuration) {
//       canAddExtraTime = true;
//     }

//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         InkWell(
//           onTap: canAddExtraTime ? _showExtraTimeDialog : null,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: canAddExtraTime
//                   ? const Color(0xFFFBBF24)
//                   : const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: canAddExtraTime
//                     ? const Color(0xFFF59E0B)
//                     : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.timer,
//                   size: 16,
//                   color:
//                       canAddExtraTime ? Colors.white : const Color(0xFF9CA3AF),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   'Extra Time',
//                   style: TextStyle(
//                     color: canAddExtraTime
//                         ? Colors.white
//                         : const Color(0xFF9CA3AF),
//                     fontWeight: FontWeight.w500,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: _showStopDialog,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xFFE5E7EB)),
//             ),
//             child: const Text(
//               'Stop',
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

//   Widget _buildFootballScorecard() {
//     return Column(
//       children: [
//         _buildTimer(),
//         const SizedBox(height: 16),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: teams.length == 2
//               ? Row(
//                   children: [
//                     Expanded(child: _buildTeamCard(0)),
//                     const SizedBox(width: 16),
//                     Expanded(child: _buildTeamCard(1)),
//                   ],
//                 )
//               : Column(
//                   children: List.generate(
//                     teams.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: _buildTeamCard(index),
//                     ),
//                   ),
//                 ),
//         ),
//         const SizedBox(height: 24),
//         _buildGoalScorecard(),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildTeamCard(int teamIndex) {
//     if (teamIndex >= teams.length) return const SizedBox.shrink();

//     final team = teams[teamIndex];
//     final teamId = team['teamId'] as String;
//     final teamName = _getTeamName(teamIndex);
//     final goals = teamScores[teamId] ?? 0;
//     final players = team['players'] as List? ?? [];

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             teamName,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             '${players.length} Players',
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               color: const Color(0xFF10B981),
//               borderRadius: BorderRadius.circular(45),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF10B981).withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 '$goals',
//                 style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Goals',
//             style: TextStyle(
//               fontSize: 14,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEF4444),
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFFEF4444).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   onPressed: () =>
//                       _showPlayerSelectionModal(teamId, players, 'dec'),
//                   icon: const Icon(Icons.remove, color: Colors.white, size: 20),
//                 ),
//               ),
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF10B981),
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF10B981).withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   onPressed: () =>
//                       _showPlayerSelectionModal(teamId, players, 'inc'),
//                   icon: const Icon(Icons.add, color: Colors.white, size: 20),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGoalScorecard() {
//     if (scoreCard.isEmpty) return const SizedBox.shrink();

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.sports_soccer, color: Color(0xFF10B981), size: 24),
//               SizedBox(width: 8),
//               Text(
//                 'Goal Scorers',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           ...scoreCard.asMap().entries.map((entry) {
//             final teamIndex = entry.key;
//             final teamScore = entry.value;
//             final teamId = teamScore['teamId'] as String;
//             final players = teamScore['players'] as List? ?? [];

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (teamIndex > 0) const Divider(height: 24),
//                 Text(
//                   _getTeamName(teamIndex),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF374151),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 if (players.where((p) => (p['goals'] ?? 0) > 0).isEmpty)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       'No goals yet',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF9CA3AF),
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   )
//                 else
//                   ...players.where((p) => (p['goals'] ?? 0) > 0).map((player) {
//                     final playerName = player['playerName'] ?? 'Unknown';
//                     final goals = player['goals'] ?? 0;

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 28,
//                             height: 28,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF10B981),
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             child: const Icon(
//                               Icons.sports_soccer,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               playerName,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 color: Color(0xFF1F2937),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFDCFCE7),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               '$goals ${goals == 1 ? 'goal' : 'goals'}',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF10B981),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//               ],
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   String _getTeamName(int index) {
//     if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
//     final team = teams[index];
//     return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
//   }

//   Widget _buildTimer() {
//     final minutes = _elapsedTime.inMinutes;
//     final seconds = _elapsedTime.inSeconds % 60;
//     final halfTime = totalDuration ~/ 2;

//     // Determine if we're in extra time and calculate extra time minutes
//     bool isExtraTime = false;
//     Color timerColor = const Color(0xFF1F2937);
//     int displayExtraTime = 0;

//     if (currentStatus == 'first-half' &&
//         minutes >= halfTime &&
//         extraTimeAllowedForHalfTime) {
//       isExtraTime = true;
//       isInHalfTimeExtraTime = true;
//       timerColor = const Color(0xFF3B82F6);
//       displayExtraTime = minutes - halfTime;
//     } else if (currentStatus == 'second-half' &&
//         minutes >= totalDuration &&
//         extraTimeAllowedForFullTime) {
//       isExtraTime = true;
//       isInFullTimeExtraTime = true;
//       timerColor = const Color(0xFF3B82F6);
//       displayExtraTime = minutes - totalDuration;
//     }

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: timerColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 isExtraTime ? 'Extra Time' : 'Match Time',
//                 style: const TextStyle(
//                   color: Color.fromARGB(255, 255, 255, 255),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   if (isExtraTime && displayExtraTime > 0)
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8, top: 4),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFBBF24),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           '+$displayExtraTime',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               const Icon(
//                 Icons.schedule,
//                 color: Colors.white,
//                 size: 28,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 currentStatus == 'second-half' ? '2ND HALF' : '1ST HALF',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _showExtraTimeDialog() {
//     final minutes = _elapsedTime.inMinutes;
//     final halfTime = totalDuration ~/ 2;

//     // Determine which extra time dialog to show
//     bool isHalfTime = currentStatus == 'first-half' && minutes >= halfTime;
//     bool isFullTime =
//         currentStatus == 'second-half' && minutes >= totalDuration;

//     // Controllers for manual input
//     TextEditingController halfTimeController = TextEditingController();
//     TextEditingController fullTimeController = TextEditingController();

//     // Initial values
//     int addedHalfTimeExtra = 0;
//     int addedFullTimeExtra = 0;

//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         bool halfTimeExtraEnabled = extraTimeAllowedForHalfTime;
//         bool fullTimeExtraEnabled = extraTimeAllowedForFullTime;
//         int halfTimeExtraDuration = extraTimeDurationForHalfTime;
//         int fullTimeExtraDuration = extraTimeDurationForFullTime;

//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               title: const Text(
//                 'Extra Time Settings',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ---------------- Half-Time Extra Time ----------------
//                     if (isHalfTime) ...[
//                       const Text(
//                         'Half-Time Extra Time',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF374151)),
//                       ),
//                       const SizedBox(height: 8),
//                       SwitchListTile(
//                         title: const Text('Enable Half-Time Extra Time'),
//                         subtitle:
//                             const Text('Add extra minutes for first half'),
//                         value: halfTimeExtraEnabled,
//                         activeColor: const Color(0xFF10B981),
//                         onChanged: (value) {
//                           setDialogState(() {
//                             halfTimeExtraEnabled = value;
//                             if (!value) halfTimeExtraDuration = 0;
//                           });
//                         },
//                       ),
//                       if (halfTimeExtraEnabled)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Pre-configured Duration: $halfTimeExtraDuration minutes'),
//                               Slider(
//                                 value: halfTimeExtraDuration.toDouble(),
//                                 min: 1,
//                                 max: 15,
//                                 divisions: 14,
//                                 activeColor: const Color(0xFF10B981),
//                                 label: '$halfTimeExtraDuration min',
//                                 onChanged: (value) {
//                                   setDialogState(() =>
//                                       halfTimeExtraDuration = value.toInt());
//                                 },
//                               ),
//                               const SizedBox(height: 8),
//                               // Manual Input Field for referee
//                               Text(
//                                 'Add Extra Time (Manual Input):',
//                                 style: const TextStyle(
//                                     fontSize: 14, fontWeight: FontWeight.w500),
//                               ),
//                               TextField(
//                                 controller: halfTimeController,
//                                 keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Enter minutes',
//                                 ),
//                                 onChanged: (value) {
//                                   setDialogState(() {
//                                     addedHalfTimeExtra =
//                                         int.tryParse(value) ?? 0;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],

//                     // ---------------- Full-Time Extra Time ----------------
//                     if (isFullTime) ...[
//                       const Text(
//                         'Full-Time Extra Time',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF374151)),
//                       ),
//                       const SizedBox(height: 8),
//                       SwitchListTile(
//                         title: const Text('Enable Full-Time Extra Time'),
//                         subtitle:
//                             const Text('Add extra minutes for second half'),
//                         value: fullTimeExtraEnabled,
//                         activeColor: const Color(0xFF10B981),
//                         onChanged: (value) {
//                           setDialogState(() {
//                             fullTimeExtraEnabled = value;
//                             if (!value) fullTimeExtraDuration = 0;
//                           });
//                         },
//                       ),
//                       if (fullTimeExtraEnabled)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Pre-configured Duration: $fullTimeExtraDuration minutes'),
//                               Slider(
//                                 value: fullTimeExtraDuration.toDouble(),
//                                 min: 1,
//                                 max: 15,
//                                 divisions: 14,
//                                 activeColor: const Color(0xFF10B981),
//                                 label: '$fullTimeExtraDuration min',
//                                 onChanged: (value) {
//                                   setDialogState(() =>
//                                       fullTimeExtraDuration = value.toInt());
//                                 },
//                               ),
//                               const SizedBox(height: 8),
//                               // Manual Input Field for referee
//                               Text(
//                                 'Add Extra Time (Manual Input):',
//                                 style: const TextStyle(
//                                     fontSize: 14, fontWeight: FontWeight.w500),
//                               ),
//                               TextField(
//                                 controller: fullTimeController,
//                                 keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Enter minutes',
//                                 ),
//                                 onChanged: (value) {
//                                   setDialogState(() {
//                                     addedFullTimeExtra =
//                                         int.tryParse(value) ?? 0;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(color: Color(0xFF6B7280)),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     Navigator.pop(context);

//                     // Combine pre-configured + manual extra time
//                     if (isHalfTime) {
//                       await _updateExtraTimeSettings(
//                         halfTimeEnabled: halfTimeExtraEnabled,
//                         halfTimeDuration:
//                             halfTimeExtraDuration + addedHalfTimeExtra,
//                       );
//                     }

//                     if (isFullTime) {
//                       await _updateExtraTimeSettings(
//                         fullTimeEnabled: fullTimeExtraEnabled,
//                         fullTimeDuration:
//                             fullTimeExtraDuration + addedFullTimeExtra,
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF10B981),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Apply',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _updateExtraTimeSettings({
//     bool? halfTimeEnabled,
//     int? halfTimeDuration,
//     bool? fullTimeEnabled,
//     int? fullTimeDuration,
//   }) async {
//     try {
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//               firstTeam['players'] != null &&
//               (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         Map<String, dynamic> payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//         };

//         // Add half-time extra time settings if provided
//         if (halfTimeEnabled != null) {
//           payload["extraTimeAllowedForHalfTime"] = halfTimeEnabled;
//           setState(() {
//             extraTimeAllowedForHalfTime = halfTimeEnabled;
//           });
//         }
//         if (halfTimeDuration != null) {
//           payload["extraTimeDurationForHalfTime"] = halfTimeDuration;
//           setState(() {
//             extraTimeDurationForHalfTime = halfTimeDuration;
//           });
//         }

//         // Add full-time extra time settings if provided
//         if (fullTimeEnabled != null) {
//           payload["extraTimeAllowedForFullTime"] = fullTimeEnabled;
//           setState(() {
//             extraTimeAllowedForFullTime = fullTimeEnabled;
//           });
//         }
//         if (fullTimeDuration != null) {
//           payload["extraTimeDurationForFullTime"] = fullTimeDuration;
//           setState(() {
//             extraTimeDurationForFullTime = fullTimeDuration;
//           });
//         }

//         await MatchApiService.updateScore(widget.matchId, payload);

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Extra time settings updated successfully'),
//               backgroundColor: Color(0xFF10B981),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error updating extra time settings: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating settings: $e'),
//             backgroundColor: Color(0xFFEF4444),
//           ),
//         );
//       }
//     }
//   }

//   void _showPlayerSelectionModal(String teamId, List players, String action) {
//     if (players.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No players available')),
//       );
//       return;
//     }

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     action == 'inc' ? 'Select Goal Scorer' : 'Remove Goal From',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Flexible(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: players.length,
//                   itemBuilder: (context, index) {
//                     final player = players[index];
//                     final playerName = player['playerName'] ?? 'Unknown';
//                     final playerId = player['playerId'];

//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: const Color(0xFF10B981),
//                         child: Text(
//                           playerName[0].toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         playerName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onTap: () {
//                         Navigator.pop(context);
//                         if (action == 'inc') {
//                           _incrementScore(teamId, playerId);
//                         } else {
//                           _decrementScore(teamId, playerId);
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showHalfTimeModal() {
//     _timer?.cancel();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Half-Time Reached',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'The first half has ended. Proceed to half-time break?',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _startTimer();
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _updateMatchStatus('break');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3B82F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Continue',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showFullTimeModal() {
//     _timer?.cancel();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Full-Time Reached',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'The match has ended. Would you like to end the game?',
//             style: TextStyle(color: Color(0xFF6B7280)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _startTimer();
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _endGame();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3B82F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
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

//   Future<void> _updateMatchStatus(String status) async {
//     try {
//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//               firstTeam['players'] != null &&
//               (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;


//       if (firstTeam != null && firstPlayer != null) {
//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "currentStatus": status,
//         };
// print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//         await MatchApiService.updateScore(widget.matchId, payload);

//         setState(() {
//           currentStatus = status;
//         });

//         if (status == 'break') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HalfTimeScreen(
//                 matchId: widget.matchId,
//                 matchName: matchName,
//                 teamScores: teamScores,
//                 teams: teams,
//               ),
//             ),
//           );
//         }
//       }else{
//         print("Else case printingggggggggggggggggggggggggg......");
//       }
//     } catch (e) {
//       print('Error updating match status: $e');
//     }
//   }

//   Future<void> _incrementScore(String teamId, String playerId) async {
//     setState(() {
//       teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
//     });

//     try {
//       final payload = {
//         "teamId": teamId,
//         "playerId": playerId,
//         "goals": 1,
//         "action": "inc"
//       };

//       await MatchApiService.updateScore(widget.matchId, payload);
//     } catch (e) {
//       print('Error incrementing score: $e');
//       setState(() {
//         teamScores[teamId] = (teamScores[teamId] ?? 1) - 1;
//       });
//     }
//   }

//   Future<void> _decrementScore(String teamId, String playerId) async {
//     if ((teamScores[teamId] ?? 0) > 0) {
//       setState(() {
//         teamScores[teamId] = (teamScores[teamId] ?? 0) - 1;
//       });

//       try {
//         final payload = {
//           "teamId": teamId,
//           "playerId": playerId,
//           "goals": 1,
//           "action": "dec"
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);
//       } catch (e) {
//         print('Error decrementing score: $e');
//         setState(() {
//           teamScores[teamId] = (teamScores[teamId] ?? 0) + 1;
//         });
//       }
//     }
//   }

//   Future<void> _endGame() async {
//     try {
//       String winner = '';
//       if (teams.length == 2) {
//         final team1Id = teams[0]['teamId'] as String;
//         final team2Id = teams[1]['teamId'] as String;
//         final score1 = teamScores[team1Id] ?? 0;
//         final score2 = teamScores[team2Id] ?? 0;

//         if (score1 > score2) {
//           winner = _getTeamName(0);
//         } else if (score2 > score1) {
//           winner = _getTeamName(1);
//         }
//       }

//       final firstTeam = teams.isNotEmpty ? teams[0] : null;
//       final firstPlayer = firstTeam != null &&
//               firstTeam['players'] != null &&
//               (firstTeam['players'] as List).isNotEmpty
//           ? firstTeam['players'][0]
//           : null;

//       if (firstTeam != null && firstPlayer != null) {
//         final team1Id = teams[0]['teamId'] as String;
//         final team2Id =
//             teams.length > 1 ? teams[1]['teamId'] as String : team1Id;
//         final score1 = teamScores[team1Id] ?? 0;
//         final score2 = teamScores[team2Id] ?? 0;

//         final payload = {
//           "teamId": firstTeam['teamId'],
//           "playerId": firstPlayer['playerId'],
//           "goals": 0,
//           "status": "finished",
//           "finalScore": {
//             "teamA": score1,
//             "teamB": score2,
//           },
//           "timeElapsed": _elapsedTime.inMinutes,
//         };

//         await MatchApiService.updateScore(widget.matchId, payload);
//       }

//       final gameResult = winner.isNotEmpty ? '$winner Wins!' : 'Draw!';

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GameSummaryScreen(
//             matchName: matchName,
//             finalScores: teamScores,
//             gameDuration: _elapsedTime,
//             gameResult: gameResult,
//             matchId: widget.matchId,
//           ),
//         ),
//       );
//     } catch (e) {
//       print('Error ending game: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error ending game: $e')),
//       );
//     }
//   }

//   void _showEndGameDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
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
//                 _endGame();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEF4444),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
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

//   void _showStopDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Stop Match',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//           content: const Text(
//             'Do you want to pause the match and go to break?',
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
//                 _updateMatchStatus('break');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3B82F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Stop',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }





















import 'package:booking_application/views/Games/create_games.dart';
import 'package:booking_application/views/Games/game_manager_screen.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/games_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// API Service Class
class MatchApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  static Future<Map<String, dynamic>> getMatchData(String matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsinglegamematch/$matchId'),
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

  static Future<void> updateScore(
    String matchId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/update-score/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print("Update score response: ${response.statusCode}");

      if (response.statusCode != 200) {
        throw Exception('Failed to update score');
      }
    } catch (e) {
      print('Error updating score: $e');
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

  static void listenToMatchUpdate(Function(Map<String, dynamic>) callback) {
    socket?.on('match:update', (data) {
      print('Match update received: $data');
      callback(data);
    });
  }

  static void listenToLiveScoreUpdate(Function(Map<String, dynamic>) callback) {
    socket?.on('liveScoreUpdate', (data) {
      print('Live score update received: $data');
      callback(data);
    });
  }

  static void dispose() {
    socket?.disconnect();
    socket?.dispose();
  }
}

// Half-Time Break Screen
class HalfTimeScreen extends StatelessWidget {
  final String matchId;
  final String matchName;
  final Map<String, int> teamScores;
  final List<Map<String, dynamic>> teams;

  const HalfTimeScreen({
    super.key,
    required this.matchId,
    required this.matchName,
    required this.teamScores,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sports_soccer,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'HALF TIME',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  matchName,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF9CA3AF),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildScoreDisplay(),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () => _startSecondHalf(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Second Half',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreDisplay() {
    final team1Id = teams.isNotEmpty ? teams[0]['teamId'] as String : '';
    final team2Id = teams.length > 1 ? teams[1]['teamId'] as String : '';
    final score1 = teamScores[team1Id] ?? 0;
    final score2 = teamScores[team2Id] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                _getTeamName(0),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$score1',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '-',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                _getTeamName(1),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$score2',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getTeamName(int index) {
    if (index >= teams.length) return 'Team ${String.fromCharCode(65 + index)}';
    final team = teams[index];
    return team['teamName'] ?? 'Team ${String.fromCharCode(65 + index)}';
  }

  Future<void> _startSecondHalf(BuildContext context) async {
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
          "currentStatus": "second-half"
        };

        await MatchApiService.updateScore(firstTeam['teamId'], payload);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorecardScreen(matchId: matchId),
        ),
      );
    } catch (e) {
      print('Error starting second half: $e');
    }
  }
}

// Game Summary Screen
class GameSummaryScreen extends StatelessWidget {
  final String matchName;
  final Map<String, int> finalScores;
  final Duration gameDuration;
  final String gameResult;
  final String matchId;

  const GameSummaryScreen({
    super.key,
    required this.matchName,
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
                color: gameResult.contains('Draw')
                    ? const Color(0xFFF3F4F6)
                    : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: gameResult.contains('Draw')
                      ? const Color(0xFFE5E7EB)
                      : const Color(0xFF10B981),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    gameResult.contains('Draw')
                        ? Icons.handshake
                        : Icons.emoji_events,
                    size: 48,
                    color: gameResult.contains('Draw')
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF10B981),
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
                    matchName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<GameProvider>()
                          .updateMatchStatus(matchId, "completed");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameManagerScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Back to Games',
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

      final difference = now.difference(kickoff);
      return difference.isNegative ? Duration.zero : difference;
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

    bool canAddExtraTime = false;
    if (currentStatus == 'first-half' && minutes >= halfTime) {
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
    final minutes = _elapsedTime.inMinutes;
    final seconds = _elapsedTime.inSeconds % 60;
    final halfTime = totalDuration ~/ 2;

    bool isExtraTime = false;
    Color timerColor = const Color(0xFF1F2937);
    int displayExtraTime = 0;

    if (currentStatus == 'first-half' &&
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

    bool isHalfTime = currentStatus == 'first-half' && minutes >= halfTime;
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
            'Do you want to pause the match and go to break?',
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
                _updateMatchStatus('break');
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
}