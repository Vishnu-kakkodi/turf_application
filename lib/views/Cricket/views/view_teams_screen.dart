import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:booking_application/views/Cricket/providers/team_provider.dart';
import 'package:booking_application/views/Cricket/models/get_all_teams_model.dart';

class ViewTeamsScreen extends StatefulWidget {
  const ViewTeamsScreen({super.key});

  @override
  State<ViewTeamsScreen> createState() => _ViewTeamsScreenState();
}

class _ViewTeamsScreenState extends State<ViewTeamsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all teams when screen loads
    Future.microtask(() {
      Provider.of<TeamNewProvider>(context, listen: false).fetchAllTeams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<TeamNewProvider>(
          builder: (context, provider, child) {
            final teams = provider.allTeams;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Main Content Card
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Teams',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Teams List
                          if (provider.isFetchingTeams)
                            const Center(child: CircularProgressIndicator())
                          else if (teams.isEmpty)
                            _buildEmptyState()
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: teams.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildTeamCard(teams[index]),
                                );
                              },
                            ),

                          // Back Button
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF5F5F5),
                                foregroundColor: const Color(0xFF333333),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTeamCard(Teams team) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Name and Action Buttons
            Row(
              children: [
                Expanded(
                  child: Text(
                    team.teamName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // _buildActionButton(
                    //   icon: Icons.copy,
                    //   tooltip: 'Copy team details',
                    //   onPressed: () => _copyTeamDetails(team),
                    // ),
                    // const SizedBox(width: 8),
                    // _buildActionButton(
                    //   icon: Icons.share,
                    //   tooltip: 'Share team',
                    //   onPressed: () => _shareTeam(team),
                    // ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Players Count
            Text(
              '${team.players.length} Players',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // Players List (First 5 players with "and X more" if needed)
            _buildPlayersList(team.players.map((p) => p.name).toList()),
            const SizedBox(height: 12),

            // View Details Button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton(
                onPressed: () => _showTeamDetails(team),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF2E7D32),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'View All Players',
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF2E7D32).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 18,
          color: const Color(0xFF2E7D32),
        ),
        tooltip: tooltip,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildPlayersList(List<String> players) {
    const maxVisible = 5;
    final visiblePlayers = players.take(maxVisible).toList();
    final remainingCount = players.length - maxVisible;

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        ...visiblePlayers.map((player) => _buildPlayerChip(player)),
        if (remainingCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+$remainingCount more',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlayerChip(String playerName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2E7D32).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        playerName,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.groups_outlined,
            size: 64,
            color: const Color(0xFF666666),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Teams Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create your first team to get started',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _copyTeamDetails(Teams team) {
    final teamDetails = _formatTeamDetails(team);
    Clipboard.setData(ClipboardData(text: teamDetails));
    _showSnackBar('Team details copied to clipboard!');
  }

  void _shareTeam(Teams team) {
    // You can integrate share_plus package here
  }

  String _formatTeamDetails(Teams team) {
    final buffer = StringBuffer();
    buffer.writeln('🏏 ${team.teamName}');
    buffer.writeln('');
    buffer.writeln('Players:');
    for (int i = 0; i < team.players.length; i++) {
      buffer.writeln('${i + 1}. ${team.players[i].name}');
    }
    return buffer.toString();
  }

  void _showTeamDetails(Teams team) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF666666),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Team name
            Text(
              team.teamName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),

            // All players
            const Text(
              'Players:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),

            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: team.players.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            team.players[index].name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Action buttons
            // Row(
            //   children: [
            //     Expanded(
            //       child: OutlinedButton.icon(
            //         onPressed: () {
            //           Navigator.pop(context);
            //           _copyTeamDetails(team);
            //         },
            //         icon: const Icon(Icons.copy, size: 18),
            //         label: const Text('Copy'),
            //         style: OutlinedButton.styleFrom(
            //           foregroundColor: const Color(0xFF2E7D32),
            //           side: const BorderSide(color: Color(0xFF2E7D32)),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: ElevatedButton.icon(
            //         onPressed: () {
            //           Navigator.pop(context);
            //           _shareTeam(team);
            //         },
            //         icon: const Icon(Icons.share, size: 18),
            //         label: const Text('Share'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: const Color(0xFF2E7D32),
            //           foregroundColor: Colors.white,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //           elevation: 0,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
