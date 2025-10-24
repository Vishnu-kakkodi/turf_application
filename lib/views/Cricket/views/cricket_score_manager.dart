
import 'package:booking_application/views/Cricket/views/create_new_match.dart';
import 'package:booking_application/views/Cricket/views/create_new_team.dart';
import 'package:booking_application/views/Tournaments/TournamentViews/tournament.dart';
import 'package:booking_application/views/Cricket/views/view_matches_screen.dart';
import 'package:booking_application/views/Cricket/views/view_teams_screen.dart';
import 'package:flutter/material.dart';

class CricketScoreManagerScreen extends StatelessWidget {
  const CricketScoreManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header Section
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Cricket Score Manager',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Create teams, schedule matches, and track scores live.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              // Menu Cards
              Expanded(
                child: Column(
                  children: [
                    _buildMenuCard(
                      title: 'Create New Match',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateNewMatchScreen()));

                        print('Create New Match tapped');
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildMenuCard(
                      title: 'Create New Team',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateNewTeamScreen()));

                        print('Create New Team tapped');
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildMenuCard(
                      title: 'View Matches',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewMatchesScreen()));

                        print('View Matches tapped');
                      },
                    ),
                                        const SizedBox(height: 20),
                    _buildMenuCard(
                      title: 'View Teams',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewTeamsScreen()));

                        print('View Matches tapped');
                      },
                    ),
                    // const SizedBox(height: 20),
                    // _buildMenuCard(
                    //   title: 'View Tournaments',
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => TournamentHomeScreen()));

                    //     print('View Tournaments tapped');
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          hoverColor: const Color(0xFF2E7D32).withOpacity(0.05),
          splashColor: const Color(0xFF2E7D32).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF2E7D32),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example usage - you would typically put this in your main.dart or route handler
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket Score Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const CricketScoreManagerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}