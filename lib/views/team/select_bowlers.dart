
import 'dart:ui';
import 'package:booking_application/provider/match_game_provider.dart';
import 'package:booking_application/views/team/chambion_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBowlerScreen extends StatefulWidget {
  final String matchId;

  const SelectBowlerScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  State<SelectBowlerScreen> createState() => _SelectBowlerScreenState();
}

class _SelectBowlerScreenState extends State<SelectBowlerScreen> {
  String? _bowler;
  String? _bowlingStyle;

  final List<String> _bowlingStyles = [
    'Fast',
    'Medium Fast',
    'Medium',
    'Off Spin',
    'Leg Spin',
    'Left Arm Orthodox',
    'Left Arm Chinaman',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey, // allow blur visibility
      body: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

          // Popup Card
          Center(
            child: Consumer<MatchGameProvider>(
              builder: (context, provider, child) {
                final players = provider.getBowlingTeamPlayers();

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Bowler",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Bowler
                      const Text("Bowler", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Choose a Player',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: players.map((player) {
                          return DropdownMenuItem(
                            value: player,
                            child: Text(player),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _bowler = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Bowling Style
                      const Text("Bowling Style", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Choose a style',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: _bowlingStyles.map((style) {
                          return DropdownMenuItem(
                            value: style,
                            child: Text(style),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _bowlingStyle = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Cancel"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (_bowler != null && _bowlingStyle != null) ? () {
                                provider.setBowler(_bowler!, _bowlingStyle!);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CricketChampionshipScreen(matchId: widget.matchId),
                                  ),
                                );
                              } : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      )
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
}
