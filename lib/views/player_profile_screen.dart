// import 'package:flutter/material.dart';

// class PlayerProfileScreen extends StatefulWidget {
//   const PlayerProfileScreen({super.key});

//   @override
//   State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
// }

// class _PlayerProfileScreenState extends State<PlayerProfileScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _profileController;
//   late AnimationController _statsController;
//   late AnimationController _rewardsController;

//   late Animation<double> _profileAnimation;
//   late Animation<double> _statsAnimation;
//   late Animation<double> _rewardsAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _profileController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _statsController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _rewardsController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _profileAnimation = CurvedAnimation(
//       parent: _profileController,
//       curve: Curves.elasticOut,
//     );

//     _statsAnimation = CurvedAnimation(
//       parent: _statsController,
//       curve: Curves.bounceOut,
//     );

//     _rewardsAnimation = CurvedAnimation(
//       parent: _rewardsController,
//       curve: Curves.easeInOutBack,
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _profileController,
//       curve: Curves.easeOutCubic,
//     ));

//     _startAnimations();
//   }

//   void _startAnimations() async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     _profileController.forward();

//     await Future.delayed(const Duration(milliseconds: 400));
//     _statsController.forward();

//     await Future.delayed(const Duration(milliseconds: 600));
//     _rewardsController.forward();
//   }

//   @override
//   void dispose() {
//     _profileController.dispose();
//     _statsController.dispose();
//     _rewardsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1B2E),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'Player Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             SlideTransition(
//               position: _slideAnimation,
//               child: ScaleTransition(
//                 scale: _profileAnimation,
//                 child: _buildProfileSection(),
//               ),
//             ),
//             const SizedBox(height: 24),
//             ScaleTransition(
//               scale: _statsAnimation,
//               child: _buildStatisticsSection(),
//             ),
//             const SizedBox(height: 24),
//             ScaleTransition(
//               scale: _rewardsAnimation,
//               child: _buildRewardsSection(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileSection() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           AnimatedBuilder(
//             animation: _profileController,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: 1.0 + (_profileAnimation.value * 0.1),
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 4),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.3),
//                         blurRadius: 20,
//                         spreadRadius: 5,
//                       ),
//                     ],
//                   ),
//                   child: const CircleAvatar(
//                     radius: 56,
//                     backgroundImage: NetworkImage(
//                       'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=300&h=300&fit=crop&crop=face',
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Alex Johnson',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'Level 42 • Pro Player',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Column(
//             children: [
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('XP Progress', style: TextStyle(color: Colors.white70)),
//                   Text('8,750 / 10,000', style: TextStyle(color: Colors.white70)),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               AnimatedBuilder(
//                 animation: _profileController,
//                 builder: (context, child) {
//                   return LinearProgressIndicator(
//                     value: 0.875 * _profileAnimation.value,
//                     backgroundColor: Colors.white.withOpacity(0.3),
//                     valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatisticsSection() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2A2D3E),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Statistics',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//           GridView.count(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisCount: 2,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 16,
//             childAspectRatio: 1.5,
//             children: [
//               _buildStatCard('Games Played', '247', Icons.sports_esports, Colors.green),
//               _buildStatCard('Win Rate', '68%', Icons.emoji_events, Colors.orange),
//               _buildStatCard('Total Score', '156K', Icons.star, Colors.purple),
//               _buildStatCard('Rank', '#23', Icons.leaderboard, Colors.blue),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard(String title, String value, IconData icon, Color color) {
//     return AnimatedBuilder(
//       animation: _statsController,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _statsAnimation.value,
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: color.withOpacity(0.3)),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, color: color, size: 20),
//                 const SizedBox(height: 8),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: color,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 12,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildRewardsSection() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2A2D3E),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Rewards & Achievements',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...List.generate(4, (index) {
//             final rewards = [
//               {'title': 'First Victory', 'description': 'Won your first game', 'icon': Icons.military_tech, 'color': Colors.yellow},
//               {'title': 'Speed Demon', 'description': 'Completed 10 games in under 5 minutes', 'icon': Icons.flash_on, 'color': Colors.orange},
//               {'title': 'Perfectionist', 'description': 'Achieved 100% accuracy', 'icon': Icons.precision_manufacturing, 'color': Colors.blue},
//               {'title': 'Legendary', 'description': 'Reached Level 40', 'icon': Icons.auto_awesome, 'color': Colors.purple},
//             ];

