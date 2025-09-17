import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/provider/user_profile_provider.dart';
import 'package:booking_application/referearn/refer_earn.dart';
import 'package:booking_application/views/team/match_history.dart';
import 'package:booking_application/views/team/create_team.dart';
import 'package:booking_application/views/team/player_leader_board.dart';
import 'package:booking_application/views/team/player_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderBarScreen extends StatefulWidget {
  const SliderBarScreen({super.key});

  @override
  State<SliderBarScreen> createState() => _SliderBarScreenState();
}

class _SliderBarScreenState extends State<SliderBarScreen> {

  String? userId;

    @override
  void initState() {
    super.initState();
loadUserId();
  }


  void loadUserId() async{
          final currentUser = await UserPreferences.getUser();
          setState(() {
            userId = currentUser?.id.toString();
          });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with User Profile
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00BF8F), Color(0xFF00A67C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sreekanth Reddy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '7288509259',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'srikareddy4831@gmail.com',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: Container(
                color: const Color(0xFF2A2A2A),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    _buildMenuItem(
                      icon: Icons.emoji_events,
                      title: 'Add a Tournament/Series',
                      badge: 'FREE',
                      badgeColor: Colors.orange,
                    ),

                    // Create a Match - Direct navigation
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MatchesScreen()));
                      },
                      child: _buildMenuItem(
                        icon: Icons.sports_cricket,
                        title: 'Create a Match',
                        badgeColor: Colors.orange,
                      ),
                    ),

                    // Create a Team - Direct navigation
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  CreateTeam(userId: userId.toString(),)));
                      },
                      child: _buildMenuItem(
                        icon: Icons.group,
                        title: 'Create a Team',
                        badgeColor: Colors.orange,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerStats()));
                      },
                      child: _buildMenuItem(
                        icon: Icons.bar_chart,
                        title: 'Stats',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerLeaderBoard()));
                      },
                      child: _buildMenuItem(
                        icon: Icons.military_tech,
                        title: 'Player Leaderboard',
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.groups,
                      title: 'Team Leaderboard',
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ReferEarn()));
                      },
                      child: _buildMenuItem(
                        icon: Icons.redeem,
                        title: 'Refer and Earn',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? badge,
    Color? badgeColor,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white70,
          size: 24,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing ??
            (badge != null
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor ?? Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null),
      ),
    );
  }
}
