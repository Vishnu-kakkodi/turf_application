import 'package:flutter/material.dart';
import 'cricket_models.dart'; // Import your models file

class UserLiveScreen extends StatefulWidget {
  const UserLiveScreen({super.key});

  @override
  State<UserLiveScreen> createState() => _UserLiveScreenState();
}

class _UserLiveScreenState extends State<UserLiveScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Match data
  String currentTeam = "TEAM A";
  int totalRuns = 0;
  int wickets = 0;
  double overs = 0.0;
  double runRate = 0.0;
  String currentBatsman = "Player A1";
  String currentBowler = "Player B2";
  String nonStriker = "Player A3";
  bool isWaitingForBatsman = false;
  bool isWaitingForBowler = false;
  bool isOver =false;
  
  // Player lists for modals
  List<String> teamAPlayers = [
    "Player A1", "Player A2", "Player A3", "Player A4", "Player A5",
    "Player A6", "Player A7", "Player A8", "Player A9", "Player A10", "Player A11"
  ];
  
  List<String> teamBPlayers = [
    "Player B1", "Player B2", "Player B3", "Player B4", "Player B5",
    "Player B6", "Player B7", "Player B8", "Player B9", "Player B10", "Player B11"
  ];
  
  List<String> battingOrder = [];
  List<String> availableBowlers = [];
  
  // Sample data for different tabs
  List<String> fallOfWickets = ["10/1 (Player A1) - 1.2 ov"];
  List<String> thisOverBalls = [".", ".", ".", ".", ".", "."];
  List<String> commentary = [
    "1.2: WICKET! Player A1 is out for 6! (Caught). Runs on ball: 0.",
    "1.1: Player B2 to Player A3, 1 run.",
    "End of Over 1. Score: 9/0",
    "0.6: Player B2 to Player A1, 0 runs.",
    "0.5: Player B2 to Player A3, 1 run.",
    "0.4: Player B2 to Player A1, 3 runs.",
    "0.3: Player B2 to Player A3, 2 runs.",
    "0.2: Player B2 to Player A1, NO BALL",
    "0.2: Player B2 to Player A3, WIDE.",
    "0.1: Player B2 to Player A1, 0 runs.",
  ];

  // MVP and Scorecard data

List<Map<String, dynamic>> mvpPlayers = [
  {"name": "Player B2", "points": 10},
  {"name": "Player A1", "points": 6},
  {"name": "Player A3", "points": 2},
];

