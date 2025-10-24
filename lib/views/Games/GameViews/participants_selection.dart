
// participant_selection_screen.dart
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Games/GameViews/Football/game_selection.dart';
import 'package:booking_application/views/Games/GameViews/games_view_screen.dart' hide Team, GameProvider;
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ParticipantSelectionScreen extends StatefulWidget {
  final SportConfig sportConfig;
  final int? setFormat;
  final String? categoryId;

  const ParticipantSelectionScreen({
    super.key,
    required this.sportConfig,
    this.setFormat,
    this.categoryId,
  });

  @override
  State<ParticipantSelectionScreen> createState() => _ParticipantSelectionScreenState();
}

class _ParticipantSelectionScreenState extends State<ParticipantSelectionScreen> {
  final TextEditingController _nameController = TextEditingController();
  final List<Team> teams = [];
  final List<String> players = [];
  
  List<dynamic> _searchResults = [];
  bool _isSearching = false;
  final Uuid _uuid = const Uuid();
  Timer? _debounce;
  
  bool? isTeamModeSelected;
  bool showGameModeSelection = false;

  static const String baseUrl = 'http://31.97.206.144:3081';
     String? userId; 


  @override
  void initState() {
    super.initState();
            _loadUserId();

    final sportName = widget.sportConfig.displayName.toLowerCase();
    showGameModeSelection = sportName == 'badminton' || sportName == 'tennis';
  }

          void _loadUserId() async {
    final user = await UserPreferences.getUser();
    if (user != null) {
      userId = user.id;
    } 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/searchusers?search=$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final filteredResults = (data['users'] as List)
              .where((user) => !players.contains(user['name']))
              .toList();

          setState(() {
            _searchResults = filteredResults;
            _isSearching = false;
          });
        }
      } else {
        setState(() {
          _searchResults.clear();
          _isSearching = false;
        });
      }
    } catch (e) {
      print('Error searching users: $e');
      setState(() {
        _searchResults.clear();
        _isSearching = false;
      });
    }
  }

  Future<void> _searchTeams(String query) async {
    if (query.isEmpty || widget.categoryId == null) {
      setState(() {
        _searchResults.clear();
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getteambycat/${widget.categoryId}?teamName=$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final existingTeamNames = teams.map((t) => t.name).toList();
          final filteredResults = (data['teams'] as List)
              .where((team) => !existingTeamNames.contains(team['teamName']))
              .toList();

          setState(() {
            _searchResults = filteredResults;
            _isSearching = false;
          });
        }
      } else {
        setState(() {
          _searchResults.clear();
          _isSearching = false;
        });
      }
    } catch (e) {
      print('Error searching teams: $e');
      setState(() {
        _searchResults.clear();
        _isSearching = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final isTeamBased = isTeamModeSelected ?? widget.sportConfig.isTeamBased;
      if (isTeamBased) {
        _searchTeams(query);
      } else {
        _searchUsers(query);
      }
    });
  }

  // void _selectPlayer(Map<String, dynamic> user) {
  //   final playerName = user['name'] ?? '';
  //   if (!players.contains(playerName)) {
  //     setState(() {
  //       players.add(playerName);
  //       _nameController.clear();
  //       _searchResults.clear();
  //     });
  //   }
  // }

  // void _selectTeam(Map<String, dynamic> teamData) {
  //   final teamName = teamData['teamName'] ?? '';
  //   final teamId = teamData['_id'] ?? _uuid.v4();
  //   final playersList = teamData['players'] as List? ?? [];
    
  //   if (!teams.any((t) => t.name == teamName)) {
  //     setState(() {
  //       final team = Team(
  //         id: teamId,
  //         name: teamName,
  //         players: playersList.map((p) => p['name']?.toString() ?? '').toList(),
  //       );
  //       teams.add(team);
  //       _nameController.clear();
  //       _searchResults.clear();
  //     });
  //   }
  // }


  void _selectPlayer(Map<String, dynamic> user) {
  final playerName = user['name'] ?? '';
  if (!players.contains(playerName)) {
    if (players.length >= 2) {
      // Show toast message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only 2 players are allowed for this game mode'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    setState(() {
      players.add(playerName);
      _nameController.clear();
      _searchResults.clear();
    });
  }
}

