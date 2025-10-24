// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/views/Games/GameViews/Football/football_completed.dart';
// import 'package:booking_application/views/Games/GameViews/point_based_screen.dart';
// import 'package:booking_application/views/Games/GameViews/set_based_screen.dart';
// import 'package:booking_application/views/Games/GameViews/Football/game_selection.dart';
// import 'package:booking_application/views/Games/widgets/game_card.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ViewMatchScreen extends StatefulWidget {
//   final int initialTabIndex;
//   const ViewMatchScreen({super.key, required this.initialTabIndex});

//   @override
//   State<ViewMatchScreen> createState() => _ViewMatchScreenState();
// }

// class _ViewMatchScreenState extends State<ViewMatchScreen>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isLoading = true;
//   Map<String, List<MatchData>> _groupedMatches = {};
//   List<String> _availableStatuses = [];
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     loadUserId();

//     _fetchMatches();
//   }

//   void loadUserId() async {
//     final currentUser = await UserPreferences.getUser();
//     setState(() {
//       userId = currentUser?.id.toString();
//     });
//   }

//   Future<void> _fetchMatches() async {
//     setState(() => _isLoading = true);

//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:3081/users/gamematches'),
//       );

//       print("Response: Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final matches = (data['matches'] as List)
//             .map((json) => MatchData.fromJson(json))
//             .toList();

//         // Group matches by status
//         _groupedMatches = {};
//         for (var match in matches) {
//           if (!_groupedMatches.containsKey(match.status)) {
//             _groupedMatches[match.status] = [];
//           }
//           _groupedMatches[match.status]!.add(match);
//         }

//         // Get available statuses in preferred order
//         final statusOrder = [
//           'live',
//           'upcoming',
//           'finished',
//           'cancel',
//           'postponed',
//         ];
//         _availableStatuses = statusOrder
//             .where((status) => _groupedMatches.containsKey(status))
//             .toList();

//         print(
//             "ooooooooooooooooooooooooooooooooooooooooooooo${widget.initialTabIndex}");

//         int initialIndex = 0;
//         if (widget.initialTabIndex != null &&
//             widget.initialTabIndex! >= 0 &&
//             widget.initialTabIndex! < _availableStatuses.length) {
//           print(
//               "ggggggggggggggggggggggggggggggggggggggggggg${widget.initialTabIndex}");

//           initialIndex = widget.initialTabIndex;
//         }

//         // Initialize tab controller with dynamic length
//         _tabController = TabController(
//           length: _availableStatuses.length,
//           vsync: this,
//           initialIndex: initialIndex,
//         );
//       }
//     } catch (e) {
//       print('Error fetching matches: $e');
//     } finally {
//       setState(() => _isLoading = false);
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
//         centerTitle: true,
//         title: const Text(
//           'Matches',
//           style: TextStyle(
//             color: Color(0xFF2E7D32),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _fetchMatches,
//           ),
//         ],
//         bottom: _isLoading || _availableStatuses.isEmpty
//             ? null
//             : TabBar(
//                 controller: _tabController,
//                 indicatorColor: const Color(0xFF2E7D32),
//                 labelColor: const Color(0xFF2E7D32),
//                 unselectedLabelColor: const Color(0xFF666666),
//                 isScrollable: _availableStatuses.length > 3,
//                 tabs: _availableStatuses
//                     .map((status) => Tab(text: _getStatusDisplayName(status)))
//                     .toList(),
//               ),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
//               ),
//             )
//           : _availableStatuses.isEmpty
//               ? _buildEmptyState()
//               : TabBarView(
//                   controller: _tabController,
//                   children: _availableStatuses
//                       .map((status) => _buildMatchList(
//                             _groupedMatches[status] ?? [],
//                             status,
//                           ))
//                       .toList(),
//                 ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.sports_soccer,
//             size: 64,
//             color: Color(0xFF999999),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'No matches found',
//             style: TextStyle(
//               fontSize: 16,
//               color: Color(0xFF999999),
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: _fetchMatches,
//             icon: const Icon(Icons.refresh),
//             label: const Text('Refresh'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2E7D32),
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMatchList(List<MatchData> matches, String status) {
//     if (matches.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               _getStatusIcon(status),
//               size: 64,
//               color: const Color(0xFF999999),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _getEmptyMessage(status),
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF999999),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: _fetchMatches,
//       color: const Color(0xFF2E7D32),
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: matches.length,
//         itemBuilder: (context, index) {
//           final match = matches[index];
//           return MatchDetailsCard(
//             match: match,
//             status: status,
//             onStartMatch: () => _startMatch(match),
//             onViewLive: () => _viewLiveMatch(match),
//             onViewDetails: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         FootballCompleted(matchId: match.id))),

//             // onOptions: () => _showMatchOptions(context, match),
//           );
//         },
//       ),
//     );
//   }

//   Future<Map<String, dynamic>?> _showMatchConfigModal(
//       BuildContext context) async {
//     int totalDuration = 90;
//     int halfTimeDuration = 15;

//     bool extraTimeAllowedForHalfTime = false;
//     int extraTimeDurationForHalfTime = 5;

//     bool extraTimeAllowedForFullTime = false;
//     int extraTimeDurationForFullTime = 10;

//     return showDialog<Map<String, dynamic>>(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: const Text(
//             'Match Configuration',
//             style: TextStyle(
//               color: Color(0xFF2E7D32),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Set match duration and settings',
//                   style: TextStyle(color: Color(0xFF666666), fontSize: 14),
//                 ),
//                 const SizedBox(height: 20),

//                 // 🕐 Total Duration
//                 _buildStepper(
//                   label: 'Total Duration (minutes)',
//                   value: totalDuration,
//                   onDecrease: () {
//                     if (totalDuration > 0) setState(() => totalDuration -= 5);
//                   },
//                   onIncrease: () => setState(() => totalDuration += 5),
//                 ),
//                 const SizedBox(height: 16),