//             return AnimatedBuilder(
//               animation: _rewardsController,
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(0, 50 * (1 - _rewardsAnimation.value)),
//                   child: Opacity(
//                     opacity: _rewardsAnimation.value.clamp(0.0, 1.0),
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: index < 3 ? 12 : 0),
//                       child: _buildRewardItem(
//                         rewards[index]['title'] as String,
//                         rewards[index]['description'] as String,
//                         rewards[index]['icon'] as IconData,
//                         rewards[index]['color'] as Color,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildRewardItem(String title, String description, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1B2E),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: color, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   description,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(
//             Icons.check_circle,
//             color: color,
//             size: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }







































import 'package:flutter/material.dart';

class PlayerProfileScreen extends StatefulWidget {
  final String playerName;
  final String sport; // 'football', 'basketball', 'general', etc.
  final int totalPoints;
  final Map<String, dynamic> sportStats; // Sport-specific stats

  const PlayerProfileScreen({
    super.key,
    this.playerName = 'Alex Johnson',
    this.sport = 'football',
    this.totalPoints = 2580,
    this.sportStats = const {
      'goals': 23,
      'assists': 15,
      'matches': 28,
      'yellowCards': 3,
      'redCards': 0,
      'minutesPlayed': 2340,
    },
  });

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _profileController;
  late AnimationController _statsController;
  late AnimationController _rewardsController;

  late Animation<double> _profileAnimation;
  late Animation<double> _statsAnimation;
  late Animation<double> _rewardsAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _profileController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _statsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rewardsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _profileAnimation = CurvedAnimation(
      parent: _profileController,
      curve: Curves.elasticOut,
    );

    _statsAnimation = CurvedAnimation(
      parent: _statsController,
      curve: Curves.bounceOut,
    );

    _rewardsAnimation = CurvedAnimation(
      parent: _rewardsController,
      curve: Curves.easeInOutBack,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _profileController,
      curve: Curves.easeOutCubic,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _profileController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _statsController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _rewardsController.forward();
  }

  @override
  void dispose() {
    _profileController.dispose();
    _statsController.dispose();
    _rewardsController.dispose();
    super.dispose();
  }

  // Get sport-specific icon
  IconData _getSportIcon() {
    switch (widget.sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'baseball':
        return Icons.sports_baseball;
      default:
        return Icons.sports;
    }
  }

