import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTeam extends StatefulWidget {
  final String userId;
  
  const CreateTeam({super.key, required this.userId});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamNameController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Dropdown values
  String? selectedCategoryId;
  String? selectedTournamentId;
  
  // Lists for dropdowns
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> tournaments = [];
  
  // Players list
  List<Map<String, String>> players = [
    {'name': '', 'role': '', 'subRole': '', 'designation': ''}
  ];
  
  // Loading states
  bool isLoadingCategories = false;
  bool isLoadingTournaments = false;
  bool isCreatingTeam = false;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward();
    _loadCategories();
    _loadTournaments();
  }
  
  @override
  void dispose() {
    _teamNameController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  Future<void> _loadCategories() async {
    setState(() {
      isLoadingCategories = true;
    });
    
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/category/categories'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            categories = List<Map<String, dynamic>>.from(data['categories']);
          });
        }
      } else {
        _showErrorSnackBar('Failed to load categories');
      }
    } catch (e) {
      _showErrorSnackBar('Error loading categories: $e');
    } finally {
      setState(() {
        isLoadingCategories = false;
      });
    }
  }
  
  Future<void> _loadTournaments() async {
    setState(() {
      isLoadingTournaments = true;
    });
    
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/turnament/gettournaments'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            tournaments = List<Map<String, dynamic>>.from(data['tournaments']);
          });
        }
      } else {
        _showErrorSnackBar('Failed to load tournaments');
      }
    } catch (e) {
      _showErrorSnackBar('Error loading tournaments: $e');
    } finally {
      setState(() {
        isLoadingTournaments = false;
      });
    }
  }
  
  void _addPlayer() {
    setState(() {
      players.add({'name': '', 'role': '', 'subRole': '', 'designation': ''});
    });
  }
  
  void _removePlayer(int index) {
    if (players.length > 1) {
      setState(() {
        players.removeAt(index);
      });
    }
  }
  
  Future<void> _createTeam() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    // Validate players
    for (int i = 0; i < players.length; i++) {
      if (players[i]['name']!.trim().isEmpty || 
          players[i]['role']!.trim().isEmpty ||
          players[i]['subRole']!.trim().isEmpty ||
          players[i]['designation']!.trim().isEmpty) {
        _showErrorSnackBar('Please fill all player details');
        return;
      }
    }
    
    if (selectedCategoryId == null) {
      _showErrorSnackBar('Please select category and tournament');
      return;
    }
    
    setState(() {
      isCreatingTeam = true;
    });
    
    try {
      final payload = {
        "teamName": _teamNameController.text.trim(),
        "categoryId": selectedCategoryId,
        "tournamentId": selectedTournamentId,
        "players": players.map((player) => {
          "name": player['name']!.trim(),
          "role": player['role']!.trim(),
          "subRole": player['subRole']!.trim(),
          "designation": player['designation']!.trim()
        }).toList(),
      };
      
      final response = await http.post(
        Uri.parse('http://31.97.206.144:3081/users/createteams/${widget.userId}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      print("Response Body: ${response.body}");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessSnackBar('Team created successfully!');
        Navigator.pop(context, true);
      } else {
        final errorData = json.decode(response.body);
        _showErrorSnackBar(errorData['message'] ?? 'Failed to create team');
      }
    } catch (e) {
      _showErrorSnackBar('Error creating team: $e');
    } finally {
      setState(() {
        isCreatingTeam = false;
      });
    }
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFE53E3E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF38A169),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (iconColor ?? const Color(0xFF4F46E5)).withOpacity(0.1),
                  (iconColor ?? const Color(0xFF4F46E5)).withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor ?? const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF1F2937),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF6B7280),
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE53E3E)),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required IconData icon,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    required String? Function(T?) validator,
    bool isLoading = false,
  }) {
    return Column(
      children: [
        DropdownButtonFormField<T>(
          value: value,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1F2937),
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF6B7280),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          items: isLoading ? [] : items,
          onChanged: isLoading ? null : onChanged,
          validator: validator,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
          isExpanded: true,
          menuMaxHeight: 300,
        ),
        if (isLoading)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }




  Widget _buildDropdownn<T>({
    required String label,
    required IconData icon,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    bool isLoading = false,
  }) {
    return Column(
      children: [
        DropdownButtonFormField<T>(
          value: value,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1F2937),
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF6B7280),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          items: isLoading ? [] : items,
          onChanged: isLoading ? null : onChanged,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
          isExpanded: true,
          menuMaxHeight: 300,
        ),
        if (isLoading)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  


  Widget _buildPlayerCard(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Player ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              if (players.length > 1)
                IconButton(
                  onPressed: () => _removePlayer(index),
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Color(0xFFE53E3E),
                    size: 20,
                  ),
                  tooltip: 'Remove Player',
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: players[index]['name'],
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    players[index]['name'] = value;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: players[index]['role'],
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: 'Role',
                    labelStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    players[index]['role'] = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: players[index]['subRole'],
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: 'Sub Role',
                    labelStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    players[index]['subRole'] = value;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: players[index]['designation'],
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: 'Designation',
                    labelStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    players[index]['designation'] = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Create Team',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Team Information Section
                _buildSectionCard(
                  title: 'Team Information',
                  icon: Icons.groups,
                  child: _buildTextField(
                    controller: _teamNameController,
                    label: 'Team Name',
                    icon: Icons.group,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter team name';
                      }
                      return null;
                    },
                  ),
                ),

                // Category & Tournament Section
                _buildSectionCard(
                  title: 'Category & Tournament',
                  icon: Icons.emoji_events,
                  iconColor: const Color(0xFF059669),
                  child: Column(
                    children: [
                      _buildDropdown<String>(
                        label: 'Select Category',
                        icon: Icons.category,
                        value: selectedCategoryId,
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['_id'],
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                category['name'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategoryId = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        isLoading: isLoadingCategories,
                      ),
                      const SizedBox(height: 20),
                      _buildDropdownn<String>(
                        label: 'Select Tournament(Optional)',
                        icon: Icons.emoji_events,
                        value: selectedTournamentId,
                        items: tournaments.map((tournament) {
                          return DropdownMenuItem<String>(
                            value: tournament['_id'],
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                tournament['name'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedTournamentId = value;
                          });
                        },
                        isLoading: isLoadingTournaments,
                      ),
                    ],
                  ),
                ),

                // Players Section
                _buildSectionCard(
                  title: 'Team Players (${players.length})',
                  icon: Icons.sports,
                  iconColor: const Color(0xFFDC2626),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: players.length,
                        itemBuilder: (context, index) => _buildPlayerCard(index),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _addPlayer,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add Another Player'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF059669),
                            side: const BorderSide(color: Color(0xFF059669)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Create Team Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isCreatingTeam ? null : _createTeam,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: isCreatingTeam
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Creating Team...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'Create Team',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}