//                 // 🛑 Half Time Duration
//                 _buildStepper(
//                   label: 'Half Time Duration (minutes)',
//                   value: halfTimeDuration,
//                   step: 1,
//                   minValue: 1,
//                   onDecrease: () {
//                     if (halfTimeDuration > 0)
//                       setState(() => halfTimeDuration -= 1);
//                   },
//                   onIncrease: () => setState(() => halfTimeDuration += 1),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(null),
//               child: const Text('Cancel',
//                   style: TextStyle(color: Color(0xFF666666))),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop({
//                   "totalDuration": totalDuration,
//                   "halfTimeDuration": halfTimeDuration,
//                   "extraTimeAllowedForHalfTime": extraTimeAllowedForHalfTime,
//                   "extraTimeDurationForHalfTime": extraTimeDurationForHalfTime,
//                   "extraTimeAllowedForFullTime": extraTimeAllowedForFullTime,
//                   "extraTimeDurationForFullTime": extraTimeDurationForFullTime,
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E7D32),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text('Continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _startMatch(MatchData match) async {
//     // Check match type
//     print("Match scoring method ======= ${match.scoringMethod}");
//     if (match.scoringMethod == 'Goal Based') {
//       final config = await _showMatchConfigModal(context);
//       if (config == null) return;

//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
//           ),
//         ),
//       );

//       try {
//         print("UserId: $userId");
//         print("MatchId: ${match.id}");

//         final payload = {
//           'startKickTime': DateTime.now().toIso8601String(),
//           'totalDuration': config['totalDuration'],
//           'halfTimeDuration': config['halfTimeDuration'],
//           'extraTimeAllowedForHalfTime': config['extraTimeAllowedForHalfTime'],
//           'extraTimeDurationForHalfTime':
//               config['extraTimeDurationForHalfTime'],
//           'extraTimeAllowedForFullTime': config['extraTimeAllowedForFullTime'],
//           'extraTimeDurationForFullTime':
//               config['extraTimeDurationForFullTime'],
//         };

//         print("🏸 Goal-based payload: ${jsonEncode(payload)}");

//         final response = await http.post(
//           Uri.parse(
//               'http://31.97.206.144:3081/users/startgamematch/$userId/${match.id}'),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode(payload),
//         );

//         Navigator.of(context).pop();

//         if (response.statusCode == 200) {
//           await _fetchMatches();
//           if (match.scoringMethod == "Goal Based") {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ScorecardScreen(
//                   matchId: match.id.toString(),
//                 ),
//               ),
//             );
//           }
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Match started successfully!'),
//               backgroundColor: Color(0xFF2E7D32),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Failed to start match: ${response.body}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } catch (e) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to start match'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }

//     // 🏸 Set-based match (like badminton)
//     else if (match.scoringMethod == 'Set Based') {
//       final config = await _showSetBasedConfigModal(context);
//       if (config == null) return;

//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
//           ),
//         ),
//       );

//       try {
//         final payload = {
//           "startTime": DateTime.now().toIso8601String(),
//           "totalSets": config['totalSets'],
//           "pointsPerSet": config['pointsPerSet'],
//           "winBy": config['winBy'],
//           "allowDeuce": config['allowDeuce'],
//           "maxDeucePoint": config['maxDeucePoint'],
//           "currentSet": 1
//         };

//         print("🏸 Set-based payload: ${jsonEncode(payload)}");

//         final response = await http.post(
//           Uri.parse(
//               'http://31.97.206.144:3081/users/startbadmintonmatch/${match.id}'),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode(payload),
//         );

//         Navigator.of(context).pop();

//         if (response.statusCode == 200) {
//           await _fetchMatches();
//           if (match.scoringMethod == "Set Based") {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SetBasedScreen(
//                   matchId: match.id.toString(),
//                 ),
//               ),
//             );
//           }
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Set-based match started successfully!'),
//               backgroundColor: Color(0xFF2E7D32),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Failed to start match: ${response.body}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } catch (e) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to start set-based match'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Future<Map<String, dynamic>?> _showSetBasedConfigModal(
//       BuildContext context) async {
//     int totalSets = 3;
//     int pointsPerSet = 21;
//     int winBy = 2;
//     bool allowDeuce = true;
//     int maxDeucePoint = 30;

//     return showDialog<Map<String, dynamic>>(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: const Text(
//             'Set-Based Match Configuration',
//             style: TextStyle(
//               color: Color(0xFF2E7D32),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildStepperSet(
//                   label: 'Total Sets',
//                   value: totalSets,
//                   step: 1,
//                   minValue: 1,
//                   onDecrease: () {
//                     if (totalSets > 1) setState(() => totalSets--);
//                   },
//                   onIncrease: () => setState(() => totalSets++),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildStepperSet(
//                   label: 'Points Per Set',
//                   value: pointsPerSet,
//                   step: 1,
//                   minValue: 11,
//                   onDecrease: () {
//                     if (pointsPerSet > 11) setState(() => pointsPerSet--);
//                   },
//                   onIncrease: () => setState(() => pointsPerSet++),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildStepperSet(
//                   label: 'Win By',
//                   value: winBy,
//                   step: 1,
//                   minValue: 1,
//                   onDecrease: () {
//                     if (winBy > 1) setState(() => winBy--);
//                   },
//                   onIncrease: () => setState(() => winBy++),
//                 ),
//                 const SizedBox(height: 16),
//                 SwitchListTile(
//                   title: const Text('Allow Deuce'),
//                   value: allowDeuce,
//                   onChanged: (val) => setState(() => allowDeuce = val),
//                 ),
//                 const SizedBox(height: 16),
//                 if (allowDeuce)
//                   _buildStepperSet(
//                     label: 'Max Deuce Point',
//                     value: maxDeucePoint,
//                     step: 1,
//                     minValue: 21,
//                     onDecrease: () {
//                       if (maxDeucePoint > 21) setState(() => maxDeucePoint--);
//                     },
//                     onIncrease: () => setState(() => maxDeucePoint++),
//                   ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(null),
//               child: const Text('Cancel',
//                   style: TextStyle(color: Color(0xFF666666))),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop({
//                   "totalSets": totalSets,
//                   "pointsPerSet": pointsPerSet,
//                   "winBy": winBy,
//                   "allowDeuce": allowDeuce,
//                   "maxDeucePoint": maxDeucePoint,
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E7D32),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text('Continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStepperSet({
//     required String label,
//     required int value,
//     required VoidCallback onDecrease,
//     required VoidCallback onIncrease,
//     int step = 1,
//     int minValue = 0,
//     String unit = '', // 🆕 optional text like "min", "pts", etc.
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color(0xFFCCCCCC)),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.remove, color: Color(0xFF2E7D32)),
//                 onPressed: () {
//                   if (value > minValue) onDecrease();
//                 },
//               ),
//               Expanded(
//                 child: Text(
//                   '$value${unit.isNotEmpty ? " $unit" : ""}', // 🧠 Smartly adds unit if provided
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2E7D32),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.add, color: Color(0xFF2E7D32)),
//                 onPressed: onIncrease,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   /// Reusable stepper widget
//   Widget _buildStepper({
//     required String label,
//     required int value,
//     required VoidCallback onDecrease,
//     required VoidCallback onIncrease,
//     int step = 10,
//     int minValue = 10,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color(0xFFCCCCCC)),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.remove),
//                 onPressed: () {
//                   if (value > minValue) onDecrease();
//                 },
//               ),
//               Expanded(
//                 child: Text(
//                   '$value min',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               IconButton(icon: const Icon(Icons.add), onPressed: onIncrease),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showMatchOptions(BuildContext context, MatchData match) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Match Options',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: const Icon(Icons.play_arrow, color: Color(0xFF2E7D32)),
//               title: const Text('Start Match'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _startMatch(match);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.schedule, color: Color(0xFFFF9800)),
//               title: const Text('Postpone Match'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _updateMatchStatus(match.id, 'postponed');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.cancel, color: Color(0xFFE53935)),
//               title: const Text('Cancel Match'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _updateMatchStatus(match.id, 'cancel');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete, color: Color(0xFFE53935)),
//               title: const Text('Delete Match'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _deleteMatch(match.id);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _updateMatchStatus(String matchId, String status) async {
//     try {
//       final response = await http.patch(
//         Uri.parse(
//             'http://31.97.206.144:3081/users/gamematches/$matchId/status'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'status': status}),
//       );

