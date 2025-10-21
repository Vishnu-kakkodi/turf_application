import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Games/GameViews/football_completed.dart';
import 'package:booking_application/views/Games/GameViews/point_based_screen.dart';
import 'package:booking_application/views/Games/GameViews/set_based_screen.dart';
import 'package:booking_application/views/Games/game_selection.dart';
import 'package:booking_application/views/Games/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewMatchScreen extends StatefulWidget {
  const ViewMatchScreen({super.key});

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
          'postponed',
          'cancel',
        ];
        _availableStatuses = statusOrder
            .where((status) => _groupedMatches.containsKey(status))
            .toList();

        // Initialize tab controller with dynamic length
        _tabController = TabController(
          length: _availableStatuses.length,
          vsync: this,
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
                        onViewDetails: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>FootballCompleted(matchId: match.id))),

            

            // onOptions: () => _showMatchOptions(context, match),
          );
        },
      ),
    );
  }

  // Widget _buildMatchCard(MatchData match, String status) {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 16),
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 decoration: BoxDecoration(
  //                   color: _getStatusColor(status).withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Text(
  //                   _getStatusText(status),
  //                   style: TextStyle(
  //                     color: _getStatusColor(status),
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //               const Spacer(),
  //               Text(
  //                 _formatDateTime(match.createdAt),
  //                 style: const TextStyle(
  //                   color: Color(0xFF666666),
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 12),
  //           Text(
  //             match.name,
  //             style: const TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xFF333333),
  //             ),
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             '${match.categoryName} • ${match.scoringMethod} • ${match.gameMode == 'team' ? 'Team Mode' : 'Singles Mode'}',
  //             style: const TextStyle(
  //               fontSize: 13,
  //               color: Color(0xFF999999),
  //             ),
  //           ),
  //           const SizedBox(height: 8),
  //           if (match.teams.isNotEmpty) ...[
  //             Row(
  //               children: [
  //                 const Icon(Icons.group, size: 16, color: Color(0xFF666666)),
  //                 const SizedBox(width: 4),
  //                 Expanded(
  //                   child: Text(
  //                     'Teams: ${match.teams.length} teams',
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: Color(0xFF666666),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ] else if (match.players.isNotEmpty) ...[
  //             Row(
  //               children: [
  //                 const Icon(Icons.person, size: 16, color: Color(0xFF666666)),
  //                 const SizedBox(width: 4),
  //                 Expanded(
  //                   child: Text(
  //                     'Players: ${match.players.join(', ')}',
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: Color(0xFF666666),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //           const SizedBox(height: 12),
  //           _buildActionButtons(match, status),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildActionButtons(MatchData match, String status) {
  //   if (status == 'upcoming') {
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: ElevatedButton(
  //             onPressed: () => _startMatch(match),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0xFF2E7D32),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //             ),
  //             child: const Text(
  //               'Start Match',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         Expanded(
  //           child: OutlinedButton(
  //             onPressed: () => _showMatchOptions(context, match),
  //             style: OutlinedButton.styleFrom(
  //               side: const BorderSide(color: Color(0xFF2E7D32)),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //             ),
  //             child: const Text(
  //               'Options',
  //               style: TextStyle(color: Color(0xFF2E7D32)),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   } else if (status == 'live') {
  //     return SizedBox(
  //       width: double.infinity,
  //       child: ElevatedButton(
  //         onPressed: () => _viewLiveMatch(match),
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: const Color(0xFF2E7D32),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //         ),
  //         child: const Text(
  //           'View Live Match',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );
  //   } else {
  //     return SizedBox(
  //       width: double.infinity,
  //       child: OutlinedButton(
  //         onPressed: () => _viewMatchDetails(match),
  //         style: OutlinedButton.styleFrom(
  //           side: const BorderSide(color: Color(0xFF2E7D32)),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //         ),
  //         child: const Text(
  //           'View Details',
  //           style: TextStyle(color: Color(0xFF2E7D32)),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // void _startMatch(MatchData match) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => const Center(
  //       child: CircularProgressIndicator(
  //         valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
  //       ),
  //     ),
  //   );

  //   try {
  //     print("UserId: $userId");
  //     print("MatchId: ${match.id}");

  //     final response = await http.post(
  //       Uri.parse(
  //           'http://31.97.206.144:3081/users/startgamematch/$userId/${match.id}'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'status': 'live',
  //         'startKickTime': DateTime.now().toIso8601String(),
  //       }),
  //     );

  //     print("Response status body: ${response.body}");

  //     Navigator.of(context).pop();

  //     if (response.statusCode == 200) {
  //       await _fetchMatches();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Match started successfully!'),
  //           backgroundColor: Color(0xFF2E7D32),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     Navigator.of(context).pop();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Failed to start match'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  void _startMatch(MatchData match) async {
    // Show configuration modal first
    final config = await _showMatchConfigModal(context);

    // If user cancelled, return
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

      // 🧾 Prepare payload
      final payload = {
        'startKickTime': DateTime.now().toIso8601String(),
        'totalDuration': config['totalDuration'],
        'halfTimeDuration': config['halfTimeDuration'],
        'extraTimeAllowedForHalfTime': config['extraTimeAllowedForHalfTime'],
        'extraTimeDurationForHalfTime': config['extraTimeDurationForHalfTime'],
        'extraTimeAllowedForFullTime': config['extraTimeAllowedForFullTime'],
        'extraTimeDurationForFullTime': config['extraTimeDurationForFullTime'],
      };

      print("📦 Payload being sent:");
      print(const JsonEncoder.withIndent('  ').convert(payload));

      // 🌐 Send request
      final response = await http.post(
        Uri.parse(
            'http://31.97.206.144:3081/users/startgamematch/$userId/${match.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        await _fetchMatches();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Match started successfully!'),
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
        const SnackBar(
          content: Text('Failed to start match'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// Future<Map<String, dynamic>?> _showMatchConfigModal(BuildContext context) async {
//   int totalDuration = 90;
//   int halfTimeDuration = 15;
//   bool extraTimeAllowed = false;
//   int extraTimeDuration = 30;

//   return showDialog<Map<String, dynamic>>(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => StatefulBuilder(
//       builder: (context, setState) => AlertDialog(
//         title: const Text(
//           'Match Configuration',
//           style: TextStyle(
//             color: Color(0xFF2E7D32),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Set match duration and settings',
//                 style: TextStyle(
//                   color: Color(0xFF666666),
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Total Duration
//               const Text(
//                 'Total Duration (minutes)',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: const Color(0xFFCCCCCC)),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.remove),
//                       onPressed: () {
//                         if (totalDuration > 30) {
//                           setState(() => totalDuration -= 15);
//                         }
//                       },
//                     ),
//                     Expanded(
//                       child: Text(
//                         '$totalDuration min',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.add),
//                       onPressed: () {
//                         setState(() => totalDuration += 15);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Half Time Duration
//               const Text(
//                 'Half Time Duration (minutes)',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: const Color(0xFFCCCCCC)),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.remove),
//                       onPressed: () {
//                         if (halfTimeDuration > 5) {
//                           setState(() => halfTimeDuration -= 5);
//                         }
//                       },
//                     ),
//                     Expanded(
//                       child: Text(
//                         '$halfTimeDuration min',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.add),
//                       onPressed: () {
//                         setState(() => halfTimeDuration += 5);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Extra Time Toggle
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF5F5F5),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: SwitchListTile(
//                   title: const Text(
//                     'Allow Extra Time',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                   value: extraTimeAllowed,
//                   activeColor: const Color(0xFF2E7D32),
//                   onChanged: (value) {
//                     setState(() => extraTimeAllowed = value);
//                   },
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//               ),

//               // Extra Time Duration (only show if enabled)
//               if (extraTimeAllowed) ...[
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Extra Time Duration (minutes)',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: const Color(0xFFCCCCCC)),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.remove),
//                         onPressed: () {
//                           if (extraTimeDuration > 10) {
//                             setState(() => extraTimeDuration -= 10);
//                           }
//                         },
//                       ),
//                       Expanded(
//                         child: Text(
//                           '$extraTimeDuration min',
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           setState(() => extraTimeDuration += 10);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(null),
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Color(0xFF666666)),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop({
//                 'totalDuration': totalDuration,
//                 'halfTimeDuration': halfTimeDuration,
//                 'extraTimeAllowed': extraTimeAllowed,
//                 'extraTimeDuration': extraTimeDuration,
//               });
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2E7D32),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text('Continue'),
//           ),
//         ],
//       ),
//     ),
//   );
// }

  Future<Map<String, dynamic>?> _showMatchConfigModal(
      BuildContext context) async {
    int totalDuration = 90;
    int halfTimeDuration = 15;

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
            'Match Configuration',
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
                  'Set match duration and settings',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                ),
                const SizedBox(height: 20),

                // 🕐 Total Duration
                _buildStepper(
                  label: 'Total Duration (minutes)',
                  value: totalDuration,
                  onDecrease: () {
                    if (totalDuration > 30) setState(() => totalDuration -= 15);
                  },
                  onIncrease: () => setState(() => totalDuration += 15),
                ),
                const SizedBox(height: 16),

                // 🛑 Half Time Duration
                _buildStepper(
                  label: 'Half Time Duration (minutes)',
                  value: halfTimeDuration,
                  step: 5,
                  minValue: 5,
                  onDecrease: () {
                    if (halfTimeDuration > 5)
                      setState(() => halfTimeDuration -= 5);
                  },
                  onIncrease: () => setState(() => halfTimeDuration += 5),
                ),
                // const SizedBox(height: 16),

                // ⚽ Extra Time for Half-Time
                // SwitchListTile(
                //   title: const Text('Allow Extra Time (Half-Time)'),
                //   value: extraTimeAllowedForHalfTime,
                //   activeColor: const Color(0xFF2E7D32),
                //   onChanged: (value) =>
                //       setState(() => extraTimeAllowedForHalfTime = value),
                // ),
                // if (extraTimeAllowedForHalfTime)
                //   _buildStepper(
                //     label: 'Extra Time Duration (Half-Time)',
                //     value: extraTimeDurationForHalfTime,
                //     step: 5,
                //     minValue: 5,
                //     onDecrease: () {
                //       if (extraTimeDurationForHalfTime > 5) {
                //         setState(() => extraTimeDurationForHalfTime -= 5);
                //       }
                //     },
                //     onIncrease: () =>
                //         setState(() => extraTimeDurationForHalfTime += 5),
                //   ),
                // const SizedBox(height: 16),

                // 🏁 Extra Time for Full-Time
                // SwitchListTile(
                //   title: const Text('Allow Extra Time (Full-Time)'),
                //   value: extraTimeAllowedForFullTime,
                //   activeColor: const Color(0xFF2E7D32),
                //   onChanged: (value) =>
                //       setState(() => extraTimeAllowedForFullTime = value),
                // ),
                // if (extraTimeAllowedForFullTime)
                //   _buildStepper(
                //     label: 'Extra Time Duration (Full-Time)',
                //     value: extraTimeDurationForFullTime,
                //     step: 5,
                //     minValue: 5,
                //     onDecrease: () {
                //       if (extraTimeDurationForFullTime > 5) {
                //         setState(() => extraTimeDurationForFullTime -= 5);
                //       }
                //     },
                //     onIncrease: () =>
                //         setState(() => extraTimeDurationForFullTime += 5),
                //   ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF666666))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  "totalDuration": totalDuration,
                  "halfTimeDuration": halfTimeDuration,
                  "extraTimeAllowedForHalfTime": extraTimeAllowedForHalfTime,
                  "extraTimeDurationForHalfTime": extraTimeDurationForHalfTime,
                  "extraTimeAllowedForFullTime": extraTimeAllowedForFullTime,
                  "extraTimeDurationForFullTime": extraTimeDurationForFullTime,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable stepper widget
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
        Uri.parse(
            'http://31.97.206.144:3081/users/gamematches/$matchId/status'),
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
                  Uri.parse(
                      'http://31.97.206.144:3081/users/gamematches/$matchId'),
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
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFE53935))),
          ),
        ],
      ),
    );
  }

  void _viewLiveMatch(MatchData match) {
    print("kkkkkkkkkkkkkkkkkkkkkkk${match.id}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening live match...')),
    );

    if (match.scoringMethod == "Set Based") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SetBasedScreen(
            matchId: match.id.toString(),
          ),
        ),
      );
    } else if (match.scoringMethod == "Goal Based") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorecardScreen(
            matchId: match.id.toString(),
          ),
        ),
      );
    } else if (match.scoringMethod == "Point Based") {
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
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      categoryName: json['categoryId']?['name'] ?? 'Unknown',
      scoringMethod: json['scoringMethod'] ?? '',
      gameMode: json['gameMode'] ?? 'singles',
      players: List<String>.from(json['players'] ?? []),
      teams:
          (json['teams'] as List?)?.map((t) => TeamData.fromJson(t)).toList() ??
              [],
      status: json['status'] ?? 'upcoming',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class TeamData {
  final String teamId;

  TeamData({required this.teamId});

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      teamId: json['teamId'] ?? '',
    );
  }
}
