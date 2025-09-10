import 'package:flutter/material.dart';

class PlayerLeaderBoard extends StatefulWidget {
  const PlayerLeaderBoard({super.key});

  @override
  State<PlayerLeaderBoard> createState() => _PlayerLeaderBoardState();
}

class _PlayerLeaderBoardState extends State<PlayerLeaderBoard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedSport = 0;

  final List<Map<String, dynamic>> sports = [
    {
      'name': 'Football',
      'icon': Icons.sports_football,
      'color': const Color(0xFF2E8B57),
    },
    {
      'name': 'Cricket',
      'icon': Icons.sports_cricket,
      'color': const Color(0xFF1976D2),
    },
    {
      'name': 'Hockey',
      'icon': Icons.sports_hockey,
      'color': const Color(0xFFD32F2F),
    },
    {
      'name': 'Basketball',
      'icon': Icons.sports_basketball,
      'color': const Color(0xFFFF6F00),
    },
  ];

  final Map<String, List<Map<String, dynamic>>> playersData = {
    'Football': [
      {
        'name': 'Lionel Messi',
        'team': 'Inter Miami',
        'points': 2850,
        'goals': 45,
        'assists': 28,
        'matches': 38,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Cristiano Ronaldo',
        'team': 'Al Nassr',
        'points': 2720,
        'goals': 52,
        'assists': 15,
        'matches': 40,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Kylian Mbappé',
        'team': 'PSG',
        'points': 2650,
        'goals': 38,
        'assists': 22,
        'matches': 35,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Erling Haaland',
        'team': 'Manchester City',
        'points': 2580,
        'goals': 42,
        'assists': 18,
        'matches': 36,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Kevin De Bruyne',
        'team': 'Manchester City',
        'points': 2450,
        'goals': 15,
        'assists': 35,
        'matches': 32,
        'avatar': 'https://via.placeholder.com/50',
      },
    ],
    'Cricket': [
      {
        'name': 'Virat Kohli',
        'team': 'RCB',
        'points': 3200,
        'runs': 1250,
        'centuries': 8,
        'matches': 45,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Babar Azam',
        'team': 'Pakistan',
        'points': 3150,
        'runs': 1180,
        'centuries': 7,
        'matches': 42,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Kane Williamson',
        'team': 'New Zealand',
        'points': 2950,
        'runs': 1050,
        'centuries': 6,
        'matches': 38,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Steve Smith',
        'team': 'Australia',
        'points': 2880,
        'runs': 980,
        'centuries': 5,
        'matches': 35,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Joe Root',
        'team': 'England',
        'points': 2820,
        'runs': 920,
        'centuries': 5,
        'matches': 40,
        'avatar': 'https://via.placeholder.com/50',
      },
    ],
    'Hockey': [
      {
        'name': 'Connor McDavid',
        'team': 'Edmonton Oilers',
        'points': 3500,
        'goals': 55,
        'assists': 85,
        'matches': 75,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Nathan MacKinnon',
        'team': 'Colorado Avalanche',
        'points': 3350,
        'goals': 48,
        'assists': 78,
        'matches': 72,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Leon Draisaitl',
        'team': 'Edmonton Oilers',
        'points': 3200,
        'goals': 52,
        'assists': 68,
        'matches': 70,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'David Pastrnak',
        'team': 'Boston Bruins',
        'points': 3100,
        'goals': 58,
        'assists': 55,
        'matches': 68,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Erik Karlsson',
        'team': 'San Jose Sharks',
        'points': 2950,
        'goals': 25,
        'assists': 75,
        'matches': 65,
        'avatar': 'https://via.placeholder.com/50',
      },
    ],
    'Basketball': [
      {
        'name': 'LeBron James',
        'team': 'Lakers',
        'points': 4200,
        'ppg': 28.5,
        'assists': 8.2,
        'matches': 72,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Stephen Curry',
        'team': 'Warriors',
        'points': 4050,
        'ppg': 31.2,
        'assists': 6.8,
        'matches': 68,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Giannis Antetokounmpo',
        'team': 'Bucks',
        'points': 3950,
        'ppg': 29.8,
        'assists': 5.9,
        'matches': 70,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Luka Dončić',
        'team': 'Mavericks',
        'points': 3850,
        'ppg': 32.1,
        'assists': 9.2,
        'matches': 65,
        'avatar': 'https://via.placeholder.com/50',
      },
      {
        'name': 'Joel Embiid',
        'team': '76ers',
        'points': 3720,
        'ppg': 33.5,
        'assists': 4.2,
        'matches': 60,
        'avatar': 'https://via.placeholder.com/50',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: sports.length, vsync: this);
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
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Player Leaderboard',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: sports[selectedSport]['color'],
          indicatorWeight: 3,
          labelColor: sports[selectedSport]['color'],
          unselectedLabelColor: Colors.grey[600],
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          onTap: (index) {
            setState(() {
              selectedSport = index;
            });
          },
          tabs: sports.map((sport) {
            return Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(sport['icon']),
                  const SizedBox(width: 8),
                  Text(sport['name']),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: sports.map((sport) {
          return _buildLeaderboardList(sport['name']);
        }).toList(),
      ),
    );
  }

  Widget _buildLeaderboardList(String sportName) {
    final players = playersData[sportName] ?? [];
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Summary Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  sports[selectedSport]['color'],
                  sports[selectedSport]['color'].withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: sports[selectedSport]['color'].withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$sportName Leaderboard',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Top ${players.length} players ranking',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Players List
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return _buildPlayerCard(player, index + 1, sportName);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(Map<String, dynamic> player, int rank, String sport) {
    Color rankColor = Colors.grey[600]!;
    if (rank == 1) rankColor = const Color(0xFFFFD700); // Gold
    if (rank == 2) rankColor = const Color(0xFFC0C0C0); // Silver
    if (rank == 3) rankColor = const Color(0xFFCD7F32); // Bronze

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: rankColor, width: 2),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: TextStyle(
                  color: rankColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Player Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: sports[selectedSport]['color'].withOpacity(0.1),
            child: Text(
              player['name'].split(' ').map((n) => n[0]).join(),
              style: TextStyle(
                color: sports[selectedSport]['color'],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Player Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  player['team'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildStatRow(player, sport),
              ],
            ),
          ),
          
          // Points
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //       decoration: BoxDecoration(
          //         color: sports[selectedSport]['color'].withOpacity(0.1),
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Text(
          //         '${player['points']}',
          //         style: TextStyle(
          //           color: sports[selectedSport]['color'],
          //           fontWeight: FontWeight.bold,
          //           fontSize: 12,
          //         ),
          //       ),
          //     ),
          //     const SizedBox(height: 4),
          //     Text(
          //       'Points',
          //       style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.grey[500],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildStatRow(Map<String, dynamic> player, String sport) {
    List<Widget> stats = [];
    
    switch (sport) {
      case 'Football':
        stats = [
          _buildStat('Goals', player['goals'].toString()),
          _buildStat('Assists', player['assists'].toString()),
          _buildStat('Matches', player['matches'].toString()),
        ];
        break;
      case 'Cricket':
        stats = [
          _buildStat('Runs', player['runs'].toString()),
          _buildStat('100s', player['centuries'].toString()),
          _buildStat('Matches', player['matches'].toString()),
        ];
        break;
      case 'Hockey':
        stats = [
          _buildStat('Goals', player['goals'].toString()),
          _buildStat('Assists', player['assists'].toString()),
          _buildStat('Games', player['matches'].toString()),
        ];
        break;
      case 'Basketball':
        stats = [
          _buildStat('PPG', player['ppg'].toString()),
          _buildStat('APG', player['assists'].toString()),
          _buildStat('Games', player['matches'].toString()),
        ];
        break;
    }
    
    return Row(
      children: stats.take(3).map((stat) {
        return Container(
          margin: const EdgeInsets.only(right: 16),
          child: stat,
        );
      }).toList(),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}


















// import 'package:flutter/material.dart';

// class PlayerLeaderBoard extends StatefulWidget {
//   const PlayerLeaderBoard({super.key});

//   @override
//   State<PlayerLeaderBoard> createState() => _PlayerLeaderBoardState();
// }

// class _PlayerLeaderBoardState extends State<PlayerLeaderBoard>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//   late AnimationController _animationController;
//   late AnimationController _fabController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _fabAnimation;
  
//   int selectedSport = 0;
//   bool isGridView = false;

//   final List<Map<String, dynamic>> sports = [
//     {
//       'name': 'Football',
//       'icon': Icons.sports_football,
//       'gradient': [Color(0xFF667eea), Color(0xFF764ba2)],
//       'emoji': '⚽',
//     },
//     {
//       'name': 'Cricket',
//       'icon': Icons.sports_cricket,
//       'gradient': [Color(0xFF11998e), Color(0xFF38ef7d)],
//       'emoji': '🏏',
//     },
//     {
//       'name': 'Hockey',
//       'icon': Icons.sports_hockey,
//       'gradient': [Color(0xFFff6b6b), Color(0xFFee5a24)],
//       'emoji': '🏒',
//     },
//     {
//       'name': 'Basketball',
//       'icon': Icons.sports_basketball,
//       'gradient': [Color(0xFFf093fb), Color(0xFFf5576c)],
//       'emoji': '🏀',
//     },
//   ];

//   final Map<String, List<Map<String, dynamic>>> playersData = {
//     'Football': [
//       {
//         'name': 'Lionel Messi',
//         'team': 'Inter Miami',
//         'points': 2850,
//         'goals': 45,
//         'assists': 28,
//         'matches': 38,
//         'trend': 'up',
//         'change': '+125',
//       },
//       {
//         'name': 'Cristiano Ronaldo',
//         'team': 'Al Nassr',
//         'points': 2720,
//         'goals': 52,
//         'assists': 15,
//         'matches': 40,
//         'trend': 'up',
//         'change': '+98',
//       },
//       {
//         'name': 'Kylian Mbappé',
//         'team': 'PSG',
//         'points': 2650,
//         'goals': 38,
//         'assists': 22,
//         'matches': 35,
//         'trend': 'down',
//         'change': '-42',
//       },
//       {
//         'name': 'Erling Haaland',
//         'team': 'Manchester City',
//         'points': 2580,
//         'goals': 42,
//         'assists': 18,
//         'matches': 36,
//         'trend': 'up',
//         'change': '+85',
//       },
//       {
//         'name': 'Kevin De Bruyne',
//         'team': 'Manchester City',
//         'points': 2450,
//         'goals': 15,
//         'assists': 35,
//         'matches': 32,
//         'trend': 'stable',
//         'change': '+12',
//       },
//     ],
//     'Cricket': [
//       {
//         'name': 'Virat Kohli',
//         'team': 'RCB',
//         'points': 3200,
//         'runs': 1250,
//         'centuries': 8,
//         'matches': 45,
//         'trend': 'up',
//         'change': '+156',
//       },
//       {
//         'name': 'Babar Azam',
//         'team': 'Pakistan',
//         'points': 3150,
//         'runs': 1180,
//         'centuries': 7,
//         'matches': 42,
//         'trend': 'up',
//         'change': '+132',
//       },
//       {
//         'name': 'Kane Williamson',
//         'team': 'New Zealand',
//         'points': 2950,
//         'runs': 1050,
//         'centuries': 6,
//         'matches': 38,
//         'trend': 'down',
//         'change': '-28',
//       },
//       {
//         'name': 'Steve Smith',
//         'team': 'Australia',
//         'points': 2880,
//         'runs': 980,
//         'centuries': 5,
//         'matches': 35,
//         'trend': 'stable',
//         'change': '+8',
//       },
//       {
//         'name': 'Joe Root',
//         'team': 'England',
//         'points': 2820,
//         'runs': 920,
//         'centuries': 5,
//         'matches': 40,
//         'trend': 'up',
//         'change': '+75',
//       },
//     ],
//     'Hockey': [
//       {
//         'name': 'Connor McDavid',
//         'team': 'Edmonton Oilers',
//         'points': 3500,
//         'goals': 55,
//         'assists': 85,
//         'matches': 75,
//         'trend': 'up',
//         'change': '+189',
//       },
//       {
//         'name': 'Nathan MacKinnon',
//         'team': 'Colorado Avalanche',
//         'points': 3350,
//         'goals': 48,
//         'assists': 78,
//         'matches': 72,
//         'trend': 'up',
//         'change': '+145',
//       },
//       {
//         'name': 'Leon Draisaitl',
//         'team': 'Edmonton Oilers',
//         'points': 3200,
//         'goals': 52,
//         'assists': 68,
//         'matches': 70,
//         'trend': 'down',
//         'change': '-35',
//       },
//       {
//         'name': 'David Pastrnak',
//         'team': 'Boston Bruins',
//         'points': 3100,
//         'goals': 58,
//         'assists': 55,
//         'matches': 68,
//         'trend': 'up',
//         'change': '+92',
//       },
//       {
//         'name': 'Erik Karlsson',
//         'team': 'San Jose Sharks',
//         'points': 2950,
//         'goals': 25,
//         'assists': 75,
//         'matches': 65,
//         'trend': 'stable',
//         'change': '+15',
//       },
//     ],
//     'Basketball': [
//       {
//         'name': 'LeBron James',
//         'team': 'Lakers',
//         'points': 4200,
//         'ppg': 28.5,
//         'assists': 8.2,
//         'matches': 72,
//         'trend': 'up',
//         'change': '+225',
//       },
//       {
//         'name': 'Stephen Curry',
//         'team': 'Warriors',
//         'points': 4050,
//         'ppg': 31.2,
//         'assists': 6.8,
//         'matches': 68,
//         'trend': 'up',
//         'change': '+198',
//       },
//       {
//         'name': 'Giannis Antetokounmpo',
//         'team': 'Bucks',
//         'points': 3950,
//         'ppg': 29.8,
//         'assists': 5.9,
//         'matches': 70,
//         'trend': 'down',
//         'change': '-45',
//       },
//       {
//         'name': 'Luka Dončić',
//         'team': 'Mavericks',
//         'points': 3850,
//         'ppg': 32.1,
//         'assists': 9.2,
//         'matches': 65,
//         'trend': 'up',
//         'change': '+165',
//       },
//       {
//         'name': 'Joel Embiid',
//         'team': '76ers',
//         'points': 3720,
//         'ppg': 33.5,
//         'assists': 4.2,
//         'matches': 60,
//         'trend': 'stable',
//         'change': '+22',
//       },
//     ],
//   };

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: sports.length, vsync: this);
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fabController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
    
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _slideAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
//     );
//     _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fabController, curve: Curves.bounceOut),
//     );

//     _animationController.forward();
//     _fabController.forward();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _animationController.dispose();
//     _fabController.dispose();
//     super.dispose();
//   }

//   void _refreshAnimation() {
//     _animationController.reset();
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0A0A),
//       extendBodyBehindAppBar: true,
//       appBar: _buildAppBar(),
//       body: Column(
//         children: [
//           const SizedBox(height: 120),
//           _buildAnimatedHeader(),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: sports.map((sport) {
//                 return _buildLeaderboardContent(sport['name']);
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: _buildAnimatedFAB(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: sports[selectedSport]['gradient'],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//       title: AnimatedBuilder(
//         animation: _fadeAnimation,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _slideAnimation.value,
//             child: Opacity(
//               opacity: _fadeAnimation.value,
//               child: Row(
//                 children: [
//                   Text(
//                     sports[selectedSport]['emoji'],
//                     style: const TextStyle(fontSize: 32),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Leaderboard',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w900,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       actions: [
//         AnimatedBuilder(
//           animation: _fadeAnimation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _slideAnimation.value,
//               child: IconButton(
//                 onPressed: _refreshAnimation,
//                 icon: const Icon(Icons.refresh_rounded, 
//                   color: Colors.white, size: 25),
//               ),
//             );
//           },
//         ),
//         AnimatedBuilder(
//           animation: _fadeAnimation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _slideAnimation.value,
//               child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isGridView = !isGridView;
//                   });
//                   _refreshAnimation();
//                 },
//                 icon: Icon(
//                   isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
//                   color: Colors.white, 
//                   size: 28,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildAnimatedHeader() {
//     return AnimatedBuilder(
//       animation: _fadeAnimation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
//           child: Opacity(
//             opacity: _fadeAnimation.value,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.generate(sports.length, (index) {
//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 300 + (index * 100)),
//                       curve: Curves.bounceOut,
//                       margin: const EdgeInsets.only(right: 16),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedSport = index;
//                             _tabController.animateTo(index);
//                           });
//                           _refreshAnimation();
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24, 
//                             vertical: 16,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: selectedSport == index
//                                 ? LinearGradient(
//                                     colors: sports[index]['gradient'],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   )
//                                 : null,
//                             color: selectedSport != index
//                                 ? Colors.grey[900]
//                                 : null,
//                             borderRadius: BorderRadius.circular(25),
//                             boxShadow: selectedSport == index
//                                 ? [
//                                     BoxShadow(
//                                       color: sports[index]['gradient'][0]
//                                           .withOpacity(0.4),
//                                       blurRadius: 15,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ]
//                                 : null,
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 sports[index]['emoji'],
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 sports[index]['name'],
//                                 style: TextStyle(
//                                   color: selectedSport == index
//                                       ? Colors.white
//                                       : Colors.grey[400],
//                                   fontSize: 16,
//                                   fontWeight: selectedSport == index
//                                       ? FontWeight.bold
//                                       : FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildLeaderboardContent(String sportName) {
//     final players = playersData[sportName] ?? [];
    
//     return AnimatedBuilder(
//       animation: _fadeAnimation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, 30 * (1 - _fadeAnimation.value)),
//           child: Opacity(
//             opacity: _fadeAnimation.value,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               child: isGridView 
//                   ? _buildGridView(players, sportName)
//                   : _buildListView(players, sportName),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildGridView(List<Map<String, dynamic>> players, String sport) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.85,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       itemCount: players.length,
//       itemBuilder: (context, index) {
//         return _buildGridPlayerCard(players[index], index + 1, sport);
//       },
//     );
//   }

//   Widget _buildListView(List<Map<String, dynamic>> players, String sport) {
//     return ListView.builder(
//       itemCount: players.length,
//       itemBuilder: (context, index) {
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 200 + (index * 100)),
//           curve: Curves.easeOutBack,
//           child: _buildListPlayerCard(players[index], index + 1, sport),
//         );
//       },
//     );
//   }

//   Widget _buildGridPlayerCard(Map<String, dynamic> player, int rank, String sport) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.grey[900]!,
//             Colors.grey[850]!,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: rank <= 3
//             ? Border.all(
//                 color: _getRankColor(rank),
//                 width: 2,
//               )
//             : null,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Rank and trend
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildRankBadge(rank),
//                 _buildTrendIndicator(player['trend']),
//               ],
//             ),
            
//             // Player Avatar
//             Container(
//               width: 50,
//               height: 60,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: sports[selectedSport]['gradient'],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: sports[selectedSport]['gradient'][0].withOpacity(0.4),
//                     blurRadius: 15,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   player['name'].split(' ').map((n) => n[0]).join(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Player Info
//             Column(
//               children: [
//                 Text(
//                   player['name'].split(' ')[0],
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   player['team'],
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey[400],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
            
//             // Points
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               // decoration: BoxDecoration(
//               //   color: Colors.black.withOpacity(0.3),
//               //   borderRadius: BorderRadius.circular(15),
//               // ),
//               child: Column(
//                 children: [
//                   Text(
//                     '${player['points']}',
//                     style: TextStyle(
//                       color: sports[selectedSport]['gradient'][0],
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13,
//                     ),
//                   ),
//                   // Text(
//                   //   'Points',
//                   //   style: TextStyle(
//                   //     fontSize: 10,
//                   //     color: Colors.grey[400],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildListPlayerCard(Map<String, dynamic> player, int rank, String sport) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.grey[900]!,
//             Colors.grey[850]!,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: rank <= 3
//             ? Border.all(
//                 color: _getRankColor(rank),
//                 width: 2,
//               )
//             : null,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             // Rank Badge
//             _buildRankBadge(rank),
//             const SizedBox(width: 16),
            
//             // Player Avatar
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: sports[selectedSport]['gradient'],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: sports[selectedSport]['gradient'][0].withOpacity(0.4),
//                     blurRadius: 15,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   player['name'].split(' ').map((n) => n[0]).join(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
            
//             // Player Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           player['name'],
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       _buildTrendIndicator(player['trend']),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     player['team'],
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[400],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildStatRow(player, sport),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Text(
//                         'Change: ',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       Text(
//                         player['change'],
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: player['change'].startsWith('+')
//                               ? Colors.green[400]
//                               : player['change'].startsWith('-')
//                                   ? Colors.red[400]
//                                   : Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
            
//             // Points
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: sports[selectedSport]['gradient'],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: sports[selectedSport]['gradient'][0].withOpacity(0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     '${player['points']}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Text(
//                     'Points',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRankBadge(int rank) {
//     return Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         gradient: rank <= 3
//             ? LinearGradient(
//                 colors: [
//                   _getRankColor(rank),
//                   _getRankColor(rank).withOpacity(0.7),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//             : null,
//         color: rank > 3 ? Colors.grey[700] : null,
//         shape: BoxShape.circle,
//         boxShadow: rank <= 3
//             ? [
//                 BoxShadow(
//                   color: _getRankColor(rank).withOpacity(0.4),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ]
//             : null,
//       ),
//       child: Center(
//         child: Text(
//           '#$rank',
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTrendIndicator(String trend) {
//     IconData icon;
//     Color color;
    
//     switch (trend) {
//       case 'up':
//         icon = Icons.trending_up_rounded;
//         color = Colors.green[400]!;
//         break;
//       case 'down':
//         icon = Icons.trending_down_rounded;
//         color = Colors.red[400]!;
//         break;
//       default:
//         icon = Icons.trending_flat_rounded;
//         color = Colors.grey[400]!;
//     }
    
//     return Container(
//       padding: const EdgeInsets.all(6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Icon(
//         icon,
//         color: color,
//         size: 16,
//       ),
//     );
//   }

//   Color _getRankColor(int rank) {
//     switch (rank) {
//       case 1:
//         return const Color(0xFFFFD700);
//       case 2:
//         return const Color(0xFFC0C0C0);
//       case 3:
//         return const Color(0xFFCD7F32);
//       default:
//         return Colors.grey[600]!;
//     }
//   }

//   Widget _buildStatRow(Map<String, dynamic> player, String sport) {
//     List<Widget> stats = [];
    
//     switch (sport) {
//       case 'Football':
//         stats = [
//           _buildStat('Goals', player['goals'].toString(), Icons.sports_soccer),
//           _buildStat('Assists', player['assists'].toString(), Icons.handshake),
//           _buildStat('Matches', player['matches'].toString(), Icons.calendar_today),
//         ];
//         break;
//       case 'Cricket':
//         stats = [
//           _buildStat('Runs', player['runs'].toString(), Icons.timeline),
//           _buildStat('100s', player['centuries'].toString(), Icons.star),
//           _buildStat('Matches', player['matches'].toString(), Icons.calendar_today),
//         ];
//         break;
//       case 'Hockey':
//         stats = [
//           _buildStat('Goals', player['goals'].toString(), Icons.sports_hockey),
//           _buildStat('Assists', player['assists'].toString(), Icons.handshake),
//           _buildStat('Games', player['matches'].toString(), Icons.calendar_today),
//         ];
//         break;
//       case 'Basketball':
//         stats = [
//           _buildStat('PPG', player['ppg'].toString(), Icons.sports_basketball),
//           _buildStat('APG', player['assists'].toString(), Icons.handshake),
//           _buildStat('Games', player['matches'].toString(), Icons.calendar_today),
//         ];
//         break;
//     }
    
//     return Row(
//       children: stats.take(3).map((stat) {
//         return Container(
//           margin: const EdgeInsets.only(right: 20),
//           child: stat,
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildStat(String label, String value, IconData icon) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           size: 14,
//           color: sports[selectedSport]['gradient'][0],
//         ),
//         const SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: Colors.grey[500],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildAnimatedFAB() {
//     return AnimatedBuilder(
//       animation: _fabAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _fabAnimation.value,
//           child: FloatingActionButton.extended(
//             onPressed: () {
//               // Add functionality like filtering, sorting, etc.
//             },
//             backgroundColor: sports[selectedSport]['gradient'][0],
//             elevation: 8,
//             icon: const Icon(Icons.tune_rounded, color: Colors.white),
//             label: const Text(
//               'Filter',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }
//     }