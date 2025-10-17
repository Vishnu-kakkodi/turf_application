
// import 'package:flutter/material.dart';

// class CreateNewMatchScreen extends StatefulWidget {
//   const CreateNewMatchScreen({super.key});

//   @override
//   State<CreateNewMatchScreen> createState() => _CreateNewMatchScreenState();
// }

// class _CreateNewMatchScreenState extends State<CreateNewMatchScreen> {
//   final _oversController = TextEditingController(text: '20');
//   final _team1Controller = TextEditingController();
//   final _team2Controller = TextEditingController();

//   String? _selectedTeam1;
//   String? _selectedTeam2;
//   String _selectedMatchType = 'T20';
//   String _selectedMatchFormat = 'Friendly';

//   // Suggestion states (only for teams)
//   List<String> _filteredTeams1 = [];
//   List<String> _filteredTeams2 = [];
  
//   bool _showTeam1Suggestions = false;
//   bool _showTeam2Suggestions = false;

//   // Static data arrays
//   static const List<String> _teams = [
//     'Mumbai Indians',
//     'Chennai Super Kings',
//     'Royal Challengers Bangalore',
//     'Delhi Capitals',
//     'Kolkata Knight Riders',
//     'Punjab Kings',
//     'Rajasthan Royals',
//     'Sunrisers Hyderabad',
//     'Gujarat Titans',
//     'Lucknow Super Giants',
//     'Australia',
//     'India',
//     'England',
//     'Pakistan',
//     'South Africa',
//     'New Zealand',
//     'Bangladesh',
//     'Sri Lanka',
//     'West Indies',
//     'Afghanistan',
//   ];

//   static const List<String> _matchTypes = ['T20', 'ODI', 'Test', 'T10'];
//   static const List<String> _matchFormats = [
//     'Friendly',
//     'League',
//     'Tournament',
//     'Practice',
//     'International',
//     'Domestic'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _team1Controller.addListener(() => _onTeam1TextChanged());
//     _team2Controller.addListener(() => _onTeam2TextChanged());
//   }

//   @override
//   void dispose() {
//     _oversController.dispose();
//     _team1Controller.dispose();
//     _team2Controller.dispose();
//     super.dispose();
//   }

//   void _onTeam1TextChanged() {
//     String query = _team1Controller.text.toLowerCase().trim();
    
//     if (query.isEmpty) {
//       setState(() {
//         _showTeam1Suggestions = false;
//         _filteredTeams1 = [];
//       });
//       return;
//     }

//     List<String> filtered = _teams
//         .where((team) => 
//             team.toLowerCase().contains(query) && 
//             team != _selectedTeam2)
//         .take(5)
//         .toList();

//     setState(() {
//       _filteredTeams1 = filtered;
//       _showTeam1Suggestions = filtered.isNotEmpty;
//     });
//   }

//   void _onTeam2TextChanged() {
//     String query = _team2Controller.text.toLowerCase().trim();
    
//     if (query.isEmpty) {
//       setState(() {
//         _showTeam2Suggestions = false;
//         _filteredTeams2 = [];
//       });
//       return;
//     }

//     List<String> filtered = _teams
//         .where((team) => 
//             team.toLowerCase().contains(query) && 
//             team != _selectedTeam1)
//         .take(5)
//         .toList();

//     setState(() {
//       _filteredTeams2 = filtered;
//       _showTeam2Suggestions = filtered.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'Create a New Match',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2E7D32),
//                   letterSpacing: 0.5,
//                 ),
//               ),

//               const SizedBox(height: 80),

//               // Main Content Card
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: const Color(0xFFE0E0E0),
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Team Selection Row
//                       Row(
//                         children: [
//                           // Team 1
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Team 1',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xFF333333),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildSearchField(
//                                   controller: _team1Controller,
//                                   hintText: 'Search Team 1',
//                                   suggestions: _filteredTeams1,
//                                   showSuggestions: _showTeam1Suggestions,
//                                   onSuggestionTap: (value) => _selectTeam1(value),
//                                 ),
//                               ],
//                             ),
//                           ),

