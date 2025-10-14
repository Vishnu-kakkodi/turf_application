import 'package:booking_application/views/Cricket/services/api_service.dart';
import 'package:booking_application/views/Cricket/services/socket_service.dart';
import 'package:booking_application/views/Cricket/views/innings_break_screen.dart';
import 'package:booking_application/views/Cricket/views/innings_break_selection_screen.dart';
import 'package:flutter/material.dart';
import 'cricket_models.dart';

class LiveMatchScreen extends StatefulWidget {
  final String matchId;

  const LiveMatchScreen({
    super.key,
    required this.matchId,
  });

  @override
  State<LiveMatchScreen> createState() => _LiveMatchScreenState();
}

class _LiveMatchScreenState extends State<LiveMatchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isLoading = true;
  String? errorMessage;

  // Match data
  String currentTeam = "TEAM A";
  int totalRuns = 0;
  int wickets = 0;
  double overs = 0.0;
  double runRate = 0.0;
  String currentBatsman = "Player A1";
  
  String currentBowler = "Player B2";
  String currentBowlerId = "Player B2";
  String nonStriker = "Player A3";
  bool isWaitingForBatsman = false;
  bool isWaitingForBowler = false;
  bool isOver = false;
  int currentInnings = 1;
  bool isTabLoading = false;

  // IDs for API calls
  String? strikerId;
  String? nonStrikerId;
  String? bowlerId;

  // Player lists with IDs
  List<Map<String, String>> teamAPlayers = [];
  List<Map<String, String>> teamBPlayers = [];
  List<Map<String, String>> availableBowlers = [];

  // Match info
  String team1Name = "";
  String team2Name = "";
  String team1Id = "";
  String team2Id = "";
  String matchType = "";
  double maxOvers = 0;
  dynamic target;

  // Sample data for different tabs
  List<String> fallOfWickets = [];
  List<Map<String, dynamic>> thisOverBalls =
      []; // Changed to store ball details
  List<String> commentary = [];

  // MVP and Scorecard data
  List<Map<String, dynamic>> mvpPlayers = [];
  List<Map<String, dynamic>> topPerformers = [];
  List<Map<String, dynamic>> battingScorecard = [];
  List<Map<String, dynamic>> bowlingScorecard = [];

  // Over history data
  List<dynamic> overHistory = [];

  // Track valid balls (excluding extras for over count)
  int validBallsInOver = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
      _tabController.addListener(() {
    if (_tabController.indexIsChanging) {
      _initializeMatch(showTabLoading: true);
    }
  });
    _initializeMatch();
  }

  // Future<void> _initializeMatch() async {
  //   try {
  //     final response = await ApiService.getSingleMatch(widget.matchId);

  //     if (response['success'] == true) {
  //       final match = response['match'];

  //       setState(() {
  //         // Basic match info
  //         team1Name = match['team1']?['teamName'] ?? 'Team 1';
  //         team2Name = match['team2']?['teamName'] ?? 'Team 2';
  //         team1Id = match['team1']?['_id'] ?? '';
  //         team2Id = match['team2']?['_id'] ?? '';
  //         matchType = match['matchType'] ?? 'Friendly';
  //         maxOvers = (match['totalOvers'] ?? 0).toDouble();
  //         target = match['target'];

  //         // Initialize player lists from teams
  //         if (match['team1']?['players'] != null) {
  //           teamAPlayers = List<Map<String, String>>.from(
  //               (match['team1']['players'] as List).map((player) => {
  //                     'id': player['_id'].toString(),
  //                     'name': player['name'].toString(),
  //                   }));
  //         }

  //         if (match['team2']?['players'] != null) {
  //           teamBPlayers = List<Map<String, String>>.from(
  //               (match['team2']['players'] as List).map((player) => {
  //                     'id': player['_id'].toString(),
  //                     'name': player['name'].toString(),
  //                   }));
  //         }

  //         // Live data
  //         final liveData = match['live'] ?? {};
  //         totalRuns = match['runs'] ?? 0;
  //         wickets = match['wickets'] ?? 0;
  //         overs = (liveData['overs'] ?? 0).toDouble();
  //         runRate = (liveData['runRate'] ?? 0).toDouble();
  //         currentInnings = liveData['innings'] ?? 1;

  //         // Set current team based on innings
  //         currentTeam = currentInnings == 1 ? team1Name : team2Name;

  //         // Set available bowlers based on current innings
  //         availableBowlers = currentInnings == 1 ? teamBPlayers : teamAPlayers;

  //         // Players
  //         currentBatsman = match['currentStriker']?['name'] ??
  //             match['opening']?['striker']?['name'] ??
  //             'Waiting...';
  //         strikerId = match['currentStriker']?['_id'] ??
  //             match['opening']?['striker']?['_id'];

  //         nonStriker = match['nonStriker']?['name'] ??
  //             match['opening']?['nonStriker']?['name'] ??
  //             'Waiting...';
  //         nonStrikerId = match['nonStriker']?['_id'] ??
  //             match['opening']?['nonStriker']?['_id'];

  //         currentBowler = match['currentBowler']?['name'] ??
  //             match['bowling']?['bowler']?['name'] ??
  //             'Waiting...';
  //         currentBowlerId = match['currentBowler']?['_id'] ??
  //             match['bowling']?['bowler']?['_id'] ??
  //             'Waiting...';

  //         bowlerId = match['currentBowler']?['_id'] ??
  //             match['bowling']?['bowler']?['_id'];

  //         // Over history
  //         if (liveData['overHistory'] != null) {
  //           overHistory = List.from(liveData['overHistory']);
  //           _updateThisOverFromHistory();
  //         }

  //         // Fall of wickets
  //         if (liveData['fallOfWickets'] != null) {
  //           fallOfWickets = List<String>.from(liveData['fallOfWickets'].map((fow) =>
  //               "${fow['score'] ?? ''}/${fow['wicket'] ?? ''} (${fow['player'] ?? ''}) - ${fow['over'] ?? ''} ov"));
  //         }

  //         // Commentary
  //         if (liveData['commentary'] != null) {
  //           commentary = List<String>.from(liveData['commentary']);
  //         }

  //         // MVP
  //         if (match['mvpLeaderboard'] != null) {
  //           mvpPlayers =
  //               List<Map<String, dynamic>>.from(match['mvpLeaderboard']);
  //         }

  //         if (match['topPerformers'] != null) {
  //           topPerformers =
  //               List<Map<String, dynamic>>.from(match['topPerformers']);
  //         }

  //         // Initialize scorecard
  //         _initializeScorecard();

  //         isLoading = false;
  //       });

  //       String inningsStatus = match['inningStatus'] ?? '';

  //       if (inningsStatus == 'innings break') {
  //         // Navigate to innings break selection screen
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(
  //               builder: (context) => InningsBreakSelectionScreen(
  //                 matchId: widget.matchId,
  //                 battingTeamPlayers:
  //                     teamBPlayers, // Team B bats in 2nd innings
  //                 bowlingTeamPlayers:
  //                     teamAPlayers, // Team A bowls in 2nd innings
  //               ),
  //             ),
  //           );
  //         });
  //         return; // Don't setup socket
  //       }

  //       // Setup Socket.io for live updates (only if not innings break)
  //       _setupSocket();
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = 'Failed to load match: $e';
  //       isLoading = false;
  //     });
  //     print('Error initializing match: $e');
  //   }
  // }

  Future<void> _initializeMatch({bool showTabLoading = false}) async {
    try {
          if (showTabLoading) {
      setState(() {
        isTabLoading = true;
      });
    }
      final response = await ApiService.getSingleMatch(widget.matchId);

      if (response['success'] == true) {
        final match = response['match'];

        setState(() {
          // Basic match info
          team1Name = match['team1']?['teamName'] ?? 'Team 1';
          team2Name = match['team2']?['teamName'] ?? 'Team 2';
          team1Id = match['team1']?['_id'] ?? '';
          team2Id = match['team2']?['_id'] ?? '';
          matchType = match['matchType'] ?? 'Friendly';
          maxOvers = (match['totalOvers'] ?? 0).toDouble();
          target = match['target'];

          // Initialize player lists from teams
          if (match['team1']?['players'] != null) {
            teamAPlayers = List<Map<String, String>>.from(
                (match['team1']['players'] as List).map((player) => {
                      'id': player['_id'].toString(),
                      'name': player['name'].toString(),
                    }));
          }

          if (match['team2']?['players'] != null) {
            teamBPlayers = List<Map<String, String>>.from(
                (match['team2']['players'] as List).map((player) => {
                      'id': player['_id'].toString(),
                      'name': player['name'].toString(),
                    }));
          }

          // Live data
          final liveData = match['liveData'] ?? {};
          totalRuns = match['runs'] ?? 0;
          wickets = match['wickets'] ?? 0;
          overs = (liveData['overs'] ?? 0).toDouble();
          runRate = (liveData['runRate'] ?? 0).toDouble();
          currentInnings = liveData['innings'] ?? 1;

          // Set current team based on innings
          currentTeam = currentInnings == 1 ? team1Name : team2Name;

          // Set available bowlers based on current innings
          availableBowlers = currentInnings == 1 ? teamBPlayers : teamAPlayers;

          // Players
          currentBatsman = match['currentStriker']?['name'] ??
              match['opening']?['striker']?['name'] ??
              'Waiting...';
          strikerId = match['currentStriker']?['_id'] ??
              match['opening']?['striker']?['_id'];

          nonStriker = match['nonStriker']?['name'] ??
              match['opening']?['nonStriker']?['name'] ??
              'Waiting...';
          nonStrikerId = match['nonStriker']?['_id'] ??
              match['opening']?['nonStriker']?['_id'];

          currentBowler = match['currentBowler']?['name'] ??
              match['bowling']?['bowler']?['name'] ??
              'Waiting...';
          currentBowlerId = match['currentBowler']?['_id'] ??
              match['bowling']?['bowler']?['_id'] ??
              'Waiting...';

          bowlerId = match['currentBowler']?['_id'] ??
              match['bowling']?['bowler']?['_id'];

          // Over history
          if (liveData['overHistory'] != null) {
            overHistory = List.from(liveData['overHistory']);
            _updateThisOverFromHistory();
          }

          // Fall of wickets
          if (liveData['fallOfWickets'] != null) {
            fallOfWickets = List<String>.from(liveData['fallOfWickets'].map((fow) =>
                "${fow['score'] ?? ''}/${fow['wicket'] ?? ''} (${fow['player'] ?? ''}) - ${fow['over'] ?? ''} ov"));
          }

          // Commentary
          if (liveData['commentary'] != null) {
            commentary = List<String>.from(liveData['commentary']);
          }

          // MVP
          if (match['mvpLeaderboard'] != null) {
            mvpPlayers =
                List<Map<String, dynamic>>.from(match['mvpLeaderboard']);
          }

          if (match['topPerformers'] != null) {
            topPerformers =
                List<Map<String, dynamic>>.from(match['topPerformers']);
          }

          // Initialize scorecard from API response
          if (match['scorecard'] != null &&
              match['scorecard']['innings'] != null &&
              match['scorecard']['innings'].isNotEmpty) {
            // Get current innings data
            var currentInningsData = match['scorecard']['innings'].firstWhere(
              (inning) => inning['inningsNumber'] == currentInnings,
              orElse: () => null,
            );

            if (currentInningsData != null) {
              // Populate batting scorecard
              if (currentInningsData['batting'] != null) {
                battingScorecard = List<Map<String, dynamic>>.from(
                    (currentInningsData['batting'] as List).map((batsman) => {
                          'id': batsman['playerId'],
                          'name': batsman['playerName'] ?? 'Unknown',
                          'runs': batsman['runs'] ?? 0,
                          'balls': batsman['balls'] ?? 0,
                          'fours': batsman['fours'] ?? 0,
                          'sixes': batsman['sixes'] ?? 0,
                          'sr': batsman['strikeRate'] ?? 0.0,
                          'status': batsman['isNotOut'] == true
                              ? 'Not out'
                              : (batsman['dismissal'] ?? 'Out'),
                        }));
              }

              // Populate bowling scorecard
              if (currentInningsData['bowling'] != null) {
                bowlingScorecard = List<Map<String, dynamic>>.from(
                    (currentInningsData['bowling'] as List).map((bowler) => {
                          'name': bowler['playerName'] ?? 'Unknown',
                          'overs': (bowler['overs'] ?? 0.0).toDouble(),
                          'maidens': bowler['maidens'] ?? 0,
                          'runs': bowler['runsConceded'] ?? 0,
                          'wickets': bowler['wickets'] ?? 0,
                          'wides': bowler['wides'] ?? 0,
                          'noballs': bowler['noBalls'] ?? 0,
                          'econ': (bowler['economy'] ?? 0.0).toDouble(),
                        }));
              }
            }
          }

          // If no scorecard data, initialize with empty or current players
          if (battingScorecard.isEmpty) {
            _initializeScorecard();
          }

          isLoading = false;
        });

                if (showTabLoading) {
          isTabLoading = false;
        } else {
          isLoading = false;
        }
  

        String inningsStatus = match['inningStatus'] ?? '';

        if (inningsStatus == 'innings break') {
          // Navigate to innings break selection screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => InningsBreakSelectionScreen(
                  matchId: widget.matchId,
                  battingTeamPlayers:
                      teamBPlayers, // Team B bats in 2nd innings
                  bowlingTeamPlayers:
                      teamAPlayers, // Team A bowls in 2nd innings
                ),
              ),
            );
          });
          return; // Don't setup socket
        }

        // Setup Socket.io for live updates (only if not innings break)
        // _setupSocket();
             if (!showTabLoading) {
        _setupSocket();
      }
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load match: $e';
              if (showTabLoading) {
        isTabLoading = false;
      } else {
        isLoading = false;
      }
      });
      print('Error initializing match: $e');
    }
  }

  void _setupSocket() {
    SocketService.onMatchUpdate = (data) {
      if (mounted) {
        _handleSocketUpdate(data);
      }
    };
    SocketService.connect(widget.matchId);
  }

  void _handleSocketUpdate(Map<String, dynamic> data) {
    if (data['matchId'] == widget.matchId) {
      final liveData = data['liveData'];

      setState(() {
        totalRuns = data['runs'] ?? totalRuns;
        wickets = data['wickets'] ?? wickets;
        overs = (liveData['overs'] ?? overs).toDouble();
        runRate = (liveData['runRate'] ?? runRate).toDouble();
        currentInnings = liveData['innings'] ?? currentInnings;

        // Update current team and available bowlers
        currentTeam = currentInnings == 1 ? team1Name : team2Name;
        availableBowlers = currentInnings == 1 ? teamBPlayers : teamAPlayers;

        // Update players
        if (data['currentStriker'] != null) {
          currentBatsman = data['currentStriker']['name'];

          strikerId = data['currentStriker']['_id'];
        }
        if (data['nonStriker'] != null) {
          nonStriker = data['nonStriker']['name'];
          nonStrikerId = data['nonStriker']['_id'];
        }
        if (data['currentBowler'] != null) {
          currentBowler = data['currentBowler']['name'];
          bowlerId = data['currentBowler']['_id'];
        }

        // Update over history
        if (liveData['overHistory'] != null) {
          overHistory = List.from(liveData['overHistory']);
          _updateThisOverFromHistory();
        }

        // Update fall of wickets
        if (liveData['fallOfWickets'] != null) {
          fallOfWickets = List<String>.from(liveData['fallOfWickets'].map((fow) =>
              "${fow['score'] ?? ''}/${fow['wicket'] ?? ''} (${fow['player'] ?? ''}) - ${fow['over'] ?? ''} ov"));
        }

        // Update commentary
        if (liveData['commentary'] != null) {
          commentary = List<String>.from(liveData['commentary']);
        }

        // Update MVP
        if (data['mvpLeaderboard'] != null) {
          mvpPlayers = List<Map<String, dynamic>>.from(data['mvpLeaderboard']);
        }

        if (data['topPerformers'] != null) {
          topPerformers =
              List<Map<String, dynamic>>.from(data['topPerformers']);
        }
      });

      if (data['scorecard'] != null &&
          data['scorecard']['innings'] != null &&
          data['scorecard']['innings'].isNotEmpty) {
        var currentInningsData = data['scorecard']['innings'].firstWhere(
          (inning) => inning['inningsNumber'] == currentInnings,
          orElse: () => null,
        );

        if (currentInningsData != null) {
          // Update batting scorecard
          if (currentInningsData['batting'] != null) {
            battingScorecard = List<Map<String, dynamic>>.from(
                (currentInningsData['batting'] as List).map((batsman) => {
                      'id': batsman['playerId'],
                      'name': batsman['playerName'] ?? 'Unknown',
                      'runs': batsman['runs'] ?? 0,
                      'balls': batsman['balls'] ?? 0,
                      'fours': batsman['fours'] ?? 0,
                      'sixes': batsman['sixes'] ?? 0,
                      'sr': batsman['strikeRate'] ?? 0.0,
                      'status': batsman['isNotOut'] == true
                          ? 'Not out'
                          : (batsman['dismissal'] ?? 'Out'),
                    }));
          }

          // Update bowling scorecard
          if (currentInningsData['bowling'] != null) {
            bowlingScorecard = List<Map<String, dynamic>>.from(
                (currentInningsData['bowling'] as List).map((bowler) => {
                      'name': bowler['playerName'] ?? 'Unknown',
                      'overs': (bowler['overs'] ?? 0.0).toDouble(),
                      'maidens': bowler['maidens'] ?? 0,
                      'runs': bowler['runsConceded'] ?? 0,
                      'wickets': bowler['wickets'] ?? 0,
                      'wides': bowler['wides'] ?? 0,
                      'noballs': bowler['noBalls'] ?? 0,
                      'econ': (bowler['economy'] ?? 0.0).toDouble(),
                    }));
          }
        }
      }
    }
  }

  void _updateThisOverFromHistory() {
    if (overHistory.isEmpty) {
      thisOverBalls = [];
      validBallsInOver = 0;
      return;
    }

    // Get current over number
    int currentOverNumber = overs.floor() + 1;

    // Find the current over in history
    var currentOverData = overHistory.firstWhere(
      (over) => over['overNumber'] == currentOverNumber,
      orElse: () => null,
    );

    if (currentOverData != null && currentOverData['balls'] != null) {
      List<dynamic> balls = currentOverData['balls'];

      // Reset thisOverBalls and valid ball count
      thisOverBalls = [];
      validBallsInOver = 0;

      // Update with actual ball data
      for (int i = 0; i < balls.length; i++) {
        var ball = balls[i];
        String ballDisplay = ".";
        bool isExtra = false;

        if (ball['wicket'] == true) {
          ballDisplay = "W";
        } else if (ball['extraType'] == 'wide') {
          ballDisplay = "Wd";
          isExtra = true;
        } else if (ball['extraType'] == 'noball') {
          ballDisplay = "Nb";
          isExtra = true;
        } else {
          int runs = ball['runs'] ?? 0;
          ballDisplay = runs.toString();
        }

        // Only count non-extra balls for over progression
        if (!isExtra) {
          validBallsInOver++;
        }

        thisOverBalls.add({
          'display': ballDisplay,
          'isExtra': isExtra,
          'runs': ball['runs'] ?? 0,
          'isWicket': ball['wicket'] == true,
        });
      }
    } else {
      thisOverBalls = [];
      validBallsInOver = 0;
    }
  }

  void _initializeScorecard() {
    battingScorecard = [];
    bowlingScorecard = [];
  }

  @override
  void dispose() {
    _tabController.dispose();
    SocketService.disconnect();
    super.dispose();
  }

  Future<void> _showInningsBreakFlow() async {
    // Step 1: Show innings break information modal
    final startInnings = await _showInningsBreakInfoModal();

    if (startInnings != true) return;

    // Step 2: Select opening batsmen
    final batsmenResult = await CricketModals.showOpeningBatsmenModal(
      context,
      availableBatsmen: teamBPlayers, // Second innings batting team
    );

    if (batsmenResult == null) return;

    // Step 3: Select opening bowler
    final bowlerResult = await CricketModals.showBowlerSelectionModal(
      context,
      availablePlayers: teamAPlayers, // Second innings bowling team
    );

    if (bowlerResult == null) return;

    // Step 4: Start second innings with all details
    await _startSecondInningsWithDetails(
      strikerId: batsmenResult['strikerId']!,
      nonStrikerId: batsmenResult['nonStrikerId']!,
      bowlerId: bowlerResult['id']!,
    );
  }

  Future<bool?> _showInningsBreakInfoModal() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A3441),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.sports_cricket,
                  size: 60,
                  color: Color(0xFF00BCD4),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Innings Break',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00BCD4),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'First innings completed.\nReady to start the second innings?',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8A9BA8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF8A9BA8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Start Second Innings',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _startSecondInningsWithDetails({
    required String strikerId,
    required String nonStrikerId,
    required String bowlerId,
  }) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xFF1976D2)),
        ),
      );

      Map<String, dynamic> payload = {
        "innings": 2,
        "inningStatus": "second innings",
        "runs": 0,
        "wickets": 0,
        "ballUpdate": false,
        "striker": strikerId,
        "nonStriker": nonStrikerId,
        "bowler": bowlerId,
      };

      await ApiService.updateMatch(widget.matchId, payload);

      // Close loading dialog
      Navigator.of(context).pop();

      // Reload the match to show second innings
      setState(() {
        isLoading = true;
      });
      await _initializeMatch();
      _setupSocket();

      _showSnackBar('Second innings started!');
    } catch (e) {
      Navigator.of(context).pop();
      _showSnackBar('Failed to start second innings: $e');
    }
  }

  // API update methods
  Future<void> _updateScore(
      int runs, bool ballUpdate, bool isExtra, String? type) async {
    try {
      int? currentRun = 1;
      if (isExtra) {
        currentRun = 0;
      } else {
        currentRun = runs;
      }

      Map<String, dynamic> payload = {
        "runs": currentRun,
        "striker": strikerId,
        "nonStriker": nonStrikerId,
        "bowler": bowlerId,
        "ballUpdate": true,
        "innings": currentInnings,
      };

      if (isExtra) {
        payload["extraType"] = type;
      }

      await ApiService.updateMatch(widget.matchId, payload);

      setState(() {
        _updateOvers();

        if (ballUpdate && !isExtra) {
          totalRuns += runs;
        }
        _updateThisOver(currentRun.toString(),
            isExtra: isExtra, isWicket: false);

        // Swap batsmen if odd runs (only for valid balls, not extras)
        if (runs % 2 == 1 && !isExtra) {
          String temp = currentBatsman;
          String? tempId = strikerId;
          currentBatsman = nonStriker;
          strikerId = nonStrikerId;
          nonStriker = temp;
          nonStrikerId = tempId;
        }

        if (overs > 0) {
          runRate = totalRuns / overs;
        }
      });

      if (target != 0 && totalRuns > target) {
        await _handleInningsEnd();
        return;
      }

      _showSnackBar('$runs run${runs == 1 ? '' : 's'} added');
    } catch (e) {
      _showSnackBar('Failed to update score: $e');
      print('Error updating score: $e');
    }
  }

  // Future<void> _updateExtra(String extraType, String bowlerId) async {
  //   try {
  //      final int? currentRun = await CricketModals.showRunSelectionModal(context);
  //      print("hhhhhhhhhhhhhhhhhhhhhhhhhh$currentRun");
  //     await ApiService.updateMatch(widget.matchId, {
  //       "extraType": extraType,
  //       "runs": currentRun,
  //       "ballUpdate": true,
  //       "innings": currentInnings,
  //       "bowler": bowlerId
  //     });

  //     setState(() {
  //       totalRuns += currentRun!;
  //       // Add extra ball to this over display (don't increment valid ball count)
  //       _updateThisOver(extraType == 'wide' ? 'Wd' : 'Nb',
  //           isExtra: true, isWicket: false);
  //     });

  //     _showSnackBar('${extraType.toUpperCase()} added');
  //   } catch (e) {
  //     _showSnackBar('Failed to update extra: $e');
  //     print('Error updating extra: $e');
  //   }
  // }

  Future<void> _updateExtra(String extraType, String bowlerId) async {
    try {
      int baseRuns = 0;
      bool ballUpdate = true; // for legal delivery types

      // Ask for runs only when relevant
      int? currentRun;

      if (extraType == 'wide' || extraType == 'noBall') {
        // Base +1 run for wide/no-ball
        baseRuns = 0;
        ballUpdate = false;

        // Optionally ask if additional runs happened (e.g., wide +2 runs)
        currentRun = await CricketModals.showRunSelectionModal(context);
        currentRun ??= 0; // Default to 0 if user cancels
      } else {
        // For bye or leg-bye, user must choose number of runs taken
        currentRun = await CricketModals.showRunSelectionModal(context);
        currentRun ??= 0;
      }

      final int totalExtraRuns = baseRuns + currentRun;

      // Update backend
      await ApiService.updateMatch(widget.matchId, {
        "extraType": extraType,
        "runs": totalExtraRuns,
        "ballUpdate": true,
        "bowler": bowlerId
      });

      // Update UI safely
      setState(() {
        totalRuns += totalExtraRuns + 1;

        // Update over display
        String display = extraType == 'wide' ? 'Wd' : 'Nb';
        _updateThisOver(display, isExtra: true, isWicket: false);
      });

      _showSnackBar('${extraType.toUpperCase()} added (+$totalExtraRuns)');
    } catch (e) {
      _showSnackBar('Failed to update extra: $e');
      print('Error updating extra: $e');
    }
  }

  Future<void> _updateWicket(String dismissedPlayerId, String wicketType,
      String? fielderId, int runsOnDelivery) async {
    try {
      Map<String, dynamic> payload = {
        "wickets": 1,
        // "fallOfWicket": {
        //   "player": dismissedPlayerId,
        //   "type": wicketType,
        //   "runOnDelivery": runsOnDelivery,
        // },
        "ballUpdate": true, // Wicket counts as a valid ball
        "innings": currentInnings,
        "runs": runsOnDelivery,
        "striker": strikerId,
        "nonStriker": nonStrikerId,
        "bowler": bowlerId,
        "dismissalType": "out"
      };

      // if (fielderId != null) {
      //   payload["fallOfWicket"]["fielder"] = fielderId;
      // }

      await ApiService.updateMatch(widget.matchId, payload);

      setState(() {
        wickets++;
        totalRuns += runsOnDelivery;
        _updateOvers();
        _updateThisOver('W', isExtra: false, isWicket: true);
      });

      // Check if all out
      if (wickets >= 10) {
        _handleInningsEnd();
      } else {
        print("kkkkkkkkkkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjj");
        // Show next batsman modal
        // Future.delayed(const Duration(milliseconds: 500), () {
        await _selectNextBatsman(dismissedPlayerId);
        // });
      }

      _showSnackBar('Wicket added');
    } catch (e) {
      _showSnackBar('Failed to update wicket: $e');
      print('Error updating wicket: $e');
    }
  }

  Future<void> _changeBowler(String newBowlerId) async {
    try {
      await ApiService.updateMatch(widget.matchId, {
        "bowler": newBowlerId,
        "changeBowler": true,
      });

      setState(() {
        isWaitingForBowler = false;
        isOver = false;
        // Clear this over display when new bowler starts
        thisOverBalls = [];
        validBallsInOver = 0;
      });

      _showSnackBar('Bowler changed');
    } catch (e) {
      _showSnackBar('Failed to change bowler: $e');
      print('Error changing bowler: $e');
    }
  }

  Future<void> _swapBatsmen() async {
    try {
      print("kkkkkkkkkkkkkkkkkkkkk$nonStrikerId");
      print("kkkkkkkkkkkkkkkkkkkkk$strikerId");

      await ApiService.updateMatch(widget.matchId, {
        // "striker": nonStrikerId,
        // "nonStriker": strikerId,
        // "innings": currentInnings,
        "swapStriker": true
      });

      setState(() {
        String temp = currentBatsman;
        String? tempId = strikerId;
        currentBatsman = nonStriker;
        strikerId = nonStrikerId;
        nonStriker = temp;
        nonStrikerId = tempId;
      });

      _showSnackBar('Batsmen swapped');
    } catch (e) {
      _showSnackBar('Failed to swap batsmen: $e');
      print('Error swapping batsmen: $e');
    }
  }

  Future<void> _changeStriker(String newStrikerId, String outPlayerId) async {
    try {
      await ApiService.updateMatch(widget.matchId, {
        "striker": outPlayerId,
        "newBatsman": newStrikerId,
        "innings": currentInnings,
      });

      setState(() {
        isWaitingForBatsman = false;
      });

      _showSnackBar('New batsman added');
    } catch (e) {
      _showSnackBar('Failed to change striker: $e');
      print('Error changing striker: $e');
    }
  }

  Future<void> _undoLastBall() async {
    try {
      await ApiService.updateMatch(widget.matchId, {
        "undoLastBall": true,
        "innings": currentInnings,
      });

      // Also update local state
      if (thisOverBalls.isNotEmpty) {
        setState(() {
          var lastBall = thisOverBalls.removeLast();
          // Adjust valid ball count if it wasn't an extra
          if (!lastBall['isExtra']) {
            validBallsInOver--;
          }
          // Adjust runs if needed
          // totalRuns -= lastBall['runs'];
          // Recalculate run rate
          if (overs > 0) {
            runRate = totalRuns / overs;
          }
        });
      }

      _showSnackBar('Last ball undone');
    } catch (e) {
      _showSnackBar('Failed to undo: $e');
      print('Error undoing: $e');
    }
  }

  Future<void> _startSecondInnings() async {
    try {
      // Use the innings change payload structure
      Map<String, dynamic> payload = {
        "innings": 2,
        "runs": 0,
        "wickets": 0,
        "ballUpdate": false,
        "striker": teamBPlayers.isNotEmpty ? teamBPlayers[0]['id'] : "",
        "nonStriker": teamBPlayers.length > 1 ? teamBPlayers[1]['id'] : "",
        "bowler": teamAPlayers.isNotEmpty ? teamAPlayers[0]['id'] : "",
      };

      await ApiService.updateMatch(widget.matchId, payload);

      setState(() {
        currentInnings = 2;
        currentTeam = team2Name;
        totalRuns = 0;
        wickets = 0;
        overs = 0.0;
        runRate = 0.0;
        thisOverBalls = [];
        validBallsInOver = 0;
        overHistory = [];
        availableBowlers = teamAPlayers; // Now team A will bowl

        // Set new batsmen and bowler for second innings
        if (teamBPlayers.isNotEmpty) {
          currentBatsman = teamBPlayers[0]['name']!;
          strikerId = teamBPlayers[0]['id'];
        }
        if (teamBPlayers.length > 1) {
          nonStriker = teamBPlayers[1]['name']!;
          nonStrikerId = teamBPlayers[1]['id'];
        }
        if (teamAPlayers.isNotEmpty) {
          currentBowler = teamAPlayers[0]['name']!;
          bowlerId = teamAPlayers[0]['id'];
        }
      });

      _showSnackBar('Second innings started');
    } catch (e) {
      _showSnackBar('Failed to start second innings: $e');
      print('Error starting second innings: $e');
    }
  }

  Future<void> _startInningsBreak() async {
    try {
      // Use the innings change payload structure
      Map<String, dynamic> payload = {
        "inningStatus": "innings break",
      };

      await ApiService.updateMatch(widget.matchId, payload);

      setState(() {
        currentInnings = 2;
        currentTeam = team2Name;
        totalRuns = 0;
        wickets = 0;
        overs = 0.0;
        runRate = 0.0;
        thisOverBalls = [];
        validBallsInOver = 0;
        overHistory = [];
        availableBowlers = teamAPlayers; // Now team A will bowl

        // Set new batsmen and bowler for second innings
        if (teamBPlayers.isNotEmpty) {
          currentBatsman = teamBPlayers[0]['name']!;
          strikerId = teamBPlayers[0]['id'];
        }
        if (teamBPlayers.length > 1) {
          nonStriker = teamBPlayers[1]['name']!;
          nonStrikerId = teamBPlayers[1]['id'];
        }
        if (teamAPlayers.isNotEmpty) {
          currentBowler = teamAPlayers[0]['name']!;
          bowlerId = teamAPlayers[0]['id'];
        }
      });

      _showSnackBar('Second innings started');
    } catch (e) {
      _showSnackBar('Failed to start second innings: $e');
      print('Error starting second innings: $e');
    }
  }

  // Modal integration methods
  Future<void> _selectBowler() async {
    if (availableBowlers.isEmpty) {
      _showSnackBar('No bowlers available. Please configure team players.');
      return;
    }

    final result = await CricketModals.showBowlerSelectionModal(
      context,
      availablePlayers: availableBowlers,
    );

    if (result != null && result['name'] != null) {
      String selectedBowlerName = result['name']!;
      String? selectedBowlerId = result['id'];

      if (selectedBowlerId != null && selectedBowlerId.isNotEmpty) {
        setState(() {
          currentBowler = selectedBowlerName;
          bowlerId = selectedBowlerId;
        });

        await _changeBowler(selectedBowlerId);
      }
    }
  }

  Future<void> _handleWicket() async {
    Map<String, String> dismissedPlayer = {
      'id': strikerId!,
      'name': currentBatsman,
    };

    final wicketResult = await CricketModals.showWicketModal(
      context,
      dismissedPlayer: dismissedPlayer,
      fielders: availableBowlers,
    );

    if (wicketResult != null) {
      String dismissedPlayerId = wicketResult['dismissedPlayerId'];
      String? fielderId = wicketResult['fielderId'];

      await _updateWicket(dismissedPlayerId, wicketResult['type'], fielderId,
          int.parse(wicketResult['runs']));
    }
  }