//       if (response.statusCode == 200) {
//         await _fetchMatches();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Match $status'),
//             backgroundColor: _getStatusColor(status),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to update match'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _deleteMatch(String matchId) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Match'),
//         content: const Text(
//             'Are you sure you want to delete this match? This action cannot be undone.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               try {
//                 final response = await http.delete(
//                   Uri.parse(
//                       'http://31.97.206.144:3081/users/gamematches/$matchId'),
//                 );

//                 if (response.statusCode == 200) {
//                   await _fetchMatches();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Match deleted successfully'),
//                       backgroundColor: Color(0xFF2E7D32),
//                     ),
//                   );
//                 }
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Failed to delete match'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//             child: const Text('Delete',
//                 style: TextStyle(color: Color(0xFFE53935))),
//           ),
//         ],
//       ),
//     );
//   }

//   void _viewLiveMatch(MatchData match) {
//     print("kkkkkkkkkkkkkkkkkkkkkkk${match.id}");
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Opening live match...')),
//     );

//     if (match.scoringMethod == "Set Based") {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SetBasedScreen(
//             matchId: match.id.toString(),
//           ),
//         ),
//       );
//     } else if (match.scoringMethod == "Goal Based") {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ScorecardScreen(
//             matchId: match.id.toString(),
//           ),
//         ),
//       );
//     } else if (match.scoringMethod == "Point Based") {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PointBasedScreen(
//             matchId: match.id.toString(),
//           ),
//         ),
//       );
//     }
//   }

//   void _viewMatchDetails(MatchData match) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Match details coming soon')),
//     );
//   }

//   String _getStatusDisplayName(String status) {
//     switch (status) {
//       case 'live':
//         return 'Live';
//       case 'upcoming':
//         return 'Upcoming';
//       case 'finished':
//         return 'Finished';
//       case 'postponed':
//         return 'Postponed';
//       case 'cancel':
//         return 'Cancelled';
//       default:
//         return status[0].toUpperCase() + status.substring(1);
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case 'live':
//         return Icons.play_circle_filled;
//       case 'upcoming':
//         return Icons.schedule;
//       case 'finished':
//         return Icons.check_circle;
//       case 'postponed':
//         return Icons.schedule_outlined;
//       case 'cancel':
//         return Icons.cancel;
//       default:
//         return Icons.help;
//     }
//   }

//   String _getEmptyMessage(String status) {
//     switch (status) {
//       case 'live':
//         return 'No live matches at the moment';
//       case 'upcoming':
//         return 'No upcoming matches scheduled';
//       case 'finished':
//         return 'No completed matches yet';
//       case 'postponed':
//         return 'No postponed matches';
//       case 'cancel':
//         return 'No cancelled matches';
//       default:
//         return 'No matches found';
//     }
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'live':
//         return const Color(0xFF2E7D32);
//       case 'upcoming':
//         return const Color(0xFF1976D2);
//       case 'finished':
//         return const Color(0xFF666666);
//       case 'postponed':
//         return const Color(0xFFFF9800);
//       case 'cancel':
//         return const Color(0xFFE53935);
//       default:
//         return const Color(0xFF666666);
//     }
//   }