//                         ],
//                       ),
//                                                 const SizedBox(width: 16),
//                       //     // VS Text
//                       //     Align(
//                       //       alignment: Alignment.center,
//                       //       child: const Padding(
//                       //         padding: EdgeInsets.only(top: 20),
//                       //         child: Text(
//                       //           'VS',
//                       //           style: TextStyle(
//                       //             fontSize: 18,
//                       //             fontWeight: FontWeight.bold,
//                       //             color: Color(0xFF2E7D32),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       // const SizedBox(height: 16),

//                                             // Team Selection Row
//                       Row(
//                         children: [
//                          // Team 2
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Team 2',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xFF333333),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildSearchField(
//                                   controller: _team2Controller,
//                                   hintText: 'Search Team 2',
//                                   suggestions: _filteredTeams2,
//                                   showSuggestions: _showTeam2Suggestions,
//                                   onSuggestionTap: (value) => _selectTeam2(value),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       // Overs Section
//                       const Text(
//                         'Overs',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF333333),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       _buildTextField(
//                         controller: _oversController,
//                         hintText: '20',
//                         keyboardType: TextInputType.number,
//                       ),
//                       const SizedBox(height: 32),

//                       // Match Type and Format Row
//                       Row(
//                         children: [
//                           // Match Type
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Match Format',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xFF333333),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildDropdown(
//                                   value: _selectedMatchType,
//                                   hint: 'T20',
//                                   items: _matchTypes,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _selectedMatchType = value!;
//                                       // Auto-update overs based on match type
//                                       switch (value) {
//                                         case 'T20':
//                                           _oversController.text = '20';
//                                           break;
//                                         case 'ODI':
//                                           _oversController.text = '50';
//                                           break;
//                                         case 'T10':
//                                           _oversController.text = '10';
//                                           break;
//                                         case 'Test':
//                                           _oversController.text = '90';
//                                           break;
//                                       }
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           // Match Format
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Match Type',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xFF333333),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 _buildDropdown(
//                                   value: _selectedMatchFormat,
//                                   hint: 'Friendly',
//                                   items: _matchFormats,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _selectedMatchFormat = value!;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 48),