//   Future<void> _selectNextBatsman(String outPlayerId) async {
//     List<Map<String, String>> battingTeamPlayers = currentInnings == 1 ? teamAPlayers : teamBPlayers;

//     List<Map<String, String>> availableBatsmenMap = battingTeamPlayers
//         .where((player) =>
//             player['id'] != strikerId &&
//             player['id'] != nonStrikerId &&
//             !battingScorecard.any((b) =>
//               b['name'] == player['name'] &&
//               b['status'].toString().toLowerCase().contains('out')
//             ))
//         .toList();

//     if (availableBatsmenMap.isEmpty) {
//       _showSnackBar('No batsmen available');
//       return;
//     }

// List<String> availableBatsmenNames = availableBatsmenMap
//     .where((b) =>
//         !(b['status']!.toLowerCase().startsWith("out"))) // exclude outs
//     .map((b) => b['name']!)
//     .toList();

//     final nextBatsmanName = await CricketModals.showNextBatsmanModal(
//       context,
//       availableBatsmen: availableBatsmenNames,
//     );

//     if (nextBatsmanName != null) {
//       String? nextBatsmanId = availableBatsmenMap
//           .firstWhere(
//             (b) => b['name'] == nextBatsmanName,
//             orElse: () => {'id': '', 'name': ''}
//           )['id'];