void _selectTeam(Map<String, dynamic> teamData) {
  final teamName = teamData['teamName'] ?? '';
  final teamId = teamData['_id'] ?? _uuid.v4();
  final playersList = teamData['players'] as List? ?? [];
  
  if (!teams.any((t) => t.name == teamName)) {
    if (teams.length >= 2) {
      // Show toast message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only 2 teams are allowed for this game mode'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    setState(() {
      final team = Team(
        id: teamId,
        name: teamName,
        players: playersList.map((p) => p['name']?.toString() ?? '').toList(),
      );
      teams.add(team);
      _nameController.clear();
      _searchResults.clear();
    });
  }
}

void _addManualParticipant(bool isTeamBased) {
  if (_nameController.text.trim().isNotEmpty) {
    // Check if already reached limit
    if (isTeamBased && teams.length >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only 2 teams are allowed for this game mode'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (!isTeamBased && players.length >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only 2 players are allowed for this game mode'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    setState(() {
      if (isTeamBased) {
        final team = Team(
          id: _uuid.v4(),
          name: _nameController.text.trim(),
          players: [],
        );
        teams.add(team);
      } else {
        players.add(_nameController.text.trim());
      }
      _nameController.clear();
      _searchResults.clear();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    bool isTeamBased;
    if (showGameModeSelection) {
      isTeamBased = isTeamModeSelected == true;
    } else {
      isTeamBased = widget.sportConfig.isTeamBased;
    }
    
    final participantType = isTeamBased ? 'Team' : 'Player';
    final minParticipants = isTeamBased ? 2 : 2;
    final currentList = isTeamBased ? teams : players;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Setup: ${widget.sportConfig.displayName}',
          style: const TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showGameModeSelection && isTeamModeSelected == null) ...[
                _buildGameModeSelection(),
              ] else ...[
                _buildParticipantSelection(isTeamBased, participantType, currentList, minParticipants),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Game Mode',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Choose how you want to play ${widget.sportConfig.displayName}',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 32),
        
        _buildModeOption(
          title: 'Singles',
          subtitle: 'Individual players compete against each other',
          icon: Icons.person,
          isSelected: false,
          onTap: () {
            setState(() {
              isTeamModeSelected = false;
            });
          },
        ),
        
        const SizedBox(height: 16),
        
        _buildModeOption(
          title: widget.sportConfig.displayName == 'Badminton' ? 'Doubles' : 'Teams',
          subtitle: widget.sportConfig.displayName == 'Badminton' 
              ? 'Pairs of players compete against other pairs'
              : 'Teams compete against each other',
          icon: Icons.group,
          isSelected: false,
          onTap: () {
            setState(() {
              isTeamModeSelected = true;
            });
          },
        ),
      ],
    );
  }

  Widget _buildModeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D32).withOpacity(0.1) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF999999),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantSelection(bool isTeamBased, String participantType, List currentList, int minParticipants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showGameModeSelection) ...[
          GestureDetector(
            onTap: () {
              setState(() {
                isTeamModeSelected = null;
                teams.clear();
                players.clear();
              });
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios, size: 16, color: Color(0xFF2E7D32)),
                const Text(
                  'Back to mode selection',
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        
        if (showGameModeSelection) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isTeamBased 
                  ? (widget.sportConfig.displayName == 'Badminton' ? 'Doubles Mode' : 'Team Mode')
                  : 'Singles Mode',
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        
        Text(
          'Add ${participantType.toLowerCase()}s to get started.',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          '$participantType Name',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search ${participantType.toLowerCase()}...',
                      hintStyle: const TextStyle(color: Color(0xFF999999)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: _isSearching
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                                ),
                              ),
                            )
                          : null,
                    ),
                    onSubmitted: (_) => _addManualParticipant(isTeamBased),
                  ),
                ),
                // const SizedBox(width: 12),
                // Container(
                //   height: 52,
                //   width: 52,
                //   decoration: BoxDecoration(
                //     color: const Color(0xFF2E7D32),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: IconButton(
                //     onPressed: () => _addManualParticipant(isTeamBased),
                //     icon: const Icon(
                //       Icons.add,
                //       color: Colors.white,
                //       size: 24,
                //     ),
                //   ),
                // ),
              ],
            ),
            
            if (_searchResults.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(maxHeight: 250),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    
                    if (isTeamBased) {
                      final teamName = result['teamName'] ?? '';
                      final playerCount = (result['players'] as List?)?.length ?? 0;
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                          child: const Icon(
                            Icons.group,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                        ),
                        title: Text(
                          teamName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '$playerCount players',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        // trailing: const Icon(
                        //   Icons.add_circle,
                        //   color: Color(0xFF2E7D32),
                        //   size: 24,
                        // ),
                        // onTap: () => _selectTeam(result),
                        trailing: (isTeamBased && teams.length >= 2) || (!isTeamBased && players.length >= 2)
    ? Icon(
        Icons.block,
        color: Colors.grey,
        size: 24,
      )
    : const Icon(
        Icons.add_circle,
        color: Color(0xFF2E7D32),
        size: 24,
      ),
onTap: () {
  if ((isTeamBased && teams.length >= 2) || (!isTeamBased && players.length >= 2)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Only 2 ${isTeamBased ? 'teams' : 'players'} are allowed'),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
    return;
  }
  
  if (isTeamBased) {
    _selectTeam(result);
  } else {
    _selectPlayer(result);
  }
},
                      );
                    } else {
                      final name = result['name'] ?? '';
                      final email = result['email'] ?? '';
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: const TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          email,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.add_circle,
                          color: Color(0xFF2E7D32),
                          size: 24,
                        ),
                        onTap: () => _selectPlayer(result),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          '${participantType}s Added (${currentList.length})',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        
        SizedBox(
          height: 250,
          child: currentList.isEmpty
              ? const Center(
                  child: Text(
                    'No participants added yet.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF999999),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: currentList.length,
                  itemBuilder: (context, index) {
                    final participantName = isTeamBased
                        ? teams[index].name
                        : players[index];
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                participantName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _removeParticipant(index, isTeamBased),
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF666666),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
        if (currentList.length >= minParticipants)
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _startMatch(isTeamBased),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Match',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // void _addManualParticipant(bool isTeamBased) {
  //   if (_nameController.text.trim().isNotEmpty) {
  //     setState(() {
  //       if (isTeamBased) {
  //         final team = Team(
  //           id: _uuid.v4(),
  //           name: _nameController.text.trim(),
  //           players: [],
  //         );
  //         teams.add(team);
  //       } else {
  //         players.add(_nameController.text.trim());
  //       }
  //       _nameController.clear();
  //       _searchResults.clear();
  //     });
  //   }
  // }

  void _removeParticipant(int index, bool isTeamBased) {
    setState(() {
      if (isTeamBased) {
        teams.removeAt(index);
      } else {
        players.removeAt(index);
      }
    });
  }

  void _startMatch(bool isTeamBased) async {
    final matchProvider = Provider.of<GameProvider>(context, listen: false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
        ),
      ),
    );

    try {      
      String matchName;
      if (isTeamBased) {
        matchName = teams.map((t) => t.name).join(' vs ');
      } else {
        matchName = players.join(' vs ');
      }

      String scoringMethod;
      final sportName = widget.sportConfig.displayName.toLowerCase();
      if (sportName == 'football' || sportName == 'hockey') {
        scoringMethod = 'Goal Based';
      } else if (sportName == 'cricket') {
        scoringMethod = 'Run Based';
      } else if (sportName == 'badminton' || sportName == 'tennis' || sportName == 'volleyball') {
        scoringMethod = 'Set Based';
      } else {
        scoringMethod = 'Point Based';
      }

      final matchId = await matchProvider.createMatch(
        userId: userId.toString(),
        matchName: matchName,
        categoryId: widget.categoryId ?? '',
        scoringMethod: scoringMethod,
        isTeamBased: isTeamBased,
        players: isTeamBased ? null : players,
        teams: isTeamBased ? teams : null,
        type: 'friendly',
      );

      Navigator.of(context).pop();

      if (matchId != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewMatchScreen(initialTabIndex: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              matchProvider.error ?? 'Failed to create match',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// Add this class to handle match status display
class MatchStatusWidget extends StatelessWidget {
  final String status;
  final Color? color;
  final double? fontSize;

  const MatchStatusWidget({
    super.key,
    required this.status,
    this.color,
    this.fontSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    switch (status.toLowerCase()) {
      case 'upcoming':
        statusColor = Colors.orange;
        statusText = 'Upcoming';
        break;
      case 'live':
      case 'in-progress':
        statusColor = Colors.green;
        statusText = 'Live';
        break;
      case 'half-time':
        statusColor = Colors.blue;
        statusText = 'Half Time';
        break;
      case 'completed':
      case 'finished':
        statusColor = Colors.grey;
        statusText = 'Completed';
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = Colors.grey;
        statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: color ?? statusColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// // Update your ViewMatchScreen to display status properly
// class ViewMatchScreen extends StatelessWidget {
//   const ViewMatchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Match Details'),
//         backgroundColor: const Color(0xFF2E7D32),
//       ),
//       body: Consumer<GameProvider>(
//         builder: (context, gameProvider, child) {
//           final currentMatch = gameProvider.currentMatch;
          
//           if (currentMatch == null) {
//             return const Center(
//               child: Text('No match data available'),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Match Status
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         currentMatch.name ?? 'Match',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     MatchStatusWidget(
//                       status: currentMatch.status ?? 'upcoming',
//                       fontSize: 14,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
                
//                 // Sport Category
//                 if (currentMatch.categoryId != null)
//                   Text(
//                     'Sport: ${currentMatch.categoryId is Map ? currentMatch.categoryId['name'] : currentMatch.categoryId}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
                
//                 const SizedBox(height: 16),
                
//                 // Scoring Method
//                 Text(
//                   'Scoring: ${currentMatch.scoringMethod ?? 'Not specified'}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                   ),
//                 ),
                
//                 const SizedBox(height: 24),
                
//                 // Teams/Players Section
//                 if (currentMatch.gameMode == 'team' && currentMatch.teams != null)
//                   _buildTeamsSection(currentMatch.teams!)
//                 else if (currentMatch.players != null)
//                   _buildPlayersSection(currentMatch.players!),
                
//                 const SizedBox(height: 24),
                
//                 // Scores Section
//                 _buildScoresSection(currentMatch),
                
//                 const SizedBox(height: 24),
                
//                 // Match Time
//                 if (currentMatch.timeElapsed != null)
//                   Text(
//                     'Time Elapsed: ${currentMatch.timeElapsed} minutes',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
                
//                 const Spacer(),
                
//                 // Action Buttons based on status
//                 _buildActionButtons(currentMatch, gameProvider, context),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

  Widget _buildTeamsSection(List<dynamic> teams) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Teams',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...teams.map((team) {
          final teamName = team['teamId'] is Map ? team['teamId']['teamName'] : 'Team ${teams.indexOf(team) + 1}';
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '• $teamName',
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPlayersSection(List<dynamic> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Players',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...players.map((player) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '• $player',
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildScoresSection(dynamic currentMatch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scores',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        if (currentMatch.halfTimeScore != null)
          _buildScoreRow('Half Time', currentMatch.halfTimeScore),
        
        if (currentMatch.finalScore != null)
          _buildScoreRow('Final Score', currentMatch.finalScore),
        
        if (currentMatch.extraTimeScore != null)
          _buildScoreRow('Extra Time', currentMatch.extraTimeScore),
        
        if (currentMatch.penaltyScore != null)
          _buildScoreRow('Penalty', currentMatch.penaltyScore),
      ],
    );
  }

  Widget _buildScoreRow(String label, dynamic scoreData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '${scoreData['teamA'] ?? 0} - ${scoreData['teamB'] ?? 0}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(dynamic currentMatch, GameProvider gameProvider, BuildContext context) {
    final status = currentMatch.status?.toLowerCase() ?? 'upcoming';
    
    return Row(
      children: [
        if (status == 'upcoming')
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Start match logic
                gameProvider.updateMatchStatus(currentMatch.id, 'live');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Start Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        
        if (status == 'live')
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Half time logic
                gameProvider.updateMatchStatus(currentMatch.id, 'half-time');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Half Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        
        if (status == 'half-time')
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Resume match logic
                gameProvider.updateMatchStatus(currentMatch.id, 'live');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Resume Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        
        const SizedBox(width: 12),
        
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // End match logic
              gameProvider.updateMatchStatus(currentMatch.id, 'completed');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'End Match',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