  // Get sport-specific color scheme
  Color _getSportColor() {
    switch (widget.sport.toLowerCase()) {
      case 'football':
        return const Color(0xFF00C851); // Green for football
      case 'basketball':
        return const Color(0xFFFF8800); // Orange for basketball
      case 'tennis':
        return const Color(0xFF007BFF); // Blue for tennis
      default:
        return const Color(0xFF4A90E2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Player Profile - ${widget.sport.toUpperCase()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Icon(_getSportIcon(), color: _getSportColor(), size: 28),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _profileAnimation,
                child: _buildProfileSection(),
              ),
            ),
            const SizedBox(height: 24),
            ScaleTransition(
              scale: _statsAnimation,
              child: _buildPointsSection(),
            ),
            const SizedBox(height: 24),
            ScaleTransition(
              scale: _statsAnimation,
              child: _buildStatisticsSection(),
            ),
            const SizedBox(height: 24),
            ScaleTransition(
              scale: _rewardsAnimation,
              child: _buildRewardsSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_getSportColor(), _getSportColor().withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _profileController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_profileAnimation.value * 0.1),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 56,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=300&h=300&fit=crop&crop=face',
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            widget.playerName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Level 42 • ${widget.sport.toUpperCase()} Player',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('XP Progress', style: TextStyle(color: Colors.white70)),
                  Text('8,750 / 10,000', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _profileController,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: 0.875 * _profileAnimation.value,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFD700).withOpacity(0.3),
            const Color(0xFFFFA500).withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _statsController,
            builder: (context, child) {
              return Transform.scale(
                scale: _statsAnimation.value,
                child: const Icon(
                  Icons.stars,
                  color: Color(0xFFFFD700),
                  size: 40,
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Points',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              AnimatedBuilder(
                animation: _statsController,
                builder: (context, child) {
                  final animatedPoints = (widget.totalPoints * _statsAnimation.value).round();
                  return Text(
                    animatedPoints.toString(),
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D3E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.sport.toUpperCase()} Statistics',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: _buildSportSpecificStats(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSportSpecificStats() {
    if (widget.sport.toLowerCase() == 'football') {
      return [
        _buildStatCard('Goals', widget.sportStats['goals'].toString(), Icons.sports_soccer, Colors.green),
        _buildStatCard('Assists', widget.sportStats['assists'].toString(), Icons.person_add, Colors.blue),
        _buildStatCard('Matches', widget.sportStats['matches'].toString(), Icons.calendar_today, Colors.orange),
        _buildStatCard('Cards', '${widget.sportStats['yellowCards']}Y/${widget.sportStats['redCards']}R', Icons.credit_card, Colors.red),
      ];
    } else {
      // Generic stats for other sports
      return [
        _buildStatCard('Games', '247', Icons.sports_esports, Colors.green),
        _buildStatCard('Win Rate', '68%', Icons.emoji_events, Colors.orange),
        _buildStatCard('Score', '156K', Icons.star, Colors.purple),
        _buildStatCard('Rank', '#23', Icons.leaderboard, Colors.blue),
      ];
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return AnimatedBuilder(
      animation: _statsController,
      builder: (context, child) {
        return Transform.scale(
          scale: _statsAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRewardsSection() {
    List<Map<String, dynamic>> rewards = _getSportSpecificRewards();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D3E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rewards & Achievements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(rewards.length, (index) {
            return AnimatedBuilder(
              animation: _rewardsController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - _rewardsAnimation.value)),
                  child: Opacity(
                    opacity: _rewardsAnimation.value.clamp(0.0, 1.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: index < rewards.length - 1 ? 12 : 0),
                      child: _buildRewardItem(
                        rewards[index]['title'] as String,
                        rewards[index]['description'] as String,
                        rewards[index]['icon'] as IconData,
                        rewards[index]['color'] as Color,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSportSpecificRewards() {
    if (widget.sport.toLowerCase() == 'football') {
      return [
        {'title': 'First Goal', 'description': 'Scored your first goal', 'icon': Icons.sports_soccer, 'color': Colors.green},
        {'title': 'Hat-trick Hero', 'description': 'Scored 3 goals in one match', 'icon': Icons.star, 'color': Colors.yellow},
        {'title': 'Assist Master', 'description': 'Made 10+ assists this season', 'icon': Icons.person_add, 'color': Colors.blue},
        {'title': 'Clean Sheet', 'description': 'Kept 5 clean sheets', 'icon': Icons.shield, 'color': Colors.purple},
      ];
    } else {
      // Generic achievements
      return [
        {'title': 'First Victory', 'description': 'Won your first game', 'icon': Icons.military_tech, 'color': Colors.yellow},
        {'title': 'Speed Demon', 'description': 'Completed 10 games in under 5 minutes', 'icon': Icons.flash_on, 'color': Colors.orange},
        {'title': 'Perfectionist', 'description': 'Achieved 100% accuracy', 'icon': Icons.precision_manufacturing, 'color': Colors.blue},
        {'title': 'Legendary', 'description': 'Reached Level 40', 'icon': Icons.auto_awesome, 'color': Colors.purple},
      ];
    }
  }

  Widget _buildRewardItem(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }
}