//       if (nextBatsmanId != null && nextBatsmanId.isNotEmpty) {
//         setState(() {
//           if (strikerId == outPlayerId) {
//             currentBatsman = nextBatsmanName;
//             strikerId = nextBatsmanId;
//           } else {
//             nonStriker = nextBatsmanName;
//             nonStrikerId = nextBatsmanId;
//           }
//         });

//         await _changeStriker(nextBatsmanId, outPlayerId);
//       }
//     }
//   }

  // Future<void> _selectNextBatsman(String outPlayerId) async {
  //   List<Map<String, String>> battingTeamPlayers =
  //       currentInnings == 1 ? teamAPlayers : teamBPlayers;

  //   List<Map<String, String>> availableBatsmenMap = battingTeamPlayers
  //       .where((player) =>
  //           player['id'] != strikerId &&
  //           player['id'] != nonStrikerId &&
  //           !battingScorecard.any((b) =>
  //               b['id'] == player['id'] &&
  //               b['status'].toString().toLowerCase().contains('out')))
  //       .toList();

  //   if (availableBatsmenMap.isEmpty) {
  //     _showSnackBar('No batsmen available');
  //     return;
  //   }

  //   final nextBatsman = await CricketModals.showNextBatsmanModal(
  //     context,
  //     availableBatsmen: availableBatsmenMap,
  //   );

  //   if (nextBatsman != null) {
  //     String nextBatsmanId = nextBatsman['id']!;
  //     String nextBatsmanName = nextBatsman['name']!;

  //     setState(() {
  //       if (strikerId == outPlayerId) {
  //         currentBatsman = nextBatsmanName;
  //         strikerId = nextBatsmanId;
  //       } else {
  //         nonStriker = nextBatsmanName;
  //         nonStrikerId = nextBatsmanId;
  //       }
  //     });

  //     await _changeStriker(nextBatsmanId, outPlayerId);
  //   }
  // }

  Future<void> _selectNextBatsman(String outPlayerId) async {
    List<Map<String, String>> battingTeamPlayers =
        currentInnings == 1 ? teamAPlayers : teamBPlayers;

    // 🟢 Print all batting team players
    print('--- Batting Team Players ---');
    for (var player in battingTeamPlayers) {
      print('Player: ${player['name']} | ID: ${player['id']}');
    }

    List<Map<String, String>> availableBatsmenMap = battingTeamPlayers
        .where((player) =>
            player['id'] != strikerId &&
            player['id'] != nonStrikerId &&
            !battingScorecard.any((b) =>
                b['id'] == player['id'] &&
                b['status'].toString().toLowerCase().contains('out')))
        .toList();

    // 🟡 Print available batsmen
    print('--- Available Batsmen ---');
    if (availableBatsmenMap.isEmpty) {
      print('No available batsmen.');
    } else {
      for (var player in availableBatsmenMap) {
        print('Available: ${player['name']} | ID: ${player['id']}');
      }
    }

    if (availableBatsmenMap.isEmpty) {
      _showSnackBar('No batsmen available');
      return;
    }

    final nextBatsman = await CricketModals.showNextBatsmanModal(
      context,
      availableBatsmen: availableBatsmenMap,
    );

    if (nextBatsman != null) {
      String nextBatsmanId = nextBatsman['id']!;
      String nextBatsmanName = nextBatsman['name']!;

      setState(() {
        if (strikerId == outPlayerId) {
          currentBatsman = nextBatsmanName;
          strikerId = nextBatsmanId;
        } else {
          nonStriker = nextBatsmanName;
          nonStrikerId = nextBatsmanId;
        }
      });

      await _changeStriker(nextBatsmanId, outPlayerId);
    }
  }

  // Future<void> _handleInningsEnd() async {
  //   if (currentInnings == 1) {
  //     await CricketModals.showInningsBreakModal(
  //       context,
  //       chasingTeam: team2Name,
  //       targetRuns: totalRuns + 1,
  //       targetOvers: maxOvers,
  //     );

  //     await _startInningsBreak();

  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InningsBreakScreen(matchId: widget.matchId)));

  //     // await _startSecondInnings();
  //   } else {
  //     _handleMatchEnd();
  //   }
  // }

  Future<void> _handleInningsEnd() async {
    if (currentInnings == 1) {
      // Update innings status to "innings break"
      await ApiService.updateMatch(widget.matchId, {
        "inningStatus": "innings break",
      });

      // Navigate to Innings Break Selection Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => InningsBreakSelectionScreen(
            matchId: widget.matchId,
            battingTeamPlayers: teamBPlayers, // Team B bats in 2nd innings
            bowlingTeamPlayers: teamAPlayers, // Team A bowls in 2nd innings
          ),
        ),
      );
    } else {
      // Second innings completed
      await ApiService.updateMatch(widget.matchId, {
        "inningStatus": "completed",
        "matchStatus": "completed",
      });

      _handleMatchEnd();
    }
  }

  Future<void> _handleMatchEnd() async {
    await CricketModals.showMatchOverModal(
      context,
      result: "Match completed successfully!",
      winningTeam: team1Name,
      margin: "5 runs",
    );

    Navigator.of(context).pop();
  }

  void _updateOvers() {
    // Only count valid balls (non-extras)
    validBallsInOver++;

    if (validBallsInOver >= 6) {
      // Over completed
      overs = overs.floor() + 1.0;
      validBallsInOver = 0;

      setState(() {
        isOver = true;
        isWaitingForBowler = true;
      });

      if (overs >= maxOvers) {
        _handleInningsEnd();
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          _selectBowler();
        });
      }
    } else {
      // Update overs display (e.g., 4.2 means 4 overs and 2 balls)
      overs = overs.floor() + (validBallsInOver / 10);
    }
  }

  void _updateThisOver(String ball,
      {required bool isExtra, required bool isWicket}) {
    setState(() {
      thisOverBalls.add({
        'display': ball,
        'isExtra': isExtra,
        'runs': isWicket ? 0 : int.tryParse(ball) ?? 0,
        'isWicket': isWicket,
      });
    });
  }

  void _handleScoring(String score, String bowlerId) {
    switch (score) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '6':
        int runs = int.parse(score);
        _updateScore(
            runs, true, false, "run"); // Valid ball, counts toward over
        break;

      case 'Wide':
        _updateExtra('wide', bowlerId);
        break;

      case 'No Ball':
        _updateExtra('noball', bowlerId);
        break;

      case 'Wicket':
        _handleWicket();
        break;

      case 'Bye':
        _updateScore(1, true, true, "bye"); // Valid ball
        break;
      case 'Leg Bye':
        _updateScore(1, true, true, "legbye"); // Valid ball
        break;

      case 'Undo':
        _undoLastBall();
        break;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1976D2),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 800),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Color(0xFF1976D2),
              ),
              SizedBox(height: 16),
              Text(
                'Loading match...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                errorMessage!,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    errorMessage = null;
                  });
                  _initializeMatch();
                },
                child: Text('Retry'),
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    '$matchType Match',
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 400 ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1976D2),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$team1Name vs $team2Name',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$currentTeam INNINGS',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '$totalRuns',
                                      style: const TextStyle(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF212121),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '/$wickets',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const Text(
                              'Overs',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            FittedBox(
                              child: Text(
                                overs.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF212121),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const Text(
                              'Run Rate',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            FittedBox(
                              child: Text(
                                runRate.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF212121),
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
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Live'),
                  Tab(text: 'Scorecard'),
                  Tab(text: 'Commentary'),
                  Tab(text: 'MVP'),
                ],
                indicatorColor: const Color(0xFF1976D2),
                labelColor: const Color(0xFF1976D2),
                unselectedLabelColor: const Color(0xFF666666),
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                isScrollable: false,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLiveTab(),
                  _buildScorecardTab(),
                  _buildCommentaryTab(),
                  _buildMVPTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveTab() {
      if (isTabLoading) {
    return _buildTabLoadingIndicator();
  }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (MediaQuery.of(context).size.width < 600)
            _buildMobileLiveLayout()
          else
            _buildTabletLiveLayout(),
        ],
      ),
    );
  }

  Widget _buildMobileLiveLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                title: 'ON CREASE',
                content: isWaitingForBatsman
                    ? 'Waiting for batsmen...'
                    : '$currentBatsman* / $nonStriker',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                title: 'CURRENT BOWLER',
                content: isWaitingForBowler
                    ? 'Waiting for bowler...'
                    : currentBowler,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildThisOverCard(),
        const SizedBox(height: 16),

        _buildScoringGrid(),
        const SizedBox(height: 16),

        // _buildFallOfWicketsCard(),
        // const SizedBox(height: 16),

        _buildQuickActionsCard(),
      ],
    );
  }

  Widget _buildTabletLiveLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildInfoCard(
                title: 'ON CREASE',
                content: isWaitingForBatsman
                    ? 'Waiting for batsmen...'
                    : '$currentBatsman* / $nonStriker',
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                title: 'CURRENT BOWLER',
                content: isWaitingForBowler
                    ? 'Waiting for bowler...'
                    : currentBowler,
              ),
              const SizedBox(height: 16),
              _buildFallOfWicketsCard(),
              const SizedBox(height: 16),
              _buildQuickActionsCard(),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              _buildThisOverCard(),
              const SizedBox(height: 16),
              _buildScoringGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'QUICK ACTIONS',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _selectBowler,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: const Color(0xFF212121),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    disabledBackgroundColor: const Color(0xFFE0E0E0),
                    disabledForegroundColor: const Color(0xFF9E9E9E),
                  ),
                  child: Text(isOver ? 'Change Bowler' : 'Change Bowler'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _swapBatsmen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: const Color(0xFF212121),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  child: const Text('Swap Strike'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThisOverCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THIS OVER',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          thisOverBalls.isEmpty
              ? const Center(
                  child: Text(
                    'No balls bowled yet',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: thisOverBalls.map((ball) {
                    Color bgColor = const Color(0xFFF5F5F5);
                    Color borderColor = const Color(0xFFE0E0E0);
                    Color textColor = const Color(0xFF666666);

                    String display = ball['display'];
                    bool isExtra = ball['isExtra'];

                    if (display != ".") {
                      if (display == "W") {
                        bgColor = const Color(0xFFFFEBEE);
                        borderColor = const Color(0xFFD32F2F);
                        textColor = const Color(0xFFD32F2F);
                      } else if (display == "Wd" || display == "Nb") {
                        bgColor = const Color(0xFFFFF3E0);
                        borderColor = const Color(0xFFFF9800);
                        textColor = const Color(0xFFFF9800);
                      } else {
                        bgColor = const Color(0xFFE3F2FD);
                        borderColor = const Color(0xFF1976D2);
                        textColor = const Color(0xFF1976D2);
                      }
                    }

                    return Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          display,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildScoringGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.2,
      children: [
        _buildScoreButton('0', const Color(0xFFF5F5F5), bowlerId.toString()),
        _buildScoreButton('1', const Color(0xFFF5F5F5), bowlerId.toString()),
        _buildScoreButton('2', const Color(0xFFF5F5F5), bowlerId.toString()),
        _buildScoreButton('3', const Color(0xFFF5F5F5), bowlerId.toString()),
        _buildScoreButton('4', const Color(0xFF1976D2), bowlerId.toString()),
        _buildScoreButton('6', const Color(0xFF388E3C), bowlerId.toString()),
        _buildScoreButton('Wide', const Color(0xFFFF9800), bowlerId.toString()),
        _buildScoreButton(
            'No Ball', const Color(0xFFFF9800), bowlerId.toString()),
        _buildScoreButton('Bye', const Color(0xFFF5F5F5), bowlerId.toString()),
        _buildScoreButton(
            'Leg Bye', const Color(0xFFF5F5F5), bowlerId.toString()),
        _buildScoreButton(
            'Wicket', const Color(0xFFD32F2F), bowlerId.toString()),
        _buildScoreButton('Undo', const Color(0xFFFF7043), bowlerId.toString()),
      ],
    );
  }

  Widget _buildFallOfWicketsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FALL OF WICKETS',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          if (fallOfWickets.isEmpty)
            const Text(
              'No wickets fallen yet',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...fallOfWickets.map((wicket) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    wicket,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF212121),
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildScorecardTab() {
      if (isTabLoading) {
    return _buildTabLoadingIndicator();
  }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: currentInnings == 1
                        ? const Color(0xFF1976D2)
                        : const Color(0xFFF5F5F5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Center(
                    child: Text(
                      '1st Innings',
                      style: TextStyle(
                        color: currentInnings == 1
                            ? Colors.white
                            : const Color(0xFF666666),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: currentInnings == 2
                        ? const Color(0xFF1976D2)
                        : const Color(0xFFF5F5F5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Center(
                    child: Text(
                      '2nd Innings',
                      style: TextStyle(
                        color: currentInnings == 2
                            ? Colors.white
                            : const Color(0xFF666666),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildScorecardSection(
            title: '$currentTeam BATTING',
            headers: ['BATSMAN', 'R', 'B', '4S', '6S', 'SR'],
            data: battingScorecard,
            isBatting: true,
          ),
          const SizedBox(height: 20),
          _buildScorecardSection(
            title: 'BOWLING',
            headers: ['BOWLER', 'O', 'M', 'R', 'W', 'WD', 'NB', 'ECON'],
            data: bowlingScorecard,
            isBatting: false,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildScorecardSection({
    required String title,
    required List<String> headers,
    required List<Map<String, dynamic>> data,
    required bool isBatting,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
            ),
            child: Row(
              children: headers.map((header) {
                bool isPlayerName = header == 'BATSMAN' || header == 'BOWLER';
                return Expanded(
                  flex: isPlayerName ? 3 : 1,
                  child: Text(
                    header,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: isPlayerName ? TextAlign.left : TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
          ...data.map((player) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            player['name'],
                            style: const TextStyle(
                              color: Color(0xFF212121),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (isBatting) ...[
                          Expanded(
                              child: _buildStatCell(player['runs'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['balls'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['fours'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['sixes'].toString())),
                          Expanded(
                              child: _buildStatCell(
                                  player['sr'].toStringAsFixed(2))),
                        ] else ...[
                          Expanded(
                              child:
                                  _buildStatCell(player['overs'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['maidens'].toString())),
                          Expanded(
                              child: _buildStatCell(player['runs'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['wickets'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['wides'].toString())),
                          Expanded(
                              child:
                                  _buildStatCell(player['noballs'].toString())),
                          Expanded(
                              child: _buildStatCell(
                                  player['econ'].toStringAsFixed(2))),
                        ],
                      ],
                    ),
                    if (isBatting && player['status'] != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            player['status'],
                            style: const TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildStatCell(String value) {
    return Text(
      value,
      style: const TextStyle(color: Color(0xFF212121)),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCommentaryTab() {
      if (isTabLoading) {
    return _buildTabLoadingIndicator();
  }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Commentary',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: commentary.isEmpty
                ? const Center(
                    child: Text(
                      'No commentary yet',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.separated(
                    reverse: true,
                    itemCount: commentary.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Color(0xFFE0E0E0),
                      height: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Text(
                        commentary[commentary.length - 1 - index],
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMVPTab() {
      if (isTabLoading) {
    return _buildTabLoadingIndicator();
  }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MVP Leaderboard',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'PLAYER',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'POINTS',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (mvpPlayers.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'No MVP data yet',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mvpPlayers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final player = mvpPlayers[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        player['name'] ?? 'Unknown',
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        player['points']?.toString() ?? '0',
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                );
              },
            ),
          if (topPerformers.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Text(
              'Top Performers',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: topPerformers.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final performer = topPerformers[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getPerformerColor(performer['category'] ?? '')
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getPerformerColor(performer['category'] ?? '')
                            .withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                _getPerformerColor(performer['category'] ?? ''),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            performer['category'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            performer['name'] ?? 'Unknown',
                            style: const TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          performer['stat'] ?? '',
                          style: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabLoadingIndicator() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: Color(0xFF1976D2),
        ),
        SizedBox(height: 16),
        Text(
          'Refreshing data...',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    ),
  );
}

  Color _getPerformerColor(String performer) {
    switch (performer.toLowerCase()) {
      case 'best batsman':
        return const Color(0xFF4CAF50);
      case 'best bowler':
        return const Color(0xFF2196F3);
      case 'best fielder':
        return const Color(0xFFFF9800);
      case 'best all-rounder':
        return const Color(0xFF9C27B0);
      case 'best wicket keeper':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF757575);
    }
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF212121),
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreButton(String label, Color bgColor, String bowlerId) {
    bool isDarkButton = bgColor == const Color(0xFF1976D2) ||
        bgColor == const Color(0xFF388E3C) ||
        bgColor == const Color(0xFFD32F2F) ||
        bgColor == const Color(0xFFFF7043);

    Color textColor = isDarkButton ? Colors.white : const Color(0xFF212121);

    return ElevatedButton(
      onPressed: () => _handleScoring(label, bowlerId),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isDarkButton ? bgColor : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        elevation: 0,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: TextStyle(
            fontSize: label.length > 4 ? 12 : 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