//   String _getStatusText(String status) {
//     return status.toUpperCase();
//   }

//   String _formatDateTime(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }

// // Model class for Match Data
// class MatchData {
//   final String id;
//   final String name;
//   final String categoryName;
//   final String scoringMethod;
//   final String gameMode;
//   final List<String> players;
//   final List<TeamData> teams;
//   final String status;
//   final DateTime createdAt;
//   String? cancelReason;

//   MatchData({
//     required this.id,
//     required this.name,
//     required this.categoryName,
//     required this.scoringMethod,
//     required this.gameMode,
//     required this.players,
//     required this.teams,
//     required this.status,
//     required this.createdAt,
//     this.cancelReason
//   });

//   factory MatchData.fromJson(Map<String, dynamic> json) {
//     return MatchData(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       categoryName: json['categoryId']?['name'] ?? 'Unknown',
//       scoringMethod: json['scoringMethod'] ?? '',
//       gameMode: json['gameMode'] ?? 'singles',
//       players: List<String>.from(json['players'] ?? []),
//       teams:
//           (json['teams'] as List?)?.map((t) => TeamData.fromJson(t)).toList() ??
//               [],
//       status: json['status'] ?? 'upcoming',
//       createdAt:
//           DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//           cancelReason: json['cancelReason'] ?? 'No Reson Provided'
//     );
//   }
// }

// class TeamData {
//   final String teamId;

//   TeamData({required this.teamId});

//   factory TeamData.fromJson(Map<String, dynamic> json) {
//     return TeamData(
//       teamId: json['teamId'] ?? '',
//     );
//   }
// }
















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Games/GameViews/Badminton/comppleted_screen.dart';
import 'package:booking_application/views/Games/GameViews/Football/football_completed.dart';
import 'package:booking_application/views/Games/GameViews/Volleyball/completed.dart';
import 'package:booking_application/views/Games/GameViews/Volleyball/score.dart';
import 'package:booking_application/views/Games/GameViews/point_based_screen.dart';
import 'package:booking_application/views/Games/GameViews/set_based_screen.dart';
import 'package:booking_application/views/Games/GameViews/Football/game_selection.dart';
import 'package:booking_application/views/Games/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewMatchScreen extends StatefulWidget {
  final int initialTabIndex;
  const ViewMatchScreen({super.key, required this.initialTabIndex});

  @override
  State<ViewMatchScreen> createState() => _ViewMatchScreenState();
}

