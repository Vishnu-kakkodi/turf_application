import 'dart:io';

import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/modal/registration_model.dart';
import 'package:booking_application/provider/user_profile_provider.dart';
import 'package:booking_application/referearn/refer_earn.dart';
import 'package:booking_application/views/Cricket/cricket_score_manager.dart';
import 'package:booking_application/views/Cricket/match_history.dart';
import 'package:booking_application/views/Cricket/create_team.dart';
import 'package:booking_application/views/Games/choose_game_screen.dart';
import 'package:booking_application/views/Games/game_manager_screen.dart';
import 'package:booking_application/views/Games/scorecard_pro_screen.dart';
import 'package:booking_application/views/team/player_leader_board.dart';
import 'package:booking_application/views/team/player_stats.dart';
import 'package:booking_application/views/team/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderBarScreen extends StatefulWidget {
  const SliderBarScreen({super.key});

  @override
  State<SliderBarScreen> createState() => _SliderBarScreenState();
}

class _SliderBarScreenState extends State<SliderBarScreen> {
  String? userId;
    String? _localImagePath;


  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  void loadUserId() async {
    final currentUser = await UserPreferences.getUser();
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${currentUser?.id.toString()}");
    setState(() {
      userId = currentUser?.id.toString();
    });
  }


    ImageProvider _getProfileImage(UserProfileProvider provider) {
      print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${provider.currentUser?.profileImage}");
    // Priority: Local image > Network image > Default image
    if (_localImagePath != null && File(_localImagePath!).existsSync()) {
      return FileImage(File(_localImagePath!));
    } else if (provider.currentUser?.profileImage != null &&
        provider.currentUser!.profileImage!.isNotEmpty) {
      return NetworkImage(provider.currentUser!.profileImage!);
    } else {
      return const NetworkImage(
        'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
      );
    }
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
              child:  Column(
                children: [
                  const SizedBox(height: 20),
                  FutureBuilder<User?>(
                    future:  UserPreferences.getUser(),
                    builder: (context,snapshot){
                            String username = '';
                            String mobile = '';
                            String email = '';
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData &&
          snapshot.data != null) {
        username = snapshot.data!.name;
        mobile = snapshot.data!.mobile;
                email = snapshot.data!.email;

      }
                    return  Row(
                      children: [
                      Consumer<UserProfileProvider>(
                       builder: (context, provider, child) {
                        return  CircleAvatar(
                          radius: 50,
                          backgroundImage: _getProfileImage(provider),
                          onBackgroundImageError: (exception, stackTrace) {
                            // Handle image loading errors
                            setState(() {
                              _localImagePath = null;
                            });
                          },
                        );
                       }
                      ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                mobile,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                email,
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
                    );
                    }
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
                    // _buildMenuItem(
                    //   icon: Icons.emoji_events,
                    //   title: 'Add a Tournament/Series',
                    //   badge: 'FREE',
                    //   badgeColor: Colors.orange,
                    // ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CricketScoreManagerScreen()));
                      },
                      child: _buildMenuItem(
                        icon: Icons.sports_cricket,
                        title: 'Cricket Score Manager',
                        badgeColor: Colors.orange,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => 
                                GameManagerScreen()
                                    ));
                      },
                      child: _buildMenuItem(
                        icon: Icons.group,
                        title: 'Game Selection',
                        badgeColor: Colors.orange,
                      ),
                    ),

                    // Create a Match - Direct navigation
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const MatchesScreen()));
                    //   },
                    //   child: _buildMenuItem(
                    //     icon: Icons.sports_cricket,
                    //     title: 'Create a Match',
                    //     badgeColor: Colors.orange,
                    //   ),
                    // ),

                    // Create a Team - Direct navigation
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => CreateTeam(
                    //                   userId: userId.toString(),
                    //                 )));
                    //   },
                    //   child: _buildMenuItem(
                    //     icon: Icons.group,
                    //     title: 'Create a Team',
                    //     badgeColor: Colors.orange,
                    //   ),
                    // ),

                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ShowAllTeams(
                    //                   userId: userId.toString(),
                    //                 )));
                    //   },
                    //   child: _buildMenuItem(
                    //     icon: Icons.group,
                    //     title: 'Teams',
                    //     badgeColor: Colors.orange,
                    //   ),
                    // ),

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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReferEarn()));
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