//                       // Bottom Buttons
//                       Row(
//                         children: [
//                           _buildButton(
//                             text: 'Back',
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             isSecondary: true,
//                           ),
//                           const SizedBox(width: 16),
//                           _buildButton(
//                             text: 'Schedule',
//                             onPressed: () {
//                               _scheduleMatch();
//                             },
//                             isSecondary: false,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String? value,
//     required String hint,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: const Color(0xFFE0E0E0),
//           width: 1,
//         ),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Text(
//             hint,
//             style: const TextStyle(
//               color: Color(0xFF999999),
//               fontSize: 16,
//             ),
//           ),
//           icon: const Icon(
//             Icons.keyboard_arrow_down,
//             color: Color(0xFF999999),
//           ),
//           isExpanded: true,
//           dropdownColor: Colors.white,
//           items: items.map((String item) {
//             return DropdownMenuItem<String>(
//               value: item,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   item,
//                   style: const TextStyle(
//                     color: Color(0xFF333333),
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: onChanged,
//           selectedItemBuilder: (BuildContext context) {
//             return items.map((String item) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       color: Color(0xFF333333),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchField({
//     required TextEditingController controller,
//     required String hintText,
//     required List<String> suggestions,
//     required bool showSuggestions,
//     required Function(String) onSuggestionTap,
//   }) {
//     return Column(
//       children: [
//         Container(
//           height: 56,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: const Color(0xFFE0E0E0),
//               width: 1,
//             ),
//           ),
//           child: TextField(
//             controller: controller,
//             style: const TextStyle(
//               color: Color(0xFF333333),
//               fontSize: 16,
//             ),
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: const TextStyle(
//                 color: Color(0xFF999999),
//                 fontSize: 16,
//               ),
//               suffixIcon: const Icon(
//                 Icons.search,
//                 color: Color(0xFF999999),
//               ),
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 16,
//               ),
//             ),
//           ),
//         ),
        
//         // Suggestions List
//         if (showSuggestions) ...[
//           const SizedBox(height: 4),
//           Container(
//             constraints: const BoxConstraints(maxHeight: 150),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: const Color(0xFFE0E0E0),
//                 width: 1,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const BouncingScrollPhysics(),
//               itemCount: suggestions.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () => onSuggestionTap(suggestions[index]),
//                   borderRadius: BorderRadius.circular(8),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12,
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.group,
//                           color: Color(0xFF2E7D32),
//                           size: 18,
//                         ),
//                         const SizedBox(width: 12),
//                         Text(
//                           suggestions[index],
//                           style: const TextStyle(
//                             color: Color(0xFF333333),
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     TextInputType? keyboardType,
//   }) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: const Color(0xFFE0E0E0),
//           width: 1,
//         ),
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: const TextStyle(
//           color: Color(0xFF333333),
//           fontSize: 16,
//         ),
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             color: Color(0xFF999999),
//             fontSize: 16,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton({
//     required String text,
//     required VoidCallback onPressed,
//     required bool isSecondary,
//   }) {
//     return Expanded(
//       child: Container(
//         height: 52,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             backgroundColor:
//                 isSecondary ? const Color(0xFFF5F5F5) : const Color(0xFF2E7D32),
//             foregroundColor:
//                 isSecondary ? const Color(0xFF333333) : Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 0,
//           ),
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _selectTeam1(String teamName) {
//     setState(() {
//       _selectedTeam1 = teamName;
//       _team1Controller.text = teamName;
//       _showTeam1Suggestions = false;
//       _filteredTeams1 = [];
//     });
//   }

//   void _selectTeam2(String teamName) {
//     setState(() {
//       _selectedTeam2 = teamName;
//       _team2Controller.text = teamName;
//       _showTeam2Suggestions = false;
//       _filteredTeams2 = [];
//     });
//   }

//   void _scheduleMatch() {
//     if (_selectedTeam1 == null || _selectedTeam1!.isEmpty) {
//       _showSnackBar('Please select Team 1');
//       return;
//     }

//     if (_selectedTeam2 == null || _selectedTeam2!.isEmpty) {
//       _showSnackBar('Please select Team 2');
//       return;
//     }

//     if (_selectedTeam1 == _selectedTeam2) {
//       _showSnackBar('Please select different teams');
//       return;
//     }

//     String overs = _oversController.text.trim();
//     if (overs.isEmpty || int.tryParse(overs) == null) {
//       _showSnackBar('Please enter valid number of overs');
//       return;
//     }

//     // Here you would typically save the match data
//     _showSnackBar('Match scheduled: $_selectedTeam1 vs $_selectedTeam2');

//     // Optional: Navigate to match details or back to home
//     Navigator.pop(context);
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: const Color(0xFF2E7D32),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
// }

















import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateNewMatchScreen extends StatefulWidget {
  const CreateNewMatchScreen({super.key});

  @override
  State<CreateNewMatchScreen> createState() => _CreateNewMatchScreenState();
}

class _CreateNewMatchScreenState extends State<CreateNewMatchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final _oversController = TextEditingController(text: '20');
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();

  String? _selectedTeam1;
  String? _selectedTeam2;
  String? _selectedTeam1Id;
  String? _selectedTeam2Id;
  String _selectedMatchType = 'T20';
  String _selectedMatchFormat = 'Friendly';

  // Tournament related
  String? _selectedTournamentId;
  String? _selectedTournamentName;
  List<dynamic> _tournaments = [];
  bool _isLoadingTournaments = false;

  // Suggestion states
  List<dynamic> _filteredTeams1 = [];
  List<dynamic> _filteredTeams2 = [];
  
  bool _showTeam1Suggestions = false;
  bool _showTeam2Suggestions = false;
  bool _isLoadingTeams1 = false;
  bool _isLoadingTeams2 = false;

  static const List<String> _matchTypes = ['T20', 'ODI', 'Test', 'T10'];
  static const List<String> _matchFormats = [
    'Friendly',
    'Practice',
  ];

  final String userId = '6884add9466d0e6a78245550'; // Replace with actual user ID
  final String baseUrl = 'http://31.97.206.144:3081';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _team1Controller.addListener(() => _onTeam1TextChanged());
    _team2Controller.addListener(() => _onTeam2TextChanged());
    _fetchTournaments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _oversController.dispose();
    _team1Controller.dispose();
    _team2Controller.dispose();
    super.dispose();
  }

  // Fetch all tournaments
  Future<void> _fetchTournaments() async {
    setState(() => _isLoadingTournaments = true);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/alltournaments'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _tournaments = data['tournaments'];
            _isLoadingTournaments = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching tournaments: $e');
      setState(() => _isLoadingTournaments = false);
    }
  }

  // Fetch teams based on search query (for Friendly Match)
  Future<void> _searchTeams(String query, bool isTeam1) async {
    if (query.isEmpty) {
      setState(() {
        if (isTeam1) {
          _filteredTeams1 = [];
          _showTeam1Suggestions = false;
        } else {
          _filteredTeams2 = [];
          _showTeam2Suggestions = false;
        }
      });
      return;
    }

    setState(() {
      if (isTeam1) {
        _isLoadingTeams1 = true;
      } else {
        _isLoadingTeams2 = true;
      }
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/allteams?search=$query'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            if (isTeam1) {
              _filteredTeams1 = data['teams']
                  .where((team) => team['_id'] != _selectedTeam2Id)
                  .toList();
              _showTeam1Suggestions = _filteredTeams1.isNotEmpty;
              _isLoadingTeams1 = false;
            } else {
              _filteredTeams2 = data['teams']
                  .where((team) => team['_id'] != _selectedTeam1Id)
                  .toList();
              _showTeam2Suggestions = _filteredTeams2.isNotEmpty;
              _isLoadingTeams2 = false;
            }
          });
        }
      }
    } catch (e) {
      print('Error searching teams: $e');
      setState(() {
        if (isTeam1) {
          _isLoadingTeams1 = false;
        } else {
          _isLoadingTeams2 = false;
        }
      });
    }
  }

  // Fetch tournament teams
  Future<void> _fetchTournamentTeams() async {
    if (_selectedTournamentId == null) return;

    setState(() {
      _isLoadingTeams1 = true;
      _isLoadingTeams2 = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/tournamentsteams/$_selectedTournamentId'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _filteredTeams1 = data['tournament']['teams'];
            _filteredTeams2 = data['tournament']['teams'];
            _isLoadingTeams1 = false;
            _isLoadingTeams2 = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching tournament teams: $e');
      setState(() {
        _isLoadingTeams1 = false;
        _isLoadingTeams2 = false;
      });
    }
  }

  void _onTeam1TextChanged() {
    if (_tabController.index == 0) {
      // Friendly Match - use search API
      _searchTeams(_team1Controller.text.trim(), true);
    }
  }

  void _onTeam2TextChanged() {
    if (_tabController.index == 0) {
      // Friendly Match - use search API
      _searchTeams(_team2Controller.text.trim(), false);
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
      };

      // Add tournamentId if it's a tournament match
      if (_tabController.index == 1 && _selectedTournamentId != null) {
        body["tournamentId"] = _selectedTournamentId!;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/users/creatematch/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success']) {
          _showSnackBar('Match scheduled successfully!');
          Navigator.pop(context);
        } else {
          _showSnackBar('Error: ${data['message']}');
        }
      } else {
        _showSnackBar('Failed to schedule match');
      }
    } catch (e) {
      print('Error creating match: $e');
      _showSnackBar('Error scheduling match');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    'Create a New Match',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tab Bar
                  Container(
  decoration: BoxDecoration(
    color: const Color(0xFF2E7D32), // Full-width green background
    borderRadius: BorderRadius.circular(12),
  ),
  child: TabBar(
    controller: _tabController,
    indicator: const BoxDecoration(), // 👈 removes underline completely
    indicatorColor: Colors.transparent,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white.withOpacity(0.7), // subtle contrast
    labelStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    onTap: (index) {
      // Reset selections when switching tabs
      setState(() {
        _selectedTeam1 = null;
        _selectedTeam2 = null;
        _selectedTeam1Id = null;
        _selectedTeam2Id = null;
        _team1Controller.clear();
        _team2Controller.clear();
        _showTeam1Suggestions = false;
        _showTeam2Suggestions = false;
      });
    },
    tabs: const [
      Tab(text: 'Cricket Match'),
      // Tab(text: 'Tournament'),
    ],
  ),
)

                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildFriendlyMatchTab(),
                  // _buildTournamentTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendlyMatchTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        width: double.infinity,
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
              // Team 1
              const Text(
                'Team 1',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              _buildSearchField(
                controller: _team1Controller,
                hintText: 'Search Team 1',
                suggestions: _filteredTeams1,
                showSuggestions: _showTeam1Suggestions,
                isLoading: _isLoadingTeams1,
                onSuggestionTap: (team) => _selectTeam1(team),
              ),
              const SizedBox(height: 16),

              // Team 2
              const Text(
                'Team 2',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              _buildSearchField(
                controller: _team2Controller,
                hintText: 'Search Team 2',
                suggestions: _filteredTeams2,
                showSuggestions: _showTeam2Suggestions,
                isLoading: _isLoadingTeams2,
                onSuggestionTap: (team) => _selectTeam2(team),
              ),
              const SizedBox(height: 24),

              // Overs
              const Text(
                'Overs',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _oversController,
                hintText: '20',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              // Match Type and Format
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Match Format',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _selectedMatchType,
                          hint: 'T20',
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _selectedMatchFormat,
                          hint: 'Friendly',
                          items: _matchFormats,
                          onChanged: (value) {
                            setState(() {
                              _selectedMatchFormat = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                children: [
                  _buildButton(
                    text: 'Back',
                    onPressed: () => Navigator.pop(context),
                    isSecondary: true,
                  ),
                  const SizedBox(width: 16),
                  _buildButton(
                    text: 'Schedule',
                    onPressed: _scheduleMatch,
                    isSecondary: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        width: double.infinity,
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
              // Tournament Selection
              const Text(
                'Select Tournament',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              _isLoadingTournaments
                  ? const Center(child: CircularProgressIndicator())
                  : _buildTournamentDropdown(),
              const SizedBox(height: 24),

              // Team 1
              Opacity(
                opacity: _selectedTournamentId != null ? 1.0 : 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Team 1',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTournamentTeamDropdown(
                      value: _selectedTeam1Id,
                      hint: 'Select Team 1',
                      enabled: _selectedTournamentId != null,
                      onChanged: (teamId) {
                        final team = _filteredTeams1.firstWhere(
                          (t) => t['_id'] == teamId,
                        );
                        setState(() {
                          _selectedTeam1Id = teamId;
                          _selectedTeam1 = team['teamName'];
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Team 2
              Opacity(
                opacity: _selectedTournamentId != null ? 1.0 : 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Team 2',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTournamentTeamDropdown(
                      value: _selectedTeam2Id,
                      hint: 'Select Team 2',
                      enabled: _selectedTournamentId != null,
                      onChanged: (teamId) {
                        final team = _filteredTeams2.firstWhere(
                          (t) => t['_id'] == teamId,
                        );
                        setState(() {
                          _selectedTeam2Id = teamId;
                          _selectedTeam2 = team['teamName'];
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Overs
              const Text(
                'Overs',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _oversController,
                hintText: '20',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              // Match Type and Format
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Match Format',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _selectedMatchType,
                          hint: 'T20',
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _selectedMatchFormat,
                          hint: 'Knockout',
                          items: _matchFormats,
                          onChanged: (value) {
                            setState(() {
                              _selectedMatchFormat = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                children: [
                  _buildButton(
                    text: 'Back',
                    onPressed: () => Navigator.pop(context),
                    isSecondary: true,
                  ),
                  const SizedBox(width: 16),
                  _buildButton(
                    text: 'Schedule',
                    onPressed: _scheduleMatch,
                    isSecondary: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentDropdown() {
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedTournamentId,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Select Tournament',
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: 16,
              ),
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF999999),
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          items: _tournaments.map((tournament) {
            return DropdownMenuItem<String>(
              value: tournament['_id'],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  tournament['name'],
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedTournamentId = value;
              _selectedTournamentName = _tournaments.firstWhere(
                (t) => t['_id'] == value,
              )['name'];
              // Reset team selections
              _selectedTeam1Id = null;
              _selectedTeam2Id = null;
              _selectedTeam1 = null;
              _selectedTeam2 = null;
            });
            // Fetch teams for selected tournament
            _fetchTournamentTeams();
          },
          selectedItemBuilder: (BuildContext context) {
            return _tournaments.map((tournament) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tournament['name'],
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
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

  Widget _buildTournamentTeamDropdown({
    required String? value,
    required String hint,
    required bool enabled,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              hint,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 16,
              ),
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: enabled ? const Color(0xFF999999) : const Color(0xFFCCCCCC),
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          items: enabled
              ? (_filteredTeams1.isEmpty
                  ? null
                  : _filteredTeams1.map((team) {
                      // Filter out already selected team
                      if ((value == _selectedTeam1Id && team['_id'] == _selectedTeam2Id) ||
                          (value == _selectedTeam2Id && team['_id'] == _selectedTeam1Id)) {
                        return null;
                      }
                      return DropdownMenuItem<String>(
                        value: team['_id'],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            team['teamName'],
                            style: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).whereType<DropdownMenuItem<String>>().toList())
              : null,
          onChanged: enabled ? onChanged : null,
          selectedItemBuilder: enabled
              ? (BuildContext context) {
                  return _filteredTeams1.map((team) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          team['teamName'],
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList();
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
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
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF999999),
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

  Widget _buildSearchField({
    required TextEditingController controller,
    required String hintText,
    required List<dynamic> suggestions,
    required bool showSuggestions,
    required bool isLoading,
    required Function(dynamic) onSuggestionTap,
  }) {
    return Column(
      children: [
        Container(
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
              suffixIcon: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const Icon(
                      Icons.search,
                      color: Color(0xFF999999),
                    ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
        
        // Suggestions List
        if (showSuggestions && !isLoading) ...[
          const SizedBox(height: 4),
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
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final team = suggestions[index];
                return InkWell(
                  onTap: () => onSuggestionTap(team),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.group,
                          color: Color(0xFF2E7D32),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                team['teamName'],
                                style: const TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (team['players'] != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  '${team['players'].length} players',
                                  style: const TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
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
          width: 1,
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
          hintStyle: const TextStyle(
            color: Color(0xFF999999),
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
    return Expanded(
      child: Container(
        height: 52,
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
            elevation: 0,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _selectTeam1(dynamic team) {
    setState(() {
      _selectedTeam1Id = team['_id'];
      _selectedTeam1 = team['teamName'];
      _team1Controller.text = team['teamName'];
      _showTeam1Suggestions = false;
      _filteredTeams1 = [];
    });
  }

  void _selectTeam2(dynamic team) {
    setState(() {
      _selectedTeam2Id = team['_id'];
      _selectedTeam2 = team['teamName'];
      _team2Controller.text = team['teamName'];
      _showTeam2Suggestions = false;
      _filteredTeams2 = [];
    });
  }

  void _scheduleMatch() {
    if (_tabController.index == 1 && _selectedTournamentId == null) {
      _showSnackBar('Please select a tournament');
      return;
    }

    if (_selectedTeam1Id == null || _selectedTeam1Id!.isEmpty) {
      _showSnackBar('Please select Team 1');
      return;
    }

    if (_selectedTeam2Id == null || _selectedTeam2Id!.isEmpty) {
      _showSnackBar('Please select Team 2');
      return;
    }

    if (_selectedTeam1Id == _selectedTeam2Id) {
      _showSnackBar('Please select different teams');
      return;
    }

    String overs = _oversController.text.trim();
    if (overs.isEmpty || int.tryParse(overs) == null) {
      _showSnackBar('Please enter valid number of overs');
      return;
    }

    // Call the API to create match
    _createMatch();
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