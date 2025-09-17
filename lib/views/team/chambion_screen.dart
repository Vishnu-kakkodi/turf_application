// cricket_championship_screen.dart
import 'package:booking_application/provider/match_game_provider.dart';
import 'package:booking_application/views/team/commendory_widget.dart';
import 'package:booking_application/views/team/inning_break_dialog.dart';
import 'package:booking_application/views/team/mvp_widget.dart';
import 'package:booking_application/views/team/next_bowler_dialog.dart';
import 'package:booking_application/views/team/scorecard_widget.dart';
import 'package:booking_application/views/team/select_batsman_dialog.dart';
import 'package:booking_application/views/team/wicket_dialog.dart';

import 'package:booking_application/views/team/match_over_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CricketChampionshipScreen extends StatefulWidget {
  final String matchId;

  const CricketChampionshipScreen({Key? key, required this.matchId})
      : super(key: key);

  @override
  State<CricketChampionshipScreen> createState() =>
      _CricketChampionshipScreenState();
}

class _CricketChampionshipScreenState extends State<CricketChampionshipScreen> {
  int _selectedTabIndex = 0; // 0=Live, 1=Scorecard, 2=Commentary, 3=MVP

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MatchGameProvider>(context, listen: false);
      provider.addListener(_onProviderUpdate);
    });
  }

  @override
  void dispose() {
    final provider = Provider.of<MatchGameProvider>(context, listen: false);
    provider.removeListener(_onProviderUpdate);
    super.dispose();
  }

  void _onProviderUpdate() {
    final provider = Provider.of<MatchGameProvider>(context, listen: false);

    // Check if over is complete and need to select next bowler
    if (provider.isOverComplete &&
        !provider.isInningsComplete &&
        !provider.isMatchComplete) {
      _showSelectNextBowlerDialog(provider);
    }

    // Check if innings is complete
    else if (provider.isInningsComplete &&
        !provider.isMatchComplete &&
        !provider.isSecondInnings) {
      _showInningsBreakDialog(provider);
    }

    // Check if match is complete
    else if (provider.isMatchComplete) {
      _showMatchOverDialog(provider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(Provider.of<MatchGameProvider>(context).isSecondInnings
            ? 'Cricket Championship - 2nd Innings'
            : 'Cricket Championship'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Consumer<MatchGameProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            provider.isSecondInnings
                                ? 'TEAM B INNINGS'
                                : 'TEAM A INNINGS',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            provider.isSecondInnings
                                ? '${provider.teamBScore}/${provider.teamBWickets}'
                                : '${provider.teamAScore}/${provider.teamAWickets}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (provider.isSecondInnings)
                            Text(
                              'Target: ${provider.target}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Overs',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            provider.getOversString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            provider.isSecondInnings ? 'Required RR' : 'Run Rate',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            provider.isSecondInnings
                                ? provider.getRequiredRunRate()
                                : provider.getRunRate(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: Consumer<MatchGameProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Tab bar
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    _buildTab('Live', 0),
                    _buildTab('Scorecard', 1),
                    _buildTab('Commentary', 2),
                    _buildTab('MVP', 3),
                  ],
                ),
              ),

              // Content based on selected tab
              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (_selectedTabIndex) {
                      case 0:
                        return _buildLiveContent(provider);
                      case 1:
                        return const ScorecardWidget();
                      case 2:
                        return const CommentaryWidget(
                          commentary: [
                            "0.3: Player B3 to Player A2, 3 Runs.",
                            "0.2: Player B3 to Player A2, 2 Runs.",
                            "0.1: Player B3 to Player A3, 1 Run.",
                          ],
                        );

                      case 3:
                        return const MvpLeaderboardWidget(
                          leaderboard: [
                            {"player": "Player A1", "points": 5},
                            {"player": "Player A2", "points": 1},
                          ],
                        ); // replace with your widget
                      default:
                        return const Center(child: Text("No screen found"));
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.lightBlue : Colors.white,
                  borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(
                  color: isSelected ? Colors.lightBlue : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoonContent() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This feature is under development',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveContent(MatchGameProvider provider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ON CREASE section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ON CREASE',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildBatsmanRow(provider.striker, provider.strikerRuns,
                    provider.strikerBalls, true),
                const SizedBox(height: 8),
                _buildBatsmanRow(provider.nonStriker, provider.nonStrikerRuns,
                    provider.nonStrikerBalls, false),
              ],
            ),
          ),

          // CURRENT BOWLER section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'CURRENT BOWLER: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      provider.currentBowler,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBowlerStat('OVERS', provider.getBowlerOvers()),
                    _buildBowlerStat('MAIDENS', '0'),
                    _buildBowlerStat('RUNS', provider.bowlerRuns.toString()),
                    _buildBowlerStat(
                        'WICKETS', provider.bowlerWickets.toString()),
                    _buildBowlerStat('ECON', provider.getBowlerEconomy()),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // THIS OVER section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THIS OVER',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: provider.currentOverBalls.map((ball) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _getBallColor(ball),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        ball,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Score buttons
          if (!provider.isMatchComplete && !provider.isInningsComplete)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildScoreButton('0', () => provider.addRuns(0)),
                      _buildScoreButton('1', () => provider.addRuns(1)),
                      _buildScoreButton('2', () => provider.addRuns(2)),
                      _buildScoreButton('3', () => provider.addRuns(3)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildScoreButton('4', () => provider.addRuns(4)),
                      _buildScoreButton('6', () => provider.addRuns(6)),
                      _buildScoreButton('Wide', () => provider.addWide()),
                      _buildScoreButton('No Ball', () => provider.addNoBall()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildScoreButton('Bye', () => provider.addBye()),
                      _buildScoreButton('Leg Bye', () => provider.addLegBye()),
                      _buildScoreButton(
                          'Wicket', () => _showWicketDialog(context, provider)),
                      _buildScoreButton('Undo', () => provider.undoLastBall()),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBatsmanRow(String name, int runs, int balls, bool isStriker) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              if (isStriker) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '★',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Text(
          '$runs ($balls)',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBowlerStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreButton(String text, VoidCallback onPressed) {
    Color backgroundColor;
    switch (text) {
      case '4':
        backgroundColor = const Color(0xFF2196F3); // Blue
        break;
      case '6':
        backgroundColor = const Color(0xFF4CAF50); // Green
        break;
      case 'Wide':
        backgroundColor = const Color(0xFFFF9800); // Orange
        break;
      case 'No Ball':
        backgroundColor = const Color(0xFFFF9800); // Orange
        break;
      case 'Wicket':
        backgroundColor = const Color(0xFFE53935); // Red
        break;
      case 'Undo':
        backgroundColor = const Color(0xFF795548); // Brown
        break;
      case 'Bye':
      case 'Leg Bye':
        backgroundColor = const Color(0xFF607D8B); // Blue Grey
        break;
      default:
        backgroundColor = const Color(0xFF2196F3); // Blue
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Color _getBallColor(String ball) {
    switch (ball) {
      case '4':
        return const Color(0xFF2196F3); // Blue
      case '6':
        return const Color(0xFF4CAF50); // Green
      case 'W':
        return const Color(0xFFE53935); // Red
      case 'Wd':
      case 'NB':
        return const Color(0xFFFF9800); // Orange
      default:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  void _showWicketDialog(BuildContext context, MatchGameProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WicketDialog(
        onWicketConfirmed: (wicketType, fielder) {
          provider.addWicket(wicketType, fielder);
          Navigator.pop(context);

          // Check if all wickets are down or if match is over
          if (!provider.isMatchComplete && !provider.isInningsComplete) {
            _showSelectBatsmanDialog(context, provider);
          }
        },
      ),
    );
  }

  void _showSelectBatsmanDialog(
      BuildContext context, MatchGameProvider provider) {
    final availableBatsmen = provider.getAvailableBatsmen();
    if (availableBatsmen.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SelectBatsmanDialog(
          availablePlayers: availableBatsmen,
          onBatsmanSelected: (batsman) {
            provider.setNewBatsman(batsman);
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void _showSelectNextBatsmanDialog(
      BuildContext context, MatchGameProvider provider) {
    final availableBatsmen = provider.getAvailableBatsmen();
    if (availableBatsmen.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SelectBatsmanDialog(
          availablePlayers: availableBatsmen,
          onBatsmanSelected: (batsman) {
            provider.setNewBatsman(batsman);
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void _showSelectNextBowlerDialog(MatchGameProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SelectNextBowlerDialog(
        availableBowlers: provider.getAvailableBowlers(),
        onBowlerSelected: (bowler, style) {
          provider.setNextBowler(bowler, style);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showInningsBreakDialog(MatchGameProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => InningsBreakDialog(
        targetRuns: provider.target,
        onStartChase: () {
          _showSelectBatsmanDialog(context, provider);
          provider.startSecondInnings();
        },
      ),
    );
  }

  void _showMatchOverDialog(MatchGameProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MatchOverDialog(
        winnerTeam: provider.getWinnerTeam(),
        winMargin: provider.getWinMargin(),
        onFinishAndExit: () {
          Navigator.pop(context); // Close dialog
          Navigator.pop(context); // Exit championship screen
        },
      ),
    );
  }
}