class _ViewMatchScreenState extends State<ViewMatchScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  Map<String, List<MatchData>> _groupedMatches = {};
  List<String> _availableStatuses = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    loadUserId();
    _fetchMatches();
  }

  void loadUserId() async {
    final currentUser = await UserPreferences.getUser();
    setState(() {
      userId = currentUser?.id.toString();
    });
  }

  Future<void> _fetchMatches() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/gamematches'),
      );

      print("Response: Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = (data['matches'] as List)
            .map((json) => MatchData.fromJson(json))
            .toList();

        // Group matches by status
        _groupedMatches = {};
        for (var match in matches) {
          if (!_groupedMatches.containsKey(match.status)) {
            _groupedMatches[match.status] = [];
          }
          _groupedMatches[match.status]!.add(match);
        }

        // Get available statuses in preferred order
        final statusOrder = [
          'live',
          'upcoming',
          'finished',
          'cancel',
          'postponed',
        ];
        _availableStatuses = statusOrder
            .where((status) => _groupedMatches.containsKey(status))
            .toList();

        print("Initial Tab Index: ${widget.initialTabIndex}");

        int initialIndex = 0;
        if (widget.initialTabIndex >= 0 && widget.initialTabIndex < _availableStatuses.length) {
          initialIndex = widget.initialTabIndex;
        }

        // Initialize tab controller with dynamic length
        _tabController = TabController(
          length: _availableStatuses.length,
          vsync: this,
          initialIndex: initialIndex,
        );
      }
    } catch (e) {
      print('Error fetching matches: $e');
    } finally {
      setState(() => _isLoading = false);
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
        centerTitle: true,
        title: const Text(
          'Matches',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchMatches,
          ),
        ],
        bottom: _isLoading || _availableStatuses.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF2E7D32),
                labelColor: const Color(0xFF2E7D32),
                unselectedLabelColor: const Color(0xFF666666),
                isScrollable: _availableStatuses.length > 3,
                tabs: _availableStatuses
                    .map((status) => Tab(text: _getStatusDisplayName(status)))
                    .toList(),
              ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
              ),
            )
          : _availableStatuses.isEmpty
              ? _buildEmptyState()
              : TabBarView(
                  controller: _tabController,
                  children: _availableStatuses
                      .map((status) => _buildMatchList(
                            _groupedMatches[status] ?? [],
                            status,
                          ))
                      .toList(),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sports_soccer,
            size: 64,
            color: Color(0xFF999999),
          ),
          const SizedBox(height: 16),
          const Text(
            'No matches found',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF999999),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _fetchMatches,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchList(List<MatchData> matches, String status) {
    if (matches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getStatusIcon(status),
              size: 64,
              color: const Color(0xFF999999),
            ),
            const SizedBox(height: 16),
            Text(
              _getEmptyMessage(status),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchMatches,
      color: const Color(0xFF2E7D32),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return MatchDetailsCard(
            match: match,
            status: status,
            onStartMatch: () => _startMatch(match),
            onViewLive: () => _viewLiveMatch(match),
            onViewDetails: () {
              if(match.categoryName == "Football"){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FootballCompleted(matchId: match.id)));
              }else if(match.categoryName == 'Badminton'){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BadmintonScoreCardScreen(matchId: match.id)));
              }else if(match.categoryName == 'Volleyball'){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        VolleyballScorecardScreen(matchId: match.id)));
              }
            }
          );
        },
      ),
    );
  }

  void _startMatch(MatchData match) async {
    print("Match scoring method ======= ${match.scoringMethod}");
    
    // Determine scoring method from category name
    final scoringMethod = _getScoringMethodFromCategory(match.categoryName);
        print("Match scoring methoddddddddddd ======= $scoringMethod");
                print("Match scoring methoddddddddddd ======= ${match.categoryName}");


    
    if (scoringMethod == 'Goal Based') {
      final config = await _showFootballConfigModal(context);
      if (config == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
          ),
        ),
      );

      try {
        print("UserId: $userId");
        print("MatchId: ${match.id}");

        // Get team configurations
        final teamConfigs = await _getFootballTeamConfigurations(match);
        if (teamConfigs == null) {
          Navigator.of(context).pop();
          return;
        }

        final payload = {
          'startKickTime': DateTime.now().toIso8601String(),
          'totalDuration': config['totalDuration'],
          'halfTimeDuration': config['halfTimeDuration'],
          'refereeName': config['refereeName'],
          'extraTimeAllowedForHalfTime': config['extraTimeAllowedForHalfTime'],
          'extraTimeDurationForHalfTime': config['extraTimeDurationForHalfTime'],
          'extraTimeAllowedForFullTime': config['extraTimeAllowedForFullTime'],
          'extraTimeDurationForFullTime': config['extraTimeDurationForFullTime'],
          'teams': teamConfigs,
        };

        print("⚽ Football payload: ${jsonEncode(payload)}");

        final response = await http.post(
          Uri.parse('http://31.97.206.144:3081/users/startgamematch/$userId/${match.id}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        Navigator.of(context).pop();

        if (response.statusCode == 200) {
          await _fetchMatches();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScorecardScreen(
                matchId: match.id.toString(),
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Football match started successfully!'),
              backgroundColor: Color(0xFF2E7D32),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to start match: ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start match: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    // Set-based match (like badminton, volleyball)
    else if (scoringMethod == 'Set Based') {
    if(match.categoryName == 'Badminton'){
        final config = await _showSetBasedConfigModal(context);
      if (config == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
          ),
        ),
      );

      try {
        final payload = {
          "startTime": DateTime.now().toIso8601String(),
          "totalSets": config['totalSets'],
          "pointsPerSet": config['pointsPerSet'],
          "winBy": config['winBy'],
          "allowDeuce": config['allowDeuce'],
          "maxDeucePoint": config['maxDeucePoint'],
          "currentSet": 1
        };

        print("🏸 Set-based payload: ${jsonEncode(payload)}");

        final response = await http.post(
          Uri.parse('http://31.97.206.144:3081/users/startbadmintonmatch/${match.id}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        Navigator.of(context).pop();

        if (response.statusCode == 200) {
          await _fetchMatches();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SetBasedScreen(
                matchId: match.id.toString(),
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Set-based match started successfully!'),
              backgroundColor: Color(0xFF2E7D32),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to start match: ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start set-based match: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }else if(match.categoryName == 'Volleyball'){
        final config = await _showVolleyballBasedConfigModal(context);
      if (config == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
          ),
        ),
      );

      try {
        final payload = {
          "startTime": DateTime.now().toIso8601String(),
          "totalSets": config['totalSets'],
          "pointsPerSet": config['pointsPerSet'],
          "winBy": config['winBy'],
          "allowDeuce": config['allowDeuce'],
          "finalSetPoints": config['finalSetPoints'],
          "currentSet": 1
        };

        print("🏸 Set-based payload: ${jsonEncode(payload)}");

        final response = await http.post(
          Uri.parse('http://31.97.206.144:3081/users/startbadmintonmatch/${match.id}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        Navigator.of(context).pop();

        if (response.statusCode == 200) {
          await _fetchMatches();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScoreVolleyball(
                matchId: match.id.toString(),
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Set-based match started successfully!'),
              backgroundColor: Color(0xFF2E7D32),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to start match: ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start set-based match: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    }
  }

  String _getScoringMethodFromCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'football':
        return 'Goal Based';
      case 'badminton':
      case 'volleyball':
        return 'Set Based';
      default:
        return 'Point Based';
    }
  }

  Future<Map<String, dynamic>?> _showFootballConfigModal(BuildContext context) async {
    int totalDuration = 90;
    int halfTimeDuration = 15;
    String refereeName = '';

    bool extraTimeAllowedForHalfTime = false;
    int extraTimeDurationForHalfTime = 5;

    bool extraTimeAllowedForFullTime = false;
    int extraTimeDurationForFullTime = 10;

    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'Football Match Configuration',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Set match duration and referee details',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                ),
                const SizedBox(height: 20),

                // 👨‍⚖️ Referee Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Referee Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32)),
                    ),
                  ),
                  onChanged: (value) => setState(() => refereeName = value),
                ),
                const SizedBox(height: 16),

                // 🕐 Total Duration
                _buildStepper(
                  label: 'Total Duration (minutes)',
                  value: totalDuration,
                  onDecrease: () {
                    if (totalDuration > 0) setState(() => totalDuration -= 5);
                  },
                  onIncrease: () => setState(() => totalDuration += 5),
                ),
                const SizedBox(height: 16),

                // 🛑 Half Time Duration
                _buildStepper(
                  label: 'Half Time Duration (minutes)',
                  value: halfTimeDuration,
                  step: 1,
                  minValue: 1,
                  onDecrease: () {
                    if (halfTimeDuration > 0) setState(() => halfTimeDuration -= 1);
                  },
                  onIncrease: () => setState(() => halfTimeDuration += 1),
                ),
                const SizedBox(height: 16),

                // ⏱️ Extra Time Options
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Extra Time Settings',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        
                        // Half Time Extra Time
                        SwitchListTile(
                          title: const Text('Allow Extra Time for Half Time'),
                          value: extraTimeAllowedForHalfTime,
                          onChanged: (value) => setState(() => extraTimeAllowedForHalfTime = value),
                        ),
                        if (extraTimeAllowedForHalfTime) ...[
                          _buildStepper(
                            label: 'Half Time Extra Time (minutes)',
                            value: extraTimeDurationForHalfTime,
                            step: 1,
                            minValue: 1,
                            onDecrease: () {
                              if (extraTimeDurationForHalfTime > 1) 
                                setState(() => extraTimeDurationForHalfTime -= 1);
                            },
                            onIncrease: () => setState(() => extraTimeDurationForHalfTime += 1),
                          ),
                        ],
                        
                        const SizedBox(height: 8),
                        
                        // Full Time Extra Time
                        SwitchListTile(
                          title: const Text('Allow Extra Time for Full Time'),
                          value: extraTimeAllowedForFullTime,
                          onChanged: (value) => setState(() => extraTimeAllowedForFullTime = value),
                        ),
                        if (extraTimeAllowedForFullTime) ...[
                          _buildStepper(
                            label: 'Full Time Extra Time (minutes)',
                            value: extraTimeDurationForFullTime,
                            step: 1,
                            minValue: 1,
                            onDecrease: () {
                              if (extraTimeDurationForFullTime > 1) 
                                setState(() => extraTimeDurationForFullTime -= 1);
                            },
                            onIncrease: () => setState(() => extraTimeDurationForFullTime += 1),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF666666))),
            ),
            ElevatedButton(
              onPressed: () {
                if (refereeName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter referee name')),
                  );
                  return;
                }
                Navigator.of(context).pop({
                  "totalDuration": totalDuration,
                  "halfTimeDuration": halfTimeDuration,
                  "refereeName": refereeName,
                  "extraTimeAllowedForHalfTime": extraTimeAllowedForHalfTime,
                  "extraTimeDurationForHalfTime": extraTimeDurationForHalfTime,
                  "extraTimeAllowedForFullTime": extraTimeAllowedForFullTime,
                  "extraTimeDurationForFullTime": extraTimeDurationForFullTime,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Continue to Team Setup'),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>?> _getFootballTeamConfigurations(MatchData match) async {
    try {
      List<dynamic> teamConfigs = [];
      
      for (var team in match.teams) {
        final teamConfig = await _showFootballTeamConfigurationModal(context, team);
        if (teamConfig == null) return null;
        teamConfigs.add(teamConfig);
      }
      
      return teamConfigs;
    } catch (e) {
      print('Error getting team configurations: $e');
      return null;
    }
  }

Future<Map<String, dynamic>?> _showFootballTeamConfigurationModal(
    BuildContext context, TeamData team) async {
  
  String? selectedCaptainId;
  Map<String, bool> playingPlayers = {};
  Map<String, String> playerPositions = {};

  // Initialize all players as playing initially with default positions
  for (var player in team.players) {
    playingPlayers[player.playerId] = true;
    playerPositions[player.playerId] = 'Player'; // Default position
  }

  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('Configure ${team.teamName}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select captain and configure players',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
              const SizedBox(height: 16),
              
              // Captain Selection
              const Text(
                'Select Captain:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedCaptainId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  hintText: 'Select Captain',
                ),
                items: team.players.map((player) {
                  return DropdownMenuItem(
                    value: player.playerId,
                    child: Text(player.playerName),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedCaptainId = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a captain';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Players Configuration
              const Text(
                'Players Configuration:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Green = Playing, Red = Not Playing',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              ...team.players.map((player) {
                final isPlaying = playingPlayers[player.playerId] ?? false;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: isPlaying ? Colors.green[50] : Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                player.playerName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isPlaying ? Colors.green[800] : Colors.red[800],
                                ),
                              ),
                            ),
                            Switch(
                              value: isPlaying,
                              onChanged: (value) => setState(() {
                                playingPlayers[player.playerId] = value;
                              }),
                              activeColor: const Color(0xFF2E7D32),
                              inactiveThumbColor: Colors.red,
                            ),
                          ],
                        ),
                        if (isPlaying) ...[
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: playerPositions[player.playerId],
                            decoration: const InputDecoration(
                              labelText: 'Position',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              hintText: 'e.g., Forward, Defender, Goalkeeper',
                            ),
                            onChanged: (value) => setState(() {
                              playerPositions[player.playerId] = value;
                            }),
                          ),
                        ] else ...[
                          const SizedBox(height: 4),
                          Text(
                            'Not Playing',
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedCaptainId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a captain')),
                );
                return;
              }
              
              // Prepare players list - ALL players will be sent with their isPlaying status
              List<Map<String, dynamic>> players = [];
              for (var player in team.players) {
                final isPlaying = playingPlayers[player.playerId] ?? false;
                players.add({
                  "playerId": player.playerId,
                  "playerName": player.playerName,
                  "position": isPlaying 
                      ? (playerPositions[player.playerId] ?? 'Player')
                      : 'Bench', // Or any default for non-playing players
                  "isPlaying": isPlaying
                });
              }

              // Show confirmation dialog if no players are selected to play
              final playingCount = players.where((p) => p['isPlaying'] == true).length;
              if (playingCount == 0) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('No Players Selected'),
                    content: const Text('No players are marked as "Playing". Are you sure you want to continue?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close confirmation dialog
                          Navigator.of(context).pop({ // Close team config dialog
                            "teamId": team.teamId,
                            "captainId": selectedCaptainId,
                            "teamName": team.teamName,
                            "players": players,
                          });
                        },
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.of(context).pop({
                  "teamId": team.teamId,
                  "captainId": selectedCaptainId,
                  "teamName": team.teamName,
                  "players": players,
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
            ),
            child: const Text('Save Team Configuration'),
          ),
        ],
      ),
    ),
  );
}

  Future<Map<String, dynamic>?> _showSetBasedConfigModal(BuildContext context) async {
    int totalSets = 3;
    int pointsPerSet = 21;
    int winBy = 2;
    bool allowDeuce = true;
    int maxDeucePoint = 30;

    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'Set-Based Match Configuration',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepperSet(
                  label: 'Total Sets',
                  value: totalSets,
                  step: 1,
                  minValue: 1,
                  onDecrease: () {
                    if (totalSets > 1) setState(() => totalSets--);
                  },
                  onIncrease: () => setState(() => totalSets++),
                ),
                const SizedBox(height: 16),
                _buildStepperSet(
                  label: 'Points Per Set',
                  value: pointsPerSet,
                  step: 1,
                  minValue: 11,
                  onDecrease: () {
                    if (pointsPerSet > 11) setState(() => pointsPerSet--);
                  },
                  onIncrease: () => setState(() => pointsPerSet++),
                ),
                const SizedBox(height: 16),
                _buildStepperSet(
                  label: 'Win By',
                  value: winBy,
                  step: 1,
                  minValue: 1,
                  onDecrease: () {
                    if (winBy > 1) setState(() => winBy--);
                  },
                  onIncrease: () => setState(() => winBy++),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Allow Deuce'),
                  value: allowDeuce,
                  onChanged: (val) => setState(() => allowDeuce = val),
                ),
                const SizedBox(height: 16),
                if (allowDeuce)
                  _buildStepperSet(
                    label: 'Max Deuce Point',
                    value: maxDeucePoint,
                    step: 1,
                    minValue: 21,
                    onDecrease: () {
                      if (maxDeucePoint > 21) setState(() => maxDeucePoint--);
                    },
                    onIncrease: () => setState(() => maxDeucePoint++),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF666666))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  "totalSets": totalSets,
                  "pointsPerSet": pointsPerSet,
                  "winBy": winBy,
                  "allowDeuce": allowDeuce,
                  "maxDeucePoint": maxDeucePoint,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }


    Future<Map<String, dynamic>?> _showVolleyballBasedConfigModal(BuildContext context) async {
    int totalSets = 3;
    int pointsPerSet = 21;
    int winBy = 2;
    bool allowDeuce = true;
    int finalSetPoints = 15;

    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'Set-Based Match Configuration',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepperSet(
                  label: 'Total Sets',
                  value: totalSets,
                  step: 1,
                  minValue: 1,
                  onDecrease: () {
                    if (totalSets > 1) setState(() => totalSets--);
                  },
                  onIncrease: () => setState(() => totalSets++),
                ),
                const SizedBox(height: 16),
                _buildStepperSet(
                  label: 'Points Per Set',
                  value: pointsPerSet,
                  step: 1,
                  minValue: 11,
                  onDecrease: () {
                    if (pointsPerSet > 11) setState(() => pointsPerSet--);
                  },
                  onIncrease: () => setState(() => pointsPerSet++),
                ),
                const SizedBox(height: 16),
                _buildStepperSet(
                  label: 'Win By',
                  value: winBy,
                  step: 1,
                  minValue: 1,
                  onDecrease: () {
                    if (winBy > 1) setState(() => winBy--);
                  },
                  onIncrease: () => setState(() => winBy++),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Allow Deuce'),
                  value: allowDeuce,
                  onChanged: (val) => setState(() => allowDeuce = val),
                ),
                const SizedBox(height: 16),
                if (allowDeuce)
                  _buildStepperSet(
                    label: 'Final Set Points',
                    value: finalSetPoints,
                    step: 1,
                    minValue: 15,
                    onDecrease: () {
                      if (finalSetPoints > 21) setState(() => finalSetPoints--);
                    },
                    onIncrease: () => setState(() => finalSetPoints++),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF666666))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  "totalSets": totalSets,
                  "pointsPerSet": pointsPerSet,
                  "winBy": winBy,
                  "allowDeuce": allowDeuce,
                  "maxDeucePoint": finalSetPoints,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperSet({
    required String label,
    required int value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    int step = 1,
    int minValue = 0,
    String unit = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Color(0xFF2E7D32)),
                onPressed: () {
                  if (value > minValue) onDecrease();
                },
              ),
              Expanded(
                child: Text(
                  '$value${unit.isNotEmpty ? " $unit" : ""}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFF2E7D32)),
                onPressed: onIncrease,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepper({
    required String label,
    required int value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    int step = 10,
    int minValue = 10,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (value > minValue) onDecrease();
                },
              ),
              Expanded(
                child: Text(
                  '$value min',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(icon: const Icon(Icons.add), onPressed: onIncrease),
            ],
          ),
        ),
      ],
    );
  }

  void _showMatchOptions(BuildContext context, MatchData match) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Match Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.play_arrow, color: Color(0xFF2E7D32)),
              title: const Text('Start Match'),
              onTap: () {
                Navigator.pop(context);
                _startMatch(match);
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Color(0xFFFF9800)),
              title: const Text('Postpone Match'),
              onTap: () {
                Navigator.pop(context);
                _updateMatchStatus(match.id, 'postponed');
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Color(0xFFE53935)),
              title: const Text('Cancel Match'),
              onTap: () {
                Navigator.pop(context);
                _updateMatchStatus(match.id, 'cancel');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Color(0xFFE53935)),
              title: const Text('Delete Match'),
              onTap: () {
                Navigator.pop(context);
                _deleteMatch(match.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateMatchStatus(String matchId, String status) async {
    try {
      final response = await http.patch(
        Uri.parse('http://31.97.206.144:3081/users/gamematches/$matchId/status'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status}),
      );

      if (response.statusCode == 200) {
        await _fetchMatches();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Match $status'),
            backgroundColor: _getStatusColor(status),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update match'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteMatch(String matchId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Match'),
        content: const Text(
            'Are you sure you want to delete this match? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                final response = await http.delete(
                  Uri.parse('http://31.97.206.144:3081/users/gamematches/$matchId'),
                );

                if (response.statusCode == 200) {
                  await _fetchMatches();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Match deleted successfully'),
                      backgroundColor: Color(0xFF2E7D32),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to delete match'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFE53935))),
          ),
        ],
      ),
    );
  }

  void _viewLiveMatch(MatchData match) {
    print("Opening live match: ${match.id}");
    
    final scoringMethod = _getScoringMethodFromCategory(match.categoryName);
    
    if (scoringMethod == "Set Based") {
      if(match.categoryName == 'Badminton'){
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SetBasedScreen(
            matchId: match.id.toString(),
          ),
        ),
      );
      }else if(match.categoryName == 'Volleyball'){
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreVolleyball(
            matchId: match.id.toString(),
          ),
        ),
      );
      }

    } else if (scoringMethod == "Goal Based") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorecardScreen(
            matchId: match.id.toString(),
          ),
        ),
      );
    } else if (scoringMethod == "Point Based") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PointBasedScreen(
            matchId: match.id.toString(),
          ),
        ),
      );
    }
  }

  void _viewMatchDetails(MatchData match) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Match details coming soon')),
    );
  }

  String _getStatusDisplayName(String status) {
    switch (status) {
      case 'live':
        return 'Live';
      case 'upcoming':
        return 'Upcoming';
      case 'finished':
        return 'Finished';
      case 'postponed':
        return 'Postponed';
      case 'cancel':
        return 'Cancelled';
      default:
        return status[0].toUpperCase() + status.substring(1);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'live':
        return Icons.play_circle_filled;
      case 'upcoming':
        return Icons.schedule;
      case 'finished':
        return Icons.check_circle;
      case 'postponed':
        return Icons.schedule_outlined;
      case 'cancel':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getEmptyMessage(String status) {
    switch (status) {
      case 'live':
        return 'No live matches at the moment';
      case 'upcoming':
        return 'No upcoming matches scheduled';
      case 'finished':
        return 'No completed matches yet';
      case 'postponed':
        return 'No postponed matches';
      case 'cancel':
        return 'No cancelled matches';
      default:
        return 'No matches found';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'live':
        return const Color(0xFF2E7D32);
      case 'upcoming':
        return const Color(0xFF1976D2);
      case 'finished':
        return const Color(0xFF666666);
      case 'postponed':
        return const Color(0xFFFF9800);
      case 'cancel':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF666666);
    }
  }

  String _getStatusText(String status) {
    return status.toUpperCase();
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// Model class for Match Data
class MatchData {
  final String id;
  final String name;
  final String categoryName;
  final String scoringMethod;
  final String gameMode;
  final List<String> players;
  final List<TeamData> teams;
  final String status;
  final DateTime createdAt;
  String? cancelReason;
  final String currentStatus;
  final DateTime? startTime;
  final int totalSets;
  final int pointsPerSet;
  final int winBy;
  final bool allowDeuce;
  final int maxDeucePoint;
  final int currentSet;
  final String? winner;
  final bool isTeamMatch;

  MatchData({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.scoringMethod,
    required this.gameMode,
    required this.players,
    required this.teams,
    required this.status,
    required this.createdAt,
    this.cancelReason,
    required this.currentStatus,
    this.startTime,
    required this.totalSets,
    required this.pointsPerSet,
    required this.winBy,
    required this.allowDeuce,
    required this.maxDeucePoint,
    required this.currentSet,
    this.winner,
    required this.isTeamMatch,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      categoryName: json['categoryId']?['name'] ?? 'Unknown',
      scoringMethod: json['scoringMethod'] ?? '',
      gameMode: json['gameMode'] ?? 'singles',
      players: List<String>.from(json['players'] ?? []),
      teams: (json['teams'] as List?)?.map((t) => TeamData.fromJson(t)).toList() ?? [],
      status: json['status'] ?? 'upcoming',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      cancelReason: json['cancelReason'],
      currentStatus: json['currentStatus'] ?? 'not-started',
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      totalSets: json['totalSets'] ?? 3,
      pointsPerSet: json['pointsPerSet'] ?? 21,
      winBy: json['winBy'] ?? 2,
      allowDeuce: json['allowDeuce'] ?? true,
      maxDeucePoint: json['maxDeucePoint'] ?? 30,
      currentSet: json['currentSet'] ?? 1,
      winner: json['winner'],
      isTeamMatch: json['isTeamMatch'] ?? true,
    );
  }
}

class TeamData {
  final String teamId;
  final String teamName;
  final List<PlayerData> players;

  TeamData({
    required this.teamId,
    required this.teamName,
    required this.players,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      teamId: json['teamId'] ?? '',
      teamName: json['teamName'] ?? '',
      players: (json['players'] as List?)?.map((p) => PlayerData.fromJson(p)).toList() ?? [],
    );
  }
}

class PlayerData {
  final String playerId;
  final String playerName;

  PlayerData({
    required this.playerId,
    required this.playerName,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      playerId: json['playerId'] ?? '',
      playerName: json['playerName'] ?? '',
    );
  }
}