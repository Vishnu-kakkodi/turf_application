
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  Timer? _timer;

  // Match data
  String matchStatus = "Live";
  String currentBowler = "J. Bumrah";
  String currentOver = "15.3";
  String teamAScore = "145/4";
  String teamBScore = "78/2";
  String teamAName = "India";
  String teamBName = "Australia";
  String currentBatting = "Australia needs 68 runs from 27 balls";

  // Live batting data with player images
  List<Map<String, dynamic>> batsmen = [
    {
      'name': 'Dinesh Karthik',
      'runs': 16,
      'balls': 12,
      'fours': 2,
      'sixes': 0,
      'sr': 133.3,
      'isOnStrike': true,
      'imageUrl':
          'lib/assets/8b633588b640de4868e105e951a71279f209860c.png'
    },
    {
      'name': 'Hardik Pandya',
      'runs': 18,
      'balls': 12,
      'fours': 3,
      'sixes': 0,
      'sr': 150.0,
      'isOnStrike': false,
      'imageUrl':
          'lib/assets/8b633588b640de4868e105e951a71279f209860c.png'
    },
  ];

  // Live bowling data with images
  List<Map<String, dynamic>> bowlers = [
    {
      'name': 'J. Bumrah',
      'overs': '3.3',
      'maidens': '0',
      'runs': '18',
      'wickets': '2',
      'econ': '5.14',
      'imageUrl':
          'lib/assets/8b633588b640de4868e105e951a71279f209860c.png'
    },
    {
      'name': 'Mohammed Shami',
      'overs': '2.0',
      'maidens': '0',
      'runs': '12',
      'wickets': '0',
      'econ': '6.00',
      'imageUrl':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face'
    },
  ];

  // Top performers data
  List<Map<String, dynamic>> topPerformers = [
    {
      'name': 'V. Kohli',
      'role': 'Top Scorer',
      'runs': 45,
      'balls': 32,
      'sr': 140.6,
      'imageUrl':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'
    },
    {
      'name': 'J. Bumrah',
      'role': 'Best Bowler',
      'wickets': 2,
      'runs': 18,
      'econ': 5.14,
      'imageUrl':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face'
    },
    {
      'name': 'Hardik Pandya',
      'role': 'All-rounder',
      'runs': 18,
      'balls': 12,
      'sr': 150.0,
      'imageUrl':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face'
    },
  ];

  // Recent balls
  List<String> recentBalls = ['4', 'W', '6', '2', '6', '1'];

  // Commentary data
  List<Map<String, String>> commentary = [
    {
      'over': '15.3',
      'comment': 'FOUR! Brilliant shot by Karthik down the ground'
    },
    {
      'over': '15.2',
      'comment': 'WICKET! Caught behind, great delivery by Bumrah'
    },
    {'over': '15.1', 'comment': 'SIX! What a hit! Goes over the boundary'},
    {
      'over': '14.6',
      'comment': 'Two runs taken, good running between the wickets'
    },
    {
      'over': '14.5',
      'comment': 'SIX! Another maximum! The crowd is on their feet'
    },
    {'over': '14.4', 'comment': 'Single taken, rotating the strike well'},
  ];

  // Scorecard data
  List<Map<String, dynamic>> fullScorecard = [
    {
      'name': 'V. Kohli',
      'runs': 45,
      'balls': 32,
      'fours': 6,
      'sixes': 1,
      'sr': 140.6,
      'status': 'b Starc'
    },
    {
      'name': 'R. Sharma',
      'runs': 23,
      'balls': 18,
      'fours': 3,
      'sixes': 0,
      'sr': 127.8,
      'status': 'c Warner b Cummins'
    },
    {
      'name': 'S. Iyer',
      'runs': 12,
      'balls': 8,
      'fours': 1,
      'sixes': 0,
      'sr': 150.0,
      'status': 'lbw b Hazlewood'
    },
    {
      'name': 'KL Rahul',
      'runs': 8,
      'balls': 6,
      'fours': 1,
      'sixes': 0,
      'sr': 133.3,
      'status': 'run out'
    },
    {
      'name': 'Dinesh Karthik*',
      'runs': 16,
      'balls': 12,
      'fours': 2,
      'sixes': 0,
      'sr': 133.3,
      'status': 'not out'
    },
    {
      'name': 'Hardik Pandya',
      'runs': 18,
      'balls': 12,
      'fours': 3,
      'sixes': 0,
      'sr': 150.0,
      'status': 'not out'
    },
  ];

  // Run rate data for chart
  List<Map<String, dynamic>> runRateData = [
    {'over': 1, 'runs': 8, 'cumulative': 8},
    {'over': 2, 'runs': 12, 'cumulative': 20},
    {'over': 3, 'runs': 15, 'cumulative': 35},
    {'over': 4, 'runs': 18, 'cumulative': 53},
    {'over': 5, 'runs': 22, 'cumulative': 75},
    {'over': 6, 'runs': 25, 'cumulative': 100},
    {'over': 7, 'runs': 28, 'cumulative': 128},
    {'over': 8, 'runs': 17, 'cumulative': 145},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // Changed to 5 tabs
    _startLiveUpdates();
  }

  void _startLiveUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          // Simulate live updates
          _updateLiveData();
        });
      }
    });
  }

  void _updateLiveData() {
    // Update runs randomly
    final random = Random();
    if (random.nextBool()) {
      int runsScored = random.nextInt(7);
      batsmen[0]['runs'] += runsScored;
      batsmen[0]['balls'] += 1;
      batsmen[0]['sr'] =
          (batsmen[0]['runs'] / batsmen[0]['balls'] * 100).toDouble();

      // Update recent balls
      recentBalls.removeAt(0);
      recentBalls.add(runsScored.toString());

      // Add to commentary
      String newComment = _generateCommentary(runsScored);
      commentary.insert(0, {'over': currentOver, 'comment': newComment});
      if (commentary.length > 10) {
        commentary.removeLast();
      }
    }
  }

  String _generateCommentary(int runs) {
    switch (runs) {
      case 0:
        return "Dot ball, good bowling";
      case 1:
        return "Single taken, good running";
      case 2:
        return "Two runs, well placed shot";
      case 3:
        return "Three runs, quick running between wickets";
      case 4:
        return "FOUR! Excellent shot to the boundary";
      case 6:
        return "SIX! What a massive hit over the boundary!";
      default:
        return "Good delivery from the bowler";
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF2E8B57),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Live Cricket Score',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildMatchHeader(),
                  ],
                ),
              ),

              // Main content with tabs
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [

                      
                      // Tab bar
                      Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: CustomTabIndicator(
                            width: 88, 
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // indicator: BoxDecoration(

                          //   color: Colors.blue,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          labelColor: Colors.white,
                          unselectedLabelColor: const Color.fromARGB(255, 63, 63, 63),
                          isScrollable: true,
                          tabs: const [
                            Tab(text: 'Live'),
                            Tab(text: 'Summary'),
                            Tab(text: 'Scorecard'),
                            Tab(text: 'Commentary'),
                            Tab(text: 'Status'),
                          ],
                        ),
                      ),

                      // Tab content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildLiveTab(),
                            _buildPlayersTab(),
                            _buildScorecardTab(),
                            _buildCommentaryTab(),
                            _buildMatchStatusCard()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                teamAName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: matchStatus == "Live" ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  matchStatus,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              Text(
                teamBName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                teamAScore,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'vs',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                teamBScore,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currentBatting,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Performers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Top performers grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: topPerformers.length,
            itemBuilder: (context, index) {
              return _buildPlayerSummaryCard(topPerformers[index]);
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Current Batsmen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Current batsmen
          ...batsmen.map(
              (batsman) => _buildPlayerDetailCard(batsman, isBatsman: true)),

          const SizedBox(height: 24),

          const Text(
            'Current Bowlers',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Current bowlers
          ...bowlers.map(
              (bowler) => _buildPlayerDetailCard(bowler, isBatsman: false)),
        ],
      ),
    );
  }

  Widget _buildPlayerSummaryCard(Map<String, dynamic> player) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[400]!,
            Colors.blue[600]!,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Player Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  player['imageUrl'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.person,
                          size: 30, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Player Name
            Text(
              player['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Role
            Text(
              player['role'],
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Stats
            if (player['runs'] != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sports_cricket,
                      color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${player['runs']} runs',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (player['sr'] != null)
                Text(
                  'SR: ${player['sr']}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
            ] else if (player['wickets'] != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sports_baseball,
                      color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${player['wickets']} wickets',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (player['econ'] != null)
                Text(
                  'Econ: ${player['econ']}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerDetailCard(Map<String, dynamic> player,
      {required bool isBatsman}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              player['isOnStrike'] == true ? Colors.green : Colors.grey[300]!,
          width: player['isOnStrike'] == true ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Player Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: player['isOnStrike'] == true
                    ? Colors.green
                    : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                player['imageUrl'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child:
                        const Icon(Icons.person, size: 25, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Player Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        player['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (player['isOnStrike'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'On Strike',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                if (isBatsman) ...[
                  Text(
                    '${player['runs']} runs (${player['balls']} balls) • SR: ${player['sr'].toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '4s: ${player['fours']} • 6s: ${player['sixes']}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ] else ...[
                  Text(
                    '${player['overs']} overs • ${player['runs']} runs • ${player['wickets']} wickets',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Economy: ${player['econ']} • Maidens: ${player['maidens']}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current partnership
          _buildCurrentPartnership(),
          const SizedBox(height: 20),

          // Batting section
          _buildBattingSection(),
          const SizedBox(height: 20),

          // Bowling section
          _buildBowlingSection(),
          const SizedBox(height: 20),

          // Recent balls
          _buildRecentBalls(),
          const SizedBox(height: 20),

          // Run rate chart
          _buildRunRateChart(),
        ],
      ),
    );
  }

  Widget _buildCurrentPartnership() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Partnership',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '34 runs from 24 balls',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            'Current Over: $currentOver | Bowler: $currentBowler',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildBattingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Batting',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            _buildStatHeader('R', 50),
            _buildStatHeader('B', 50),
            _buildStatHeader('4s', 30),
            _buildStatHeader('6s', 30),
            _buildStatHeader('SR', 50),
          ],
        ),
        const SizedBox(height: 8),
        ...batsmen.map((batsman) => _buildBatsmanRow(batsman)),
      ],
    );
  }

  Widget _buildBowlingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Bowling',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            _buildStatHeader('O', 40),
            _buildStatHeader('M', 30),
            _buildStatHeader('R', 30),
            _buildStatHeader('W', 30),
            _buildStatHeader('Econ', 50),
          ],
        ),
        const SizedBox(height: 8),
        ...bowlers.map((bowler) => _buildBowlerRow(bowler)),
      ],
    );
  }

  Widget _buildRecentBalls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Balls',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: recentBalls.map((ball) => _buildScoreNumber(ball)).toList(),
        ),
      ],
    );
  }

  Widget _buildRunRateChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Run Rate Progression',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: RunRateChartPainter(runRateData),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScorecardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Full Scorecard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                  child: Text('Batsman',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              _buildStatHeader('R', 40),
              _buildStatHeader('B', 40),
              _buildStatHeader('4s', 30),
              _buildStatHeader('6s', 30),
              _buildStatHeader('SR', 50),
            ],
          ),
          const Divider(),
          ...fullScorecard.map((player) => _buildScorecardRow(player)),
          const SizedBox(height: 20),
          _buildExtras(),
        ],
      ),
    );
  }

  Widget _buildMatchStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sports_cricket, color: Colors.blue[700], size: 24),
              const SizedBox(width: 8),
              Text(
                'Match Status: $matchStatus',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            currentBatting,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Current Over: $currentOver',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          Text(
            'Bowler: $currentBowler',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentaryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: commentary.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            // border: Border.left(
            //   color: Colors.blue,
            //   width: 4,
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentary[index]['over']!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                commentary[index]['comment']!,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatHeader(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildBatsmanRow(Map<String, dynamic> batsman) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: batsman['isOnStrike'] ? Colors.green[50] : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (batsman['isOnStrike'])
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                Expanded(
                  child: Text(
                    batsman['name'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: batsman['isOnStrike']
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildStatCell(batsman['runs'].toString(), 50),
          _buildStatCell(batsman['balls'].toString(), 50),
          _buildStatCell(batsman['fours'].toString(), 30),
          _buildStatCell(batsman['sixes'].toString(), 30),
          _buildStatCell(batsman['sr'].toStringAsFixed(1), 50),
        ],
      ),
    );
  }

  Widget _buildBowlerRow(Map<String, dynamic> bowler) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              bowler['name'],
              style: const TextStyle(fontSize: 14),
            ),
          ),
          _buildStatCell(bowler['overs'], 40),
          _buildStatCell(bowler['maidens'], 30),
          _buildStatCell(bowler['runs'], 30),
          _buildStatCell(bowler['wickets'], 30),
          _buildStatCell(bowler['econ'], 50),
        ],
      ),
    );
  }

  Widget _buildScorecardRow(Map<String, dynamic> player) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player['name'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      player['status'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              _buildStatCell(player['runs'].toString(), 40),
              _buildStatCell(player['balls'].toString(), 40),
              _buildStatCell(player['fours'].toString(), 30),
              _buildStatCell(player['sixes'].toString(), 30),
              _buildStatCell(player['sr'].toStringAsFixed(1), 50),
            ],
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildExtras() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Extras',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Byes: 2, Leg-byes: 1, Wides: 3, No-balls: 1'),
          SizedBox(height: 8),
          Text(
            'Total: 152/4 (15.3 overs)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCell(String value, double width) {
    return SizedBox(
      width: width,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildScoreNumber(String score) {
    Color bgColor;
    if (score == '4') {
      bgColor = Colors.green;
    } else if (score == '6') {
      bgColor = Colors.blue;
    } else if (score == 'W') {
      bgColor = Colors.red;
    } else {
      bgColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          score,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class RunRateChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  RunRateChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final double maxRuns = data
        .map((e) => e['cumulative'] as int)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
    final double stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final double x = i * stepX;
      final double y =
          size.height - (data[i]['cumulative'] / maxRuns * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw points
      canvas.drawCircle(
        Offset(x, y),
        4,
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill,
      );
    }

    canvas.drawPath(path, paint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final double y = (size.height / 4) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CustomTabIndicator extends Decoration {
  final double width;
  final Color color;
  final BorderRadius borderRadius;

  const CustomTabIndicator({
    required this.width,
    required this.color,
    required this.borderRadius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(
      width: width,
      color: color,
      borderRadius: borderRadius,
    );
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final double width;
  final Color color;
  final BorderRadius borderRadius;

  _CustomTabIndicatorPainter({
    required this.width,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Size size = configuration.size!;
    final Rect rect = Rect.fromCenter(
      center: offset + Offset(size.width / 2, size.height / 2),
      width: width,
      height: size.height,
    );

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(borderRadius.toRRect(rect), paint);
  }
}
