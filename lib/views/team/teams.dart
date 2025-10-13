import 'package:booking_application/views/Cricket/create_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:share_plus/share_plus.dart';

class ShowAllTeams extends StatefulWidget {
  final String userId;
  
  const ShowAllTeams({super.key, required this.userId});

  @override
  State<ShowAllTeams> createState() => _ShowAllTeamsState();
}

class _ShowAllTeamsState extends State<ShowAllTeams> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Sample teams data - Replace with API call
  List<Map<String, dynamic>> teams = [
    {
      '_id': '1',
      'teamName': 'Thunder Warriors',
      'category': {'name': 'Cricket'},
      'tournament': {'name': 'Summer Championship 2024'},
      'players': [
        {'name': 'John Doe', 'role': 'Batsman', 'subRole': 'Opening', 'designation': 'Captain'},
        {'name': 'Mike Smith', 'role': 'Bowler', 'subRole': 'Fast', 'designation': 'Vice Captain'},
        {'name': 'David Wilson', 'role': 'All Rounder', 'subRole': 'Medium Pace', 'designation': 'Player'},
        {'name': 'Chris Brown', 'role': 'Wicket Keeper', 'subRole': 'Right Hand', 'designation': 'Player'},
      ],
      'createdAt': '2024-01-15T10:30:00Z',
    },
    {
      '_id': '2',
      'teamName': 'Lightning Bolts',
      'category': {'name': 'Football'},
      'tournament': {'name': 'Winter League 2024'},
      'players': [
        {'name': 'Alex Johnson', 'role': 'Forward', 'subRole': 'Striker', 'designation': 'Captain'},
        {'name': 'Sam Wilson', 'role': 'Midfielder', 'subRole': 'Central', 'designation': 'Vice Captain'},
        {'name': 'Tom Davis', 'role': 'Defender', 'subRole': 'Centre Back', 'designation': 'Player'},
      ],
      'createdAt': '2024-01-20T14:15:00Z',
    },
    {
      '_id': '3',
      'teamName': 'Fire Dragons',
      'category': {'name': 'Basketball'},
      'tournament': {'name': 'City Championship'},
      'players': [
        {'name': 'James Miller', 'role': 'Guard', 'subRole': 'Point Guard', 'designation': 'Captain'},
        {'name': 'Robert Taylor', 'role': 'Forward', 'subRole': 'Power Forward', 'designation': 'Player'},
        {'name': 'Michael Brown', 'role': 'Center', 'subRole': 'Defensive', 'designation': 'Player'},
        {'name': 'Kevin Lee', 'role': 'Guard', 'subRole': 'Shooting Guard', 'designation': 'Player'},
        {'name': 'Andrew Clark', 'role': 'Forward', 'subRole': 'Small Forward', 'designation': 'Player'},
      ],
      'createdAt': '2024-01-10T09:45:00Z',
    }
  ];
  
  bool isLoading = false;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  
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
    // _loadTeams(); // Uncomment when you have the API endpoint
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }
  
  // Uncomment and modify this method when you have the API endpoint
  /*
  Future<void> _loadTeams() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/teams/${widget.userId}'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            teams = List<Map<String, dynamic>>.from(data['teams']);
          });
        }
      } else {
        _showErrorSnackBar('Failed to load teams');
      }
    } catch (e) {
      _showErrorSnackBar('Error loading teams: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  */
  
  void _shareTeamLink(String teamId, String teamName) {
    // final teamLink = 'https://yourapp.com/join-team/$teamId';
    // Share.share(
    //   'Join my team "$teamName"! Click this link to join: $teamLink',
    //   subject: 'Join Team - $teamName',
    // );
  }
  
  void _copyTeamLink(String teamId, String teamName) {
    final teamLink = 'https://yourapp.com/join-team/$teamId';
    Clipboard.setData(ClipboardData(text: teamLink));
    _showSuccessSnackBar('Team link copied to clipboard!');
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
  
  List<Map<String, dynamic>> get filteredTeams {
    if (searchQuery.isEmpty) {
      return teams;
    }
    return teams.where((team) {
      final teamName = team['teamName'].toLowerCase();
      final category = team['category']['name'].toLowerCase();
      final tournament = team['tournament']['name'].toLowerCase();
      final query = searchQuery.toLowerCase();
      
      return teamName.contains(query) || 
             category.contains(query) || 
             tournament.contains(query);
    }).toList();
  }
  
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }
  
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'cricket':
        return const Color(0xFF059669);
      case 'football':
        return const Color(0xFF4F46E5);
      case 'basketball':
        return const Color(0xFFDC2626);
      case 'volleyball':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF6B7280);
    }
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'cricket':
        return Icons.sports_cricket;
      case 'football':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'volleyball':
        return Icons.sports_volleyball;
      default:
        return Icons.sports;
    }
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(20),
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
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search teams, categories, tournaments...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF6B7280),
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.clear, color: Color(0xFF6B7280)),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> team, int index) {
    final category = team['category']['name'];
    final categoryColor = _getCategoryColor(category);
    final categoryIcon = _getCategoryIcon(category);
    final players = List<Map<String, dynamic>>.from(team['players']);
    final captain = players.firstWhere(
      (player) => player['designation'] == 'Captain',
      orElse: () => players.isNotEmpty ? players[0] : {'name': 'N/A'},
    );

    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  categoryColor.withOpacity(0.1),
                  categoryColor.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        categoryIcon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team['teamName'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 14,
                              color: categoryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'share') {
                          _shareTeamLink(team['_id'], team['teamName']);
                        } else if (value == 'copy') {
                          _copyTeamLink(team['_id'], team['teamName']);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'share',
                          child: Row(
                            children: [
                              Icon(Icons.share, size: 20, color: Color(0xFF6B7280)),
                              SizedBox(width: 12),
                              Text('Share Link'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'copy',
                          child: Row(
                            children: [
                              Icon(Icons.copy, size: 20, color: Color(0xFF6B7280)),
                              SizedBox(width: 12),
                              Text('Copy Link'),
                            ],
                          ),
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.more_vert,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 16,
                        color: categoryColor,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          team['tournament']['name'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF374151),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Team Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Total Players',
                        '${players.length}',
                        Icons.group,
                        const Color(0xFF4F46E5),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatItem(
                        'Captain',
                        captain['name'],
                        Icons.stars,
                        const Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Players Preview
                Row(
                  children: [
                    const Icon(
                      Icons.people,
                      size: 16,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Team Players',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Created: ${_formatDate(team['createdAt'])}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Players List
                Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  child: SingleChildScrollView(
                    child: Column(
                      children: players.take(3).map((player) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: categoryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    player['name'][0].toUpperCase(),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            player['name'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1F2937),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (player['designation'] == 'Captain')
                                          Container(
                                            margin: const EdgeInsets.only(left: 8),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDCFDF7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'C',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF059669),
                                              ),
                                            ),
                                          ),
                                        if (player['designation'] == 'Vice Captain')
                                          Container(
                                            margin: const EdgeInsets.only(left: 8),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDDD6FE),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'VC',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4F46E5),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      '${player['role']} • ${player['subRole']}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
                if (players.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '+${players.length - 3} more players',
                      style: TextStyle(
                        fontSize: 12,
                        color: categoryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                
                const SizedBox(height: 20),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _shareTeamLink(team['_id'], team['teamName']),
                        icon: const Icon(Icons.share, size: 16),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: categoryColor,
                          side: BorderSide(color: categoryColor),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _copyTeamLink(team['_id'], team['teamName']),
                        icon: const Icon(Icons.copy, size: 16),
                        label: const Text('Copy Link'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: categoryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.groups,
                size: 48,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Teams Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searchQuery.isEmpty 
                ? 'You haven\'t created any teams yet.'
                : 'No teams match your search criteria.',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTeamsList = filteredTeams;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'My Teams',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to Create Team screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTeam(userId: widget.userId)));
            },
            tooltip: 'Create New Team',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildSearchBar(),
            
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                  ),
                ),
              )
            else if (filteredTeamsList.isEmpty)
              Expanded(child: _buildEmptyState())
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // _loadTeams(); // Uncomment when API is ready
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: filteredTeamsList.length,
                    itemBuilder: (context, index) {
                      return _buildTeamCard(filteredTeamsList[index], index);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Navigate to Create Team screen
      //     // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTeam(userId: widget.userId)));
      //   },
      //   icon: const Icon(Icons.add),
      //   label: const Text('Create Team'),
      //   backgroundColor: const Color(0xFF4F46E5),
      //   foregroundColor: Colors.white,
      // ),
    );
  }
}