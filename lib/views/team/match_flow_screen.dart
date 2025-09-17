// match_setup_flow.dart
import 'dart:ui';
import 'package:booking_application/provider/single_match_provider.dart';
import 'package:booking_application/views/team/chambion_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchSetupFlowScreen extends StatefulWidget {
  final String matchId;
  final String userId;

  const MatchSetupFlowScreen({
    Key? key,
    required this.matchId,
    required this.userId,
  }) : super(key: key);

  @override
  State<MatchSetupFlowScreen> createState() => _MatchSetupFlowScreenState();
}

class _MatchSetupFlowScreenState extends State<MatchSetupFlowScreen> {
  int _currentStep = 0;
  bool _isStartingMatch = false;
  
  // Step 0: Opening Batsmen
  String? _striker;
  String? _nonStriker;
  
  // Step 1: Bowler
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

  void _nextStep() {
    if (_currentStep == 0) {
      // Validate opening batsmen selection
      if (_striker != null && _nonStriker != null) {
        context.read<SingleMatchGameProvider>().setOpeningBatsmen(_striker!, _nonStriker!);
        setState(() {
          _currentStep = 1;
        });
      }
    } else if (_currentStep == 1) {
      // Validate bowler selection and start match
      if (_bowler != null && _bowlingStyle != null) {
        _startMatch();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _startMatch() async {
    setState(() {
      _isStartingMatch = true;
    });

    final provider = context.read<SingleMatchGameProvider>();
    provider.setBowler(_bowler!, _bowlingStyle!);

    final success = await provider.startMatch(widget.userId, widget.matchId);

    setState(() {
      _isStartingMatch = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CricketChampionshipScreen(matchId: widget.matchId),
        ),
      );
    } else {
      // Show error dialog
      _showErrorDialog(provider.error ?? 'Failed to start match');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          _buildStepCircle(0, 'Batsmen', _currentStep >= 0),
          Expanded(
            child: Container(
              height: 2,
              color: _currentStep >= 1 ? Colors.lightBlue : Colors.grey.shade300,
            ),
          ),
          _buildStepCircle(1, 'Bowler', _currentStep >= 1),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int stepIndex, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.lightBlue : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              '${stepIndex + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.lightBlue : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildOpeningBatsmenStep(SingleMatchGameProvider provider) {
    final players = provider.getBattingTeamPlayers();
    final battingTeamName = provider.matchData!.teams
        .firstWhere((team) => team.id == provider.getTeamIdByName(
            provider.electedTo == 'Bat' 
                ? provider.tossWinner! 
                : provider.getTeamNames().firstWhere((name) => name != provider.tossWinner)))
        .teamName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Opening Batsmen",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Batting Team: $battingTeamName",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
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
          value: _striker,
          items: players.map((player) {
            return DropdownMenuItem(
              value: player.name,
              child: Text('${player.name} (${player.role})'),
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
        const Text("Non-Striker", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Choose a non-striker',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          value: _nonStriker,
          items: players.where((p) => p.name != _striker).map((player) {
            return DropdownMenuItem(
              value: player.name,
              child: Text('${player.name} (${player.role})'),
            );
          }).toList(),
          onChanged: _striker != null ? (value) {
            setState(() {
              _nonStriker = value;
            });
          } : null,
        ),
      ],
    );
  }

  Widget _buildBowlerStep(SingleMatchGameProvider provider) {
    final players = provider.getBowlingTeamPlayers();
    final bowlingTeamName = provider.matchData!.teams
        .firstWhere((team) => team.id == provider.getTeamIdByName(
            provider.electedTo == 'Bowl' 
                ? provider.tossWinner! 
                : provider.getTeamNames().firstWhere((name) => name != provider.tossWinner)))
        .teamName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Opening Bowler",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Bowling Team: $bowlingTeamName",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16),

        // Bowler
        const Text("Bowler", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Choose a bowler',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          value: _bowler,
          items: players.map((player) {
            return DropdownMenuItem(
              value: player.name,
              child: Text('${player.name} (${player.role})'),
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
          value: _bowlingStyle,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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

          // Main content
          Center(
            child: Consumer<SingleMatchGameProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading || _isStartingMatch) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(32),
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
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          _isStartingMatch ? 'Starting Match...' : 'Loading...',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

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
                    children: [
                      // Step indicator
                      _buildStepIndicator(),
                      const SizedBox(height: 20),

                      // Step content
                      _currentStep == 0
                          ? _buildOpeningBatsmenStep(provider)
                          : _buildBowlerStep(provider),

                      const SizedBox(height: 24),

                      // Action buttons
                      Row(
                        children: [
                          if (_currentStep > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _previousStep,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Previous"),
                              ),
                            ),
                          if (_currentStep > 0) const SizedBox(width: 12),
                          
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
                              onPressed: _canProceed() ? _nextStep : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                _currentStep == 0 ? "Next" : "Start Match",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  bool _canProceed() {
    if (_currentStep == 0) {
      return _striker != null && _nonStriker != null;
    } else if (_currentStep == 1) {
      return _bowler != null && _bowlingStyle != null;
    }
    return false;
  }
}