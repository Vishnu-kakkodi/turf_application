
import 'dart:ui';
import 'package:booking_application/provider/match_game_provider.dart';
import 'package:booking_application/views/team/select_bowlers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectOpeningBatsmanScreen extends StatefulWidget {
  final String matchId;

  const SelectOpeningBatsmanScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  State<SelectOpeningBatsmanScreen> createState() => _SelectOpeningBatsmanScreenState();
}

class _SelectOpeningBatsmanScreenState extends State<SelectOpeningBatsmanScreen> {
  String? _striker;
  String? _nonStriker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey, // transparent so blur is visible
      body: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3), // optional dark overlay
              ),
            ),
          ),

          // Centered Card (same UI)
          Center(
            child: Consumer<MatchGameProvider>(
              builder: (context, provider, child) {
                final players = provider.getBattingTeamPlayers();

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
                        "Select Opening Batsmen",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Striker
                      const Text("Striker", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Choose a striker',
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
                            _striker = value;
                            if (_nonStriker == value) {
                              _nonStriker = null;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Non-Striker
                      const Text("Non - Striker", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Choose a non - striker',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: players.where((p) => p != _striker).map((player) {
                          return DropdownMenuItem(
                            value: player,
                            child: Text(player),
                          );
                        }).toList(),
                        onChanged: _striker != null ? (value) {
                          setState(() {
                            _nonStriker = value;
                          });
                        } : null,
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
                              onPressed: (_striker != null && _nonStriker != null) ? () {
                                provider.setOpeningBatsmen(_striker!, _nonStriker!);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectBowlerScreen(matchId: widget.matchId),
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
