
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Cricket/models/team_model.dart';
import 'package:booking_application/views/Cricket/providers/team_provider.dart';
import 'package:booking_application/views/Cricket/services/team_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class CreateNewTeamScreen extends StatefulWidget {
  
  const CreateNewTeamScreen({
    super.key,
  });

  @override
  State<CreateNewTeamScreen> createState() => _CreateNewTeamScreenState();
}

class _CreateNewTeamScreenState extends State<CreateNewTeamScreen> {
  final _teamNameController = TextEditingController();
  final _playerController = TextEditingController();
  final List<String> _players = [];
  List<User> _filteredPlayers = [];
  bool _showSuggestions = false;
  bool _isSearching = false;
   String? userId; // Pass userId from login or previous screen


  final TeamService _teamService = TeamService();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _playerController.addListener(_onPlayerTextChanged);
  }

    void _loadUserId() async {
    final user = await UserPreferences.getUser();
    if (user != null) {
      userId = user.id;
    } 
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _playerController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onPlayerTextChanged() {
    String query = _playerController.text.trim();
    
    if (query.isEmpty) {
      setState(() {
        _showSuggestions = false;
        _filteredPlayers = [];
        _isSearching = false;
      });
      _debounce?.cancel();
      return;
    }

    // Cancel previous debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set searching state
    setState(() {
      _isSearching = true;
    });

    // Create new debounce timer (300ms delay)
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchUsers(query);
    });
  }

  Future<void> _searchUsers(String query) async {
    try {
      final response = await _teamService.searchUsers(query);
      
if(response.success){
        // Filter out already added players
      final filtered = response.users
          .where((user) => !_players.contains(user.name))
          .take(5)
          .toList();

      setState(() {
        _filteredPlayers = filtered;
        _showSuggestions = filtered.isNotEmpty;
        _isSearching = false;
      });
}else{
        _showSnackBar('No Users Found');

}
    } catch (e) {
      setState(() {
        _filteredPlayers = [];
        _showSuggestions = false;
        _isSearching = false;
      });
      _showSnackBar('Error searching users: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Align(
                        alignment: Alignment.center,
                        child: const Text(
                          'Create a New Team',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Team Name Section
                      const Text(
                        'Team Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _teamNameController,
                        hintText: 'e.g., Mumbai Indians',
                      ),
                      const SizedBox(height: 32),
                      
                      // Add Player Section
                      Row(
                        children: [
                          const Text(
                            'Add Players',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_players.length} players added',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Player Input with Suggestions
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _playerController,
                                  hintText: 'Search player name',
                                  suffix: _isSearching
                                      ? const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Color(0xFF2E7D32),
                                              ),
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              // const SizedBox(width: 12),
                              // Container(
                              //   height: 56,
                              //   width: 56,
                              //   child: ElevatedButton(
                              //     onPressed: _addPlayer,
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color(0xFF2E7D32),
                              //       foregroundColor: Colors.white,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(12),
                              //       ),
                              //       elevation: 0,
                              //       padding: EdgeInsets.zero,
                              //     ),
                              //     child: const Icon(
                              //       Icons.add,
                              //       size: 24,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          
                          // Suggestions List
                          if (_showSuggestions) ...[
                            const SizedBox(height: 8),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 200),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _filteredPlayers.length,
                                itemBuilder: (context, index) {
                                  final user = _filteredPlayers[index];
                                  return InkWell(
                                    onTap: () => _selectPlayer(user.name),
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Color(0xFF2E7D32),
                                            size: 18,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user.name,
                                                  style: const TextStyle(
                                                    color: Color(0xFF333333),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  user.mobile,
                                                  style: const TextStyle(
                                                    color: Color(0xFF666666),
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
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Players List
                      if (_players.isNotEmpty) ...[
                        const Text(
                          'Team Players',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _players.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2E7D32),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _players[index],
                                        style: const TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _removePlayer(index),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Color(0xFF999999),
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                      
                      // Bottom Buttons
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildButton(
                            text: 'Back',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            isSecondary: true,
                          ),
                          const SizedBox(width: 16),
                          _buildButton(
                            text: 'Save Team',
                            onPressed: () {
                              _saveTeam();
                            },
                            isSecondary: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24), // Extra padding at bottom
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    Widget? suffix,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: suffix,
        ),
        onSubmitted: (value) {
          if (controller == _playerController) {
            _addPlayer();
          }
        },
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required bool isSecondary,
  }) {
    return Expanded(
      child: Container(
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSecondary 
                ? const Color(0xFFF5F5F5) 
                : const Color(0xFF2E7D32),
            foregroundColor: isSecondary 
                ? const Color(0xFF333333) 
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Consumer<TeamNewProvider>(
            builder: (context, teamProvider, child) {
              if (!isSecondary && teamProvider.isCreatingTeam) {
                return const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }
              return Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _selectPlayer(String playerName) {
    _playerController.text = playerName;
    setState(() {
      _showSuggestions = false;
      _filteredPlayers = [];
    });
    _addPlayer();
  }

  void _addPlayer() {
    String playerName = _playerController.text.trim();
    
    if (playerName.isEmpty) {
      _showSnackBar('Please enter a player name');
      return;
    }
    
    if (_players.contains(playerName)) {
      _showSnackBar('Player already exists in the team');
      return;
    }
    
    setState(() {
      _players.add(playerName);
      _playerController.clear();
      _showSuggestions = false;
      _filteredPlayers = [];
    });
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  Future<void> _saveTeam() async {
    String teamName = _teamNameController.text.trim();

    if (teamName.isEmpty) {
      _showSnackBar('Please enter a team name');
      return;
    }

    if (_players.isEmpty) {
      _showSnackBar('Please add at least one player');
      return;
    }

    final teamProvider = Provider.of<TeamNewProvider>(context, listen: false);
    
    final success = await teamProvider.createTeam(
      userId: userId.toString(),
      teamName: teamName,
      playerNames: _players,
    );

    if (success) {
      _showSnackBar('Team "$teamName" created successfully with ${_players.length} players!');
      
      // Optional: Navigate back or to another screen
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else {
      _showSnackBar(teamProvider.errorMessage ?? 'Failed to create team');
    }
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