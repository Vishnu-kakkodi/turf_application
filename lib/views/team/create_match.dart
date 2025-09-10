import 'package:flutter/material.dart';

class CreateMatchForm extends StatefulWidget {
  const CreateMatchForm({super.key});

  @override
  State<CreateMatchForm> createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatchForm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _matchNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _playerNameController = TextEditingController();
  final _playertwoNameController = TextEditingController();
  final _manualPlayerNameController = TextEditingController();
  final _manualPlayertwoNameController = TextEditingController();
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();
  final _maxParticipantsController = TextEditingController();

  // Add controllers for manual team name entry
  final _team1NameController = TextEditingController();
  final _team2NameController = TextEditingController();
  final _newPlayerController = TextEditingController();
  final _searchController = TextEditingController();

  final _team1ActualNameController = TextEditingController();
  final _team2ActualNameController = TextEditingController();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? selectedSport;
  String? selectedMatchType;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isTeamSelected = false;
  bool isPlayerSelected = false;
  bool _isLoading = false;

  final List<String> sports = [
    'Football',
    'Basketball',
    'Cricket',
    'Tennis',
    'Volleyball',
    'Badminton',
    'Hockey',
    'Baseball',
    'Rugby',
    'Swimming',
  ];

  final List<String> matchTypes = [
    'Friendly Match',
    'Tournament',
    'League',
    'Championship',
    'Practice Session',
    'Scrimmage',
  ];

  List<String> teamPlayers = [
    'Alex Rodriguez',
    'Sarah Johnson',
    'Michael Chen',
    'Emma Wilson',
    'David Martinez',
    'Lisa Thompson',
    'Chris Anderson',
    'Maya Patel',
    'James Brown',
    'Sofia Garcia',
  ];

  List<String> filteredPlayers = [];

