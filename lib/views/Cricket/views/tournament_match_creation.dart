import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTournamentMatchScreen extends StatefulWidget {
  final String tournamentId;
  final String tournamentName;

  const CreateTournamentMatchScreen({
    super.key,
    required this.tournamentId,
    required this.tournamentName,
  });

  @override
  State<CreateTournamentMatchScreen> createState() => _CreateTournamentMatchScreenState();
}

class _CreateTournamentMatchScreenState extends State<CreateTournamentMatchScreen> {
  final _oversController = TextEditingController(text: '20');

  String? _selectedTeam1Id;
  String? _selectedTeam2Id;
  String _selectedMatchType = 'T20';
  String _selectedMatchFormat = 'League';

  List<dynamic> _tournamentTeams = [];
  bool _isLoadingTeams = false;

  static const List<String> _matchTypes = ['T20', 'ODI', 'Test', 'T10'];
  static const List<String> _matchFormats = [
    'League',
    'Knockout',
    'Semi-Final',
    'Final',
    'Quarter-Final',
  ];

  final String userId = '6884add9466d0e6a78245550'; // Replace with actual user ID
  final String baseUrl = 'http://31.97.206.144:3081';

  @override
  void initState() {
    super.initState();
    _fetchTournamentTeams();
  }

  @override
  void dispose() {
    _oversController.dispose();
    super.dispose();
  }

  // Fetch tournament teams
  Future<void> _fetchTournamentTeams() async {
    setState(() => _isLoadingTeams = true);

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/tournamentsteams/${widget.tournamentId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _tournamentTeams = data['tournament']['teams'];
            _isLoadingTeams = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching tournament teams: $e');
      setState(() => _isLoadingTeams = false);
    }
  }

  // Create match API call
  Future<void> _createMatch() async {
    try {
      final body = {
        "team1": _selectedTeam1Id,
        "team2": _selectedTeam2Id,
        "overs": int.parse(_oversController.text.trim()),
        "matchFormat": _selectedMatchType,
        "matchType": _selectedMatchFormat,
        "tournamentId": widget.tournamentId,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/users/creatematch/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success']) {
          _showSnackBar('Match scheduled successfully!', isError: false);
          Navigator.pop(context, true); // Return true to indicate success
        } else {
          _showSnackBar('Error: ${data['message']}', isError: true);
        }
      } else {
        _showSnackBar('Failed to schedule match', isError: true);
      }
    } catch (e) {
      print('Error creating match: $e');
      _showSnackBar('Error scheduling match', isError: true);
    }
  }

  void _scheduleMatch() {
    if (_selectedTeam1Id == null || _selectedTeam1Id!.isEmpty) {
      _showSnackBar('Please select Team 1', isError: true);
      return;
    }

    if (_selectedTeam2Id == null || _selectedTeam2Id!.isEmpty) {
      _showSnackBar('Please select Team 2', isError: true);
      return;
    }

    if (_selectedTeam1Id == _selectedTeam2Id) {
      _showSnackBar('Please select different teams', isError: true);
      return;
    }

    String overs = _oversController.text.trim();
    if (overs.isEmpty || int.tryParse(overs) == null) {
      _showSnackBar('Please enter valid number of overs', isError: true);
      return;
    }

    _createMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Schedule Match',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoadingTeams
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tournament Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF2E7D32),
                          const Color(0xFF1B5E20),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.emoji_events,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tournament',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.tournamentName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_tournamentTeams.length} Teams Available',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Main Form Card
                  Container(
                    width: double.infinity,
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
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Match Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Team 1 Selection
                          const Text(
                            'Team 1',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTeamDropdown(
                            value: _selectedTeam1Id,
                            hint: 'Select Team 1',
                            excludeTeamId: _selectedTeam2Id,
                            onChanged: (value) {
                              setState(() => _selectedTeam1Id = value);
                            },
                          ),
                          const SizedBox(height: 24),

                          // VS Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey[300])),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2E7D32).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'VS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.grey[300])),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Team 2 Selection
                          const Text(
                            'Team 2',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTeamDropdown(
                            value: _selectedTeam2Id,
                            hint: 'Select Team 2',
                            excludeTeamId: _selectedTeam1Id,
                            onChanged: (value) {
                              setState(() => _selectedTeam2Id = value);
                            },
                          ),
                          const SizedBox(height: 32),

                          // Match Configuration Section
                          const Text(
                            'Match Configuration',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Match Format and Type
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Format',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _buildDropdown(
                                      value: _selectedMatchType,
                                      items: _matchTypes,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedMatchType = value!;
                                          switch (value) {
                                            case 'T20':
                                              _oversController.text = '20';
                                              break;
                                            case 'ODI':
                                              _oversController.text = '50';
                                              break;
                                            case 'T10':
                                              _oversController.text = '10';
                                              break;
                                            case 'Test':
                                              _oversController.text = '90';
                                              break;
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Match Type',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _buildDropdown(
                                      value: _selectedMatchFormat,
                                      items: _matchFormats,
                                      onChanged: (value) {
                                        setState(() => _selectedMatchFormat = value!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Overs
                          const Text(
                            'Overs',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _oversController,
                            hintText: '20',
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.pop(context),
                          isSecondary: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: _buildButton(
                          text: 'Schedule Match',
                          onPressed: _scheduleMatch,
                          isSecondary: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildTeamDropdown({
    required String? value,
    required String hint,
    required String? excludeTeamId,
    required Function(String?) onChanged,
  }) {
    final availableTeams = _tournamentTeams
        .where((team) => team['_id'] != excludeTeamId)
        .toList();

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.groups,
                  color: Colors.grey[400],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  hint,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[600],
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          items: availableTeams.isEmpty
              ? null
              : availableTeams.map((team) {
                  return DropdownMenuItem<String>(
                    value: team['_id'],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                            child: Text(
                              team['teamName'][0].toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xFF2E7D32),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  team['teamName'],
                                  style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (team['players'] != null)
                                  Text(
                                    '${team['players'].length} players',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          onChanged: availableTeams.isEmpty ? null : onChanged,
          selectedItemBuilder: (BuildContext context) {
            return availableTeams.map((team) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                      child: Text(
                        team['teamName'][0].toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        team['teamName'],
                        style: const TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[600],
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (BuildContext context) {
            return items.map((String item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required bool isSecondary,
  }) {
    return Container(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSecondary ? const Color(0xFFF5F5F5) : const Color(0xFF2E7D32),
          foregroundColor:
              isSecondary ? const Color(0xFF333333) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isSecondary ? 0 : 2,
          shadowColor: isSecondary ? Colors.transparent : const Color(0xFF2E7D32).withOpacity(0.3),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red : const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}