List<Map<String, dynamic>> topPerformers = [
  {"category": "Best Batsman", "name": "Player B2", "stat": "125 runs"},
  {"category": "Best Bowler", "name": "Player A1", "stat": "3 wickets"},
  {"category": "Best Fielder", "name": "Player A3", "stat": "2 catches"},
  {"category": "Best All-rounder", "name": "Player C1", "stat": "50 runs, 2 wkts"},
];

  List<Map<String, dynamic>> battingScorecard = [
    {"name": "Player A1", "runs": 6, "balls": 6, "fours": 0, "sixes": 0, "sr": 100.00, "status": "Out b. Player B2"},
    {"name": "Player A2", "runs": 0, "balls": 0, "fours": 0, "sixes": 0, "sr": 0.00, "status": "Yet to bat"},
    {"name": "Player A3", "runs": 2, "balls": 2, "fours": 0, "sixes": 0, "sr": 100.00, "status": "Not out"},
    {"name": "Player A4", "runs": 0, "balls": 0, "fours": 0, "sixes": 0, "sr": 0.00, "status": "Yet to bat"},
    {"name": "Player A5", "runs": 0, "balls": 0, "fours": 0, "sixes": 0, "sr": 0.00, "status": "Yet to bat"},
  ];

  List<Map<String, dynamic>> bowlingScorecard = [
    {"name": "Player B2", "overs": 1.2, "maidens": 0, "runs": 10, "wickets": 1, "wides": 1, "noballs": 1, "econ": 7.50},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeMatch();
  }

  void _initializeMatch() {
    battingOrder = List.from(teamAPlayers);
    availableBowlers = List.from(teamBPlayers);
    
    // Show opening batsmen selection at start
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _selectOpeningBatsmen();
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Modal integration methods
  Future<void> _selectOpeningBatsmen() async {
    // final result = await CricketModals.showOpeningBatsmenModal(
    //   context,
    //   availableBatsmen: teamAPlayers,
    // );
    
    // if (result != null) {
    //   setState(() {
    //     currentBatsman = result['striker']!;
    //     nonStriker = result['nonStriker']!;
    //     isWaitingForBatsman = false;
    //   });
      
    //   // Now select opening bowler
    //   _selectBowler();
    // }
  }

  Future<void> _selectBowler() async {

    // final result = await CricketModals.showBowlerSelectionModal(
    //   context,
    //   availablePlayers: availableBowlers,
    // );
    
    // if (result != null) {
    //   setState(() {
    //     currentBowler = result['bowler']!;
    //     isWaitingForBowler = false;
    //   });
      
    //   _addCommentary("New bowler: ${result['bowler']} (${result['style']})");

    //   if(isOver){
    //     setState(() {
    //       isOver = false;
    //     });
    //   }
    // }
  }

  Future<void> _handleWicket() async {
    // final wicketResult = await CricketModals.showWicketModal(
    //   context,
    //   dismissedPlayer: currentBatsman,
    //   fielders: teamBPlayers,
    // );
    
    // if (wicketResult != null) {
    //   setState(() {
    //     wickets++;
    //     totalRuns += int.parse(wicketResult['runs']);
    //   });
      
    //   // Add to fall of wickets
    //   fallOfWickets.add("$totalRuns/$wickets ($currentBatsman) - $overs ov");
      
    //   // Add commentary
    //   String commentaryText = "$overs: WICKET! $currentBatsman is out!";
    //   if (wicketResult['fielder'] != null) {
    //     commentaryText += " (${wicketResult['type']} by ${wicketResult['fielder']})";
    //   } else {
    //     commentaryText += " (${wicketResult['type']})";
    //   }
    //   commentaryText += " Runs on ball: ${wicketResult['runs']}.";
    //   _addCommentary(commentaryText);
      
    //   _updateOvers();
    //   _updateThisOver('W');
      
    //   // Check if all out
    //   if (wickets >= 2) {
    //     _handleInningsEnd();
    //   } else {
    //     _selectNextBatsman();
    //   }
    // }
  }

  Future<void> _selectNextBatsman() async {
    // List<String> availableBatsmen = teamAPlayers
    //     .where((player) => 
    //         player != currentBatsman && 
    //         player != nonStriker && 
    //         !battingScorecard.any((b) => b['name'] == player && b['status'].toString().contains('Out')))
    //     .toList();
    
    // final nextBatsman = await CricketModals.showNextBatsmanModal(
    //   context,
    //   availableBatsmen: availableBatsmen,
    // );
    
    // if (nextBatsman != null) {
    //   setState(() {
    //     currentBatsman = nextBatsman;
    //     isWaitingForBatsman = false;
    //   });
      
    //   _addCommentary("$nextBatsman comes to the crease");
    // }
  }

  Future<void> _handleInningsEnd() async {
    if (currentTeam == "TEAM A") {
      // First innings complete
      await CricketModals.showInningsBreakModal(
        context,
        chasingTeam: "TEAM B",
        targetRuns: totalRuns + 1,
        targetOvers: 4.0, // Assuming 20 over match
      );
      
      // Switch to second innings
      setState(() {
        currentTeam = "TEAM B";
        // Reset for second innings
        totalRuns = 0;
        wickets = 0;
        overs = 0.0;
        runRate = 0.0;
        thisOverBalls = [".", ".", ".", ".", ".", "."];
      });
      
      // Select opening batsmen for team B
      await _selectOpeningBatsmen();
    } else {
      // Match complete
      _handleMatchEnd();
    }
  }

  Future<void> _handleMatchEnd() async {
    await CricketModals.showMatchOverModal(
      context,
      result: "Match completed successfully!",
      winningTeam: "TEAM A", // Determine winner logic here
      margin: "5 runs",
    );
    
    // Navigate back or reset match
    Navigator.of(context).pop();
  }

  void _addCommentary(String text) {
    setState(() {
      commentary.insert(0, text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Cricket Score Manager',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width < 400 ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1976D2),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create teams, schedule matches, and track scores live.',
                    style: TextStyle(
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
            
            // Score Card
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
                                overs.toString(),
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
            
            // Tabs
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
            
            // Tab Content
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Mobile-friendly layout
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
        // On Crease & Current Bowler
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                title: 'ON CREASE',
                content: isWaitingForBatsman 
                    ? 'Waiting for batsmen...'
                    : '$currentBatsman 25(30)* / $nonStriker 5(10)',
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
                    : '$currentBowler 12(5)',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // This Over
        _buildThisOverCard(),
        const SizedBox(height: 16),
        
        // Scoring Grid
        // _buildScoringGrid(),
        // const SizedBox(height: 16),
        
        // Fall of Wickets
        // _buildFallOfWicketsCard(),
        // const SizedBox(height: 16),
        
        // Quick Actions
        // _buildQuickActionsCard(),
      ],
    );
  }

  Widget _buildTabletLiveLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          child: Column(
            children: [
              _buildInfoCard(
                title: 'ON CREASE',
                content: isWaitingForBatsman 
                    ? 'Waiting for batsmen...'
                    : '$currentBatsman 25(30)* / $nonStriker 5(10)',
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                title: 'CURRENT BOWLER',
                content: isWaitingForBowler 
                    ? 'Waiting for bowler...'
                    : '$currentBowler 12(5)',
              ),
              const SizedBox(height: 16),
              _buildFallOfWicketsCard(),
              const SizedBox(height: 16),
              _buildQuickActionsCard(),
            ],
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Right Column
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
                  ),
                  child: const Text('Change Bowler'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Swap striker and non-striker
                    setState(() {
                      String temp = currentBatsman;
                      currentBatsman = nonStriker;
                      nonStriker = temp;
                    });
                    _showSnackBar('Batsmen swapped');
                  },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: thisOverBalls.map((ball) => Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ball == "." ? const Color(0xFFF5F5F5) : const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ball == "." ? const Color(0xFFE0E0E0) : const Color(0xFF1976D2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  ball,
                  style: TextStyle(
                    color: ball == "." ? const Color(0xFF666666) : const Color(0xFF1976D2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            )).toList(),
          ),
        ],
      )
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
        _buildScoreButton('0', const Color(0xFFF5F5F5)),
        _buildScoreButton('1', const Color(0xFFF5F5F5)),
        _buildScoreButton('2', const Color(0xFFF5F5F5)),
        _buildScoreButton('3', const Color(0xFFF5F5F5)),
        _buildScoreButton('4', const Color(0xFF1976D2)),
        _buildScoreButton('6', const Color(0xFF388E3C)),
        _buildScoreButton('Wide', const Color(0xFFFF9800)),
        _buildScoreButton('No Ball', const Color(0xFFFF9800)),
        _buildScoreButton('Bye', const Color(0xFFF5F5F5)),
        _buildScoreButton('Leg Bye', const Color(0xFFF5F5F5)),
        _buildScoreButton('Wicket', const Color(0xFFD32F2F)),
        _buildScoreButton('Undo', const Color(0xFFFF7043)),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      wicket.split(' - ')[0],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    wicket.split(' - ')[1],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }

  Widget _buildScorecardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Team Innings Toggle
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: currentTeam == "TEAM A" ? const Color(0xFF1976D2) : const Color(0xFFF5F5F5),
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
                        color: currentTeam == "TEAM A" ? Colors.white : const Color(0xFF666666),
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
                    color: currentTeam == "TEAM B" ? const Color(0xFF1976D2) : const Color(0xFFF5F5F5),
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
                        color: currentTeam == "TEAM B" ? Colors.white : const Color(0xFF666666),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Batting Scorecard
          _buildScorecardSection(
            title: '$currentTeam BATTING',
            headers: ['BATSMAN', 'R', 'B', '4S', '6S', 'SR'],
            data: battingScorecard,
            isBatting: true,
          ),
          
          const SizedBox(height: 20),
          
          // Bowling Scorecard
          _buildScorecardSection(
            title: '${currentTeam == "TEAM A" ? "TEAM B" : "TEAM A"} BOWLING',
            headers: ['BOWLER', 'O', 'M', 'R', 'W', 'WIDE', 'NB', 'ECON'],
            data: bowlingScorecard,
            isBatting: false,
          ),
          
          const SizedBox(height: 20),
          
          // Fall of Wickets
          Container(
            width: double.infinity,
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
                    style: TextStyle(color: Color(0xFF666666)),
                  )
                else
                  ...fallOfWickets.map((wicket) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      wicket,
                      style: const TextStyle(color: Color(0xFF212121)),
                    ),
                  )),
              ],
            ),
          ),
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
          
          // Headers
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
          
          // Data rows
          ...data.map((player) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      Expanded(child: _buildStatCell(player['runs'].toString())),
                      Expanded(child: _buildStatCell(player['balls'].toString())),
                      Expanded(child: _buildStatCell(player['fours'].toString())),
                      Expanded(child: _buildStatCell(player['sixes'].toString())),
                      Expanded(child: _buildStatCell(player['sr'].toStringAsFixed(2))),
                    ] else ...[
                      Expanded(child: _buildStatCell(player['overs'].toString())),
                      Expanded(child: _buildStatCell(player['maidens'].toString())),
                      Expanded(child: _buildStatCell(player['runs'].toString())),
                      Expanded(child: _buildStatCell(player['wickets'].toString())),
                      Expanded(child: _buildStatCell(player['wides'].toString())),
                      Expanded(child: _buildStatCell(player['noballs'].toString())),
                      Expanded(child: _buildStatCell(player['econ'].toStringAsFixed(2))),
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
          
          // Total/Extras
          if (isBatting) ...[
            const Divider(color: Color(0xFFE0E0E0), height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Extras',
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: Text(
                      '2 (B: 0, LB: 0, W: 1, NB: 1)',
                      style: const TextStyle(color: Color(0xFF212121), fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFE0E0E0), height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Total',
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$totalRuns/$wickets',
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: Text(
                      '($overs Overs)',
                      style: const TextStyle(color: Color(0xFF666666)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            child: ListView.separated(
              itemCount: commentary.length,
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFFE0E0E0),
                height: 20,
              ),
              itemBuilder: (context, index) {
                return Text(
                  commentary[index],
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

        // Header
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

        // MVP List
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
                    player['name'],
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    player['points'].toString(),
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

        const SizedBox(height: 24),

        // Top Performers Section
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
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final performer = topPerformers[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getPerformerColor(performer['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getPerformerColor(performer['category']).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getPerformerColor(performer['category']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        performer['category'],
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
                        performer['name'],
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      performer['stat'],
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
    ),
  );
}

Color _getPerformerColor(String performer) {
  switch (performer.toLowerCase()) {
    case 'best batsman':
      return const Color(0xFF4CAF50); // Green
    case 'best bowler':
      return const Color(0xFF2196F3); // Blue
    case 'best fielder':
      return const Color(0xFFFF9800); // Orange
    case 'best all-rounder':
      return const Color(0xFF9C27B0); // Purple
    case 'best wicket keeper':
      return const Color(0xFFF44336); // Red
    default:
      return const Color(0xFF757575); // Grey
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

  Widget _buildScoreButton(String label, Color color) {
    bool isGrayButton = color == const Color(0xFFF5F5F5);
    
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: isGrayButton ? Border.all(color: const Color(0xFFE0E0E0)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleScoring(label),
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isGrayButton ? const Color(0xFF212121) : Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleScoring(String score) {
    setState(() {
      switch (score) {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '6':
          int runs = int.parse(score);
          totalRuns += runs;
          _updateOvers();
          _updateThisOver(score);
          _addCommentary("$overs: $currentBowler to $currentBatsman, $runs run${runs == 1 ? '' : 's'}.");
          
          // Swap batsmen if odd runs
          if (runs % 2 == 1) {
            String temp = currentBatsman;
            currentBatsman = nonStriker;
            nonStriker = temp;
          }
          break;
          
        case 'Wide':
        case 'No Ball':
          totalRuns += 1;
          _updateThisOver(score == 'Wide' ? 'Wd' : 'Nb');
          _addCommentary("$overs: $currentBowler to $currentBatsman, ${score.toUpperCase()}.");
          // Note: Don't update overs for wides/no-balls
          break;
          
        case 'Wicket':
          _handleWicket();
          return; // Don't update run rate here, it's handled in _handleWicket
          
        case 'Bye':
        case 'Leg Bye':
          totalRuns += 1;
          _updateOvers();
          _updateThisOver('1');
          _addCommentary("$overs: $currentBowler to $currentBatsman, 1 run ($score).");
          // Swap batsmen
          String temp = currentBatsman;
          currentBatsman = nonStriker;
          nonStriker = temp;
          break;
          
        case 'Undo':
          _undoLastBall();
          return; // Don't show snackbar for undo
      }
      
      // Update run rate
      if (overs > 0) {
        runRate = totalRuns / overs;
      }
    });
    
    if (score != 'Undo') {
      _showSnackBar('$score added');
    }
  }

  void _updateOvers() {
    setState(() {
      isOver = true;
    });
    double currentBalls = (overs - overs.floor()) * 10;
    currentBalls++;
    
    if (currentBalls >= 6) {
      overs = overs.floor() + 1.0;
      // Reset this over when over is complete
      thisOverBalls = [".", ".", ".", ".", ".", "."];
      _addCommentary("End of Over ${overs.floor()}. Score: $totalRuns/$wickets");
      
      // Ask for new bowler after over completion
      if(overs>=2){
        _handleInningsEnd();
      }else{
        Future.delayed(const Duration(milliseconds: 500), () {
        _selectBowler();
      });
      }
    } else {
      overs = overs.floor() + (currentBalls / 10);
    }
  }

  void _updateThisOver(String ball) {
    int ballIndex = ((overs - overs.floor()) * 10).round();
    if (ballIndex == 0) ballIndex = 6; // Handle completed over
    ballIndex--; // Convert to 0-based index
    
    if (ballIndex >= 0 && ballIndex < 6) {
      thisOverBalls[ballIndex] = ball;
    }
  }

  void _undoLastBall() {
    // Simple undo implementation
    if (totalRuns > 0) {
      setState(() {
        totalRuns = (totalRuns - 1).clamp(0, double.infinity).toInt();
        // You can make this more sophisticated by tracking the last action
        if (commentary.isNotEmpty) {
          commentary.removeAt(0); // Remove last commentary entry
        }
      });
      _showSnackBar('Last ball undone');
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
}