  @override
  void initState() {
    super.initState();
    filteredPlayers = List.from(teamPlayers);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _matchNameController.dispose();
    _locationController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _playerNameController.dispose();
    _team1Controller.dispose();
    _team2Controller.dispose();
    _team1NameController.dispose();
    _team2NameController.dispose();
    _maxParticipantsController.dispose();
    _newPlayerController.dispose();
    _searchController.dispose();
    _manualPlayerNameController.dispose();
    _team1ActualNameController.dispose();
    _team2ActualNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF2E5BBA),
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF2E5BBA),
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _filterPlayers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPlayers = List.from(teamPlayers);
      } else {
        filteredPlayers = teamPlayers
            .where(
                (player) => player.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showPlayerDropdown(TextEditingController controller, String teamName) {
    _searchController.clear();
    filteredPlayers = List.from(teamPlayers);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.grey.shade50,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E5BBA).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.group_add,
                            color: Color(0xFF2E5BBA),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Select Players for $teamName',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search Field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setDialogState(() {
                            _filterPlayers(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search players...',
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFF2E5BBA)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.maxFinite,
                      height: 250,
                      child: ListView.builder(
                        itemCount: filteredPlayers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    if (controller.text.isEmpty) {
                                      controller.text = filteredPlayers[index];
                                    } else {
                                      controller.text +=
                                          ', ${filteredPlayers[index]}';
                                    }
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: const Color(0xFF2E5BBA)
                                            .withOpacity(0.1),
                                        child: Text(
                                          filteredPlayers[index][0]
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: Color(0xFF2E5BBA),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          filteredPlayers[index],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF2D3748),
                                          ),
                                        ),
                                      ),
                                      // Show a small indicator if this is a newly added player
                                      if (![
                                        'Alex Rodriguez',
                                        'Sarah Johnson',
                                        'Michael Chen',
                                        'Emma Wilson',
                                        'David Martinez',
                                        'Lisa Thompson',
                                        'Chris Anderson',
                                        'Maya Patel',
                                        'James Brown',
                                        'Sofia Garcia'
                                      ].contains(filteredPlayers[index]))
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'New',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              color: Color(0xFF2E5BBA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddPlayerDialog() {
    _newPlayerController.clear();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E5BBA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_add,
                        color: Color(0xFF2E5BBA),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Add New Player',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _newPlayerController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Enter player name',
                    prefixIcon:
                        const Icon(Icons.person, color: Color(0xFF2E5BBA)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFF2E5BBA), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2E5BBA),
                            Color(0xFF1A4480),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_newPlayerController.text.trim().isNotEmpty) {
                            final newPlayerName =
                                _newPlayerController.text.trim();
                            setState(() {
                              _playerNameController.text = newPlayerName;
                              if (!teamPlayers.contains(newPlayerName)) {
                                teamPlayers.add(newPlayerName);
                                teamPlayers.sort();
                              }
                            });
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.white, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Added "$newPlayerName"',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to show preview popup
  void _showPreviewDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 15,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 600),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2E5BBA),
                        Color(0xFF1A4480),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.preview,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Match Preview',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPreviewSection('Basic Information', [
                          _buildPreviewItem(
                              'Match Name', _matchNameController.text),
                          _buildPreviewItem('Sport', selectedSport ?? ''),
                          _buildPreviewItem(
                              'Match Type', selectedMatchType ?? ''),
                        ]),
                        const SizedBox(height: 20),
                        _buildPreviewSection('Schedule', [
                          _buildPreviewItem(
                              'Date',
                              selectedDate != null
                                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                  : ''),
                          _buildPreviewItem(
                              'Time',
                              selectedTime != null
                                  ? selectedTime!.format(context)
                                  : ''),
                        ]),
                        const SizedBox(height: 20),
                        // if (isTeamSelected || isPlayerSelected) ...[
                        //   _buildPreviewSection('Participants', [
                        //     if (isTeamSelected) ...[
                        //       _buildPreviewItem(
                        //           'Team 1 Players', _team1Controller.text,
                        //           isMultiline: true),
                        //       _buildPreviewItem(
                        //           'Team 2 Players', _team2Controller.text,
                        //           isMultiline: true),
                        //     ],
                        //     if (isPlayerSelected)
                        //       _buildPreviewItem(
                        //           'Player Name', _playerNameController.text),
                        //   ]),
                        //   const SizedBox(height: 20),
                        // ],

                        if (isTeamSelected || isPlayerSelected) ...[
                          _buildPreviewSection('Participants', [
                            if (isTeamSelected) ...[
                              _buildPreviewItem('Team 1 Name',
                                  _team1ActualNameController.text),
                              _buildPreviewItem(
                                  'Team 1 Players', _team1Controller.text,
                                  isMultiline: true),
                              _buildPreviewItem('Team 2 Name',
                                  _team2ActualNameController.text),
                              _buildPreviewItem(
                                  'Team 2 Players', _team2Controller.text,
                                  isMultiline: true),
                            ],
                            if (isPlayerSelected) ...[
                              _buildPreviewItem(
                                  'Player 1', _playerNameController.text),
                              _buildPreviewItem(
                                  'Player 2', _playertwoNameController.text),
                            ]
                          ]),
                          const SizedBox(height: 20),
                        ],
                        _buildPreviewSection('Additional Details', [
                          _buildPreviewItem('Maximum Participants',
                              _maxParticipantsController.text),
                          _buildPreviewItem(
                              'Location', _locationController.text),
                          _buildPreviewItem('Amount', _amountController.text),
                          _buildPreviewItem(
                              'Description', _descriptionController.text,
                              isMultiline: true),
                        ]),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Color(0xFF2E5BBA)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xFF2E5BBA),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF2E5BBA),
                                Color(0xFF1A4480),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop(); // Close preview
                              await _createMatch(); // Create the match
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Confirm & Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
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
    );
  }

  Widget _buildPreviewSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF2E5BBA),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewItem(String label, String value,
      {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not specified' : value,
              style: TextStyle(
                fontSize: 14,
                color: value.isEmpty
                    ? Colors.grey.shade400
                    : const Color(0xFF2D3748),
                fontStyle: value.isEmpty ? FontStyle.italic : FontStyle.normal,
              ),
              maxLines: isMultiline ? null : 1,
              overflow: isMultiline ? null : TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Separate method for creating the match
  Future<void> _createMatch() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Match created successfully!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _addTeamName(TextEditingController nameController,
      TextEditingController teamController) {
    if (nameController.text.trim().isNotEmpty) {
      final newPlayerName = nameController.text.trim();

      setState(() {
        // Add to team controller
        if (teamController.text.isEmpty) {
          teamController.text = newPlayerName;
        } else {
          teamController.text += ', $newPlayerName';
        }

        // Add to teamPlayers list if not already present
        if (!teamPlayers.contains(newPlayerName)) {
          teamPlayers.add(newPlayerName);
          // Sort the list alphabetically for better organization
          teamPlayers.sort();
        }

        nameController.clear();
      });

      // Show confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'Added "$newPlayerName" to team and player list',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildAnimatedField({
    required Widget child,
    required int index,
  }) {
    // Calculate safe interval values to avoid exceeding 1.0
    final double startInterval = (index * 0.05).clamp(0.0, 0.8);
    final double endInterval = (startInterval + 0.2).clamp(0.2, 1.0);

    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.2 + (index * 0.02)),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _slideController,
            curve: Interval(
              startInterval,
              endInterval,
              curve: Curves.easeOutCubic,
            ),
          )),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: _fadeController,
              curve: Interval(
                startInterval,
                endInterval,
                curve: Curves.easeInOut,
              ),
            )),
            child: child!,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    String? hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        onTap: onTap,
        readOnly: readOnly,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF2D3748),
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E5BBA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2E5BBA),
              size: 20,
            ),
          ),
          suffixIcon: suffixIcon,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF2E5BBA),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required String label,
    required IconData icon,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String? Function(T?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        validator: validator,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF2D3748),
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E5BBA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2E5BBA),
              size: 20,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF2E5BBA),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFF2E5BBA),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF2E5BBA),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2D3748),
        title: const Text(
          'Create Match',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xFFF7FAFC),
              ],
            ),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Information Section
                _buildAnimatedField(
                  index: 0,
                  child: _buildSectionTitle('Basic Information'),
                ),
                const SizedBox(height: 16),

                _buildAnimatedField(
                  index: 1,
                  child: _buildTextField(
                    controller: _matchNameController,
                    label: 'Match Name',
                    icon: Icons.sports,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter match name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                _buildAnimatedField(
                  index: 2,
                  child: _buildDropdownField<String>(
                    label: 'Sport',
                    icon: Icons.sports_soccer,
                    value: selectedSport,
                    items: sports,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSport = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a sport';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                _buildAnimatedField(
                  index: 3,
                  child: _buildDropdownField<String>(
                    label: 'Match Type',
                    icon: Icons.category,
                    value: selectedMatchType,
                    items: matchTypes,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMatchType = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select match type';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Schedule Section
                _buildAnimatedField(
                  index: 4,
                  child: _buildSectionTitle('Schedule'),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildAnimatedField(
                        index: 5,
                        child: _buildTextField(
                          controller: TextEditingController(),
                          label: 'Date',
                          icon: Icons.calendar_today,
                          readOnly: true,
                          hintText: selectedDate != null
                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                              : 'Select Date',
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (selectedDate == null) {
                              return 'Please select a date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildAnimatedField(
                        index: 6,
                        child: _buildTextField(
                          controller: TextEditingController(),
                          label: 'Time',
                          icon: Icons.access_time,
                          readOnly: true,
                          hintText: selectedTime != null
                              ? selectedTime!.format(context)
                              : 'Select Time',
                          onTap: () => _selectTime(context),
                          validator: (value) {
                            if (selectedTime == null) {
                              return 'Please select a time';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Participants Section
                _buildAnimatedField(
                  index: 7,
                  child: _buildSectionTitle('Participants'),
                ),
                const SizedBox(height: 16),

                _buildAnimatedField(
                  index: 8,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text(
                            'Team Match',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                          subtitle: const Text('Organize teams for the match'),
                          value: 'team',
                          groupValue: isTeamSelected
                              ? 'team'
                              : (isPlayerSelected ? 'player' : null),
                          // onChanged: (String? value) {
                          //   setState(() {
                          //     isTeamSelected = value == 'team';
                          //     isPlayerSelected = false;
                          //     if (!isTeamSelected) {
                          //       _team1Controller.clear();
                          //       _team2Controller.clear();
                          //       _team1NameController.clear();
                          //       _team2NameController.clear();
                          //     }
                          //     if (isTeamSelected) {
                          //       _playerNameController.clear();
                          //     }
                          //   });
                          // },

                          onChanged: (String? value) {
                            setState(() {
                              isTeamSelected = value == 'team';
                              isPlayerSelected = false;
                              if (!isTeamSelected) {
                                _team1Controller.clear();
                                _team2Controller.clear();
                                _team1NameController.clear();
                                _team2NameController.clear();
                                _team1ActualNameController
                                    .clear(); 
                                _team2ActualNameController
                                    .clear(); 
                              }
                              if (isTeamSelected) {
                                _playerNameController.clear();
                                _playertwoNameController.clear();
                                _manualPlayerNameController.clear();
                                _manualPlayertwoNameController.clear();
                              }
                            });
                          },
                          activeColor: const Color(0xFF2E5BBA),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                        const Divider(height: 20),
                        RadioListTile<String>(
                          title: const Text(
                            'Individual Player',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                          subtitle: const Text('Single player registration'),
                          value: 'player',
                          groupValue: isTeamSelected
                              ? 'team'
                              : (isPlayerSelected ? 'player' : null),
                          onChanged: (String? value) {
                            setState(() {
                              isPlayerSelected = value == 'player';
                              isTeamSelected = false;
                              if (!isPlayerSelected) {
                                _playerNameController.clear();
                              }
                              if (isPlayerSelected) {
                                _team1Controller.clear();
                                _team2Controller.clear();
                                _team1NameController.clear();
                                _team2NameController.clear();
                              }
                            });
                          },
                          activeColor: const Color(0xFF2E5BBA),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),

                // Team Fields
                if (isTeamSelected) ...[
                  const SizedBox(height: 20),

                  _buildAnimatedField(
                    index: 9,
                    child: _buildTextField(
                      controller: _team1ActualNameController,
                      label: 'Team 1 Name',
                      icon: Icons.sports,
                      hintText: 'Enter team 1 name (e.g., Warriors, Eagles)',
                      validator: isTeamSelected
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter team 1 name';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // Team 1 Name Input
                  _buildAnimatedField(
                    index: 9,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildTextField(
                            controller: _team1NameController,
                            label: 'Enter Team 1 Player Name',
                            icon: Icons.person_add,
                            hintText: 'Type player name and press add',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF2E5BBA),
                                Color(0xFF1A4480),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () => _addTeamName(
                                _team1NameController, _team1Controller),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Team 1 Players Display
                  _buildAnimatedField(
                    index: 10,
                    child: _buildTextField(
                      controller: _team1Controller,
                      label: 'Team 1 Players',
                      icon: Icons.group,
                      maxLines: 2,
                      readOnly: true,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BBA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () =>
                              _showPlayerDropdown(_team1Controller, 'Team 1'),
                        ),
                      ),
                      validator: isTeamSelected
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please add team 1 players';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildAnimatedField(
                    index: 12,
                    child: _buildTextField(
                      controller: _team2ActualNameController,
                      label: 'Team 2 Name',
                      icon: Icons.sports,
                      hintText: 'Enter team 2 name (e.g., Lions, Sharks)',
                      validator: isTeamSelected
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter team 2 name';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),

                  // Team 2 Name Input
                  _buildAnimatedField(
                    index: 11,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildTextField(
                            controller: _team2NameController,
                            label: 'Enter Team 2 Player Name',
                            icon: Icons.person_add,
                            hintText: 'Type player name and press add',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF2E5BBA),
                                Color(0xFF1A4480),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () => _addTeamName(
                                _team2NameController, _team2Controller),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Team 2 Players Display
                  _buildAnimatedField(
                    index: 12,
                    child: _buildTextField(
                      controller: _team2Controller,
                      label: 'Team 2 Players',
                      icon: Icons.group,
                      maxLines: 2,
                      readOnly: true,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BBA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () =>
                              _showPlayerDropdown(_team2Controller, 'Team 2'),
                        ),
                      ),
                      validator: isTeamSelected
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please add team 2 players';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ],

                // Player Field
                if (isPlayerSelected) ...[
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildAnimatedField(
                    index: 13,
                    child: _buildTextField(
                      controller: _manualPlayerNameController,
                      label: 'Enter Player Name Manually',
                      icon: Icons.person_add,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BBA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            if (_manualPlayerNameController.text
                                .trim()
                                .isNotEmpty) {
                              setState(() {
                                _playerNameController.text =
                                    _manualPlayerNameController.text.trim();
                                // Also add to teamPlayers list if not already present
                                if (!teamPlayers.contains(
                                    _manualPlayerNameController.text.trim())) {
                                  teamPlayers.add(
                                      _manualPlayerNameController.text.trim());
                                  teamPlayers.sort();
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildAnimatedField(
                    index: 14,
                    child: _buildTextField(
                      controller: _playerNameController,
                      label: 'Selected Player',
                      icon: Icons.person,
                      readOnly: true,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BBA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            _showPlayerDropdown(
                                _playerNameController, 'Player');
                          },
                        ),
                      ),
                      validator: isPlayerSelected
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a player';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _buildAnimatedField(
                    index: 13,
                    child: _buildTextField(
                      controller: _manualPlayertwoNameController,
                      label: 'Enter Player Name Manually',
                      icon: Icons.person_add,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BBA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            if (_manualPlayertwoNameController.text
                                .trim()
                                .isNotEmpty) {
                              setState(() {
                                _playertwoNameController.text =
                                    _manualPlayertwoNameController.text.trim();
                                if (!teamPlayers.contains(
                                    _manualPlayertwoNameController.text
                                        .trim())) {
                                  teamPlayers.add(_manualPlayertwoNameController
                                      .text
                                      .trim());
                                  teamPlayers.sort();
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _buildAnimatedField(
                    index: 14,
                    child: _buildTextField(
                      controller: _playertwoNameController,
                      label: 'Selected Player',
                      icon: Icons.person,
                      readOnly: true,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BBA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            _showPlayerDropdown(
                                _playertwoNameController, 'Player');
                          },
                        ),
                      ),
                      validator: isPlayerSelected
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a player';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ],

                const SizedBox(height: 32),

                // Additional Details Section
                _buildAnimatedField(
                  index: 14,
                  child: _buildSectionTitle('Additional Details'),
                ),
                const SizedBox(height: 16),

                _buildAnimatedField(
                  index: 15,
                  child: _buildTextField(
                    controller: _maxParticipantsController,
                    label: 'Maximum Participants',
                    icon: Icons.people,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter maximum participants';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                _buildAnimatedField(
                  index: 16,
                  child: _buildTextField(
                    controller: _locationController,
                    label: 'Location',
                    icon: Icons.location_on,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                _buildAnimatedField(
                  index: 17,
                  child: _buildTextField(
                    controller: _amountController,
                    label: 'Amount',
                    icon: Icons.attach_money,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                _buildAnimatedField(
                  index: 18,
                  child: _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    icon: Icons.description,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),

                // Create Match Button
                _buildAnimatedField(
                  index: 19,
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2E5BBA),
                          Color(0xFF1A4480),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E5BBA).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                _showPreviewDialog();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Preview & Create',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
