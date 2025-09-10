// // ignore_for_file: deprecated_member_use

// import 'package:booking_application/views/team/create_new_team.dart';
// import 'package:flutter/material.dart';

// class CreateTeam extends StatefulWidget {
//   const CreateTeam({super.key});

//   @override
//   State<CreateTeam> createState() => _CreateTeamState();
// }

// class _CreateTeamState extends State<CreateTeam> {
//   String? selectedPlayerForMatch1;
//   String? selectedPlayerForMatch2;
//   String? selectedPlayerForMatch3;

//   // Sample match data
//   final List<Map<String, dynamic>> matches = [
//     {
//       'id': 1,
//       'name': 'Championship Final',
//       'sport': 'Football',
//       'date': '2024-09-15',
//       'time': '6:00 PM',
//       'location': 'City Stadium',
//       'type': 'Tournament',
//       'maxParticipants': 22,
//       'description': 'Annual championship final match between top teams.',
//       'link': 'https://example.com/match/1',
//       'players': ['Alex Rodriguez', 'Sarah Johnson', 'Michael Chen', 'Emma Wilson', 'David Martinez']
//     },
//     {
//       'id': 2,
//       'name': 'Cricket League Match',
//       'sport': 'Cricket',
//       'date': '2024-09-20',
//       'time': '2:00 PM',
//       'location': 'Sports Complex',
//       'type': 'League',
//       'maxParticipants': 22,
//       'description': 'Regular season league match for points.',
//       'link': 'https://example.com/match/2',
//       'players': ['Lisa Thompson', 'Chris Anderson', 'Maya Patel', 'James Brown', 'Sofia Garcia']
//     },
//     {
//       'id': 3,
//       'name': 'Basketball Friendly',
//       'sport': 'Basketball',
//       'date': '2024-09-25',
//       'time': '7:00 PM',
//       'location': 'Indoor Court',
//       'type': 'Friendly Match',
//       'maxParticipants': 10,
//       'description': 'Casual basketball game for practice and fun.',
//       'link': 'https://example.com/match/3',
//       'players': ['Alex Rodriguez', 'Michael Chen', 'David Martinez', 'Chris Anderson', 'James Brown']
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Available Matches',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(20),
//               itemCount: matches.length,
//               itemBuilder: (context, index) {
//                 final match = matches[index];
//                 return _buildMatchCard(match, index);
//               },
//             ),
//           ),

//           // Create New Team Button
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed: _createNewTeam,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00BF8F),
//                   elevation: 2,
//                   shadowColor: const Color(0xFF00BF8F).withOpacity(0.3),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child:const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                      Icon(
//                       Icons.add_circle_outline,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                      SizedBox(width: 8),
//                      Text(
//                       'Create New Team',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMatchCard(Map<String, dynamic> match, int index) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Match Header
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   _getSportColor(match['sport']),
//                   _getSportColor(match['sport']).withOpacity(0.8),
//                 ],
//               ),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     _getSportIcon(match['sport']),
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         match['name'],
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         '${match['sport']} • ${match['type']}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white.withOpacity(0.9),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     '${match['maxParticipants']} max',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Match Details
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Date, Time, Location
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildInfoRow(Icons.calendar_today, 'Date', match['date']),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: _buildInfoRow(Icons.access_time, 'Time', match['time']),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 _buildInfoRow(Icons.location_on, 'Location', match['location']),
                
//                 const SizedBox(height: 16),
                
//                 // Description
//                 Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   match['description'],
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                     height: 1.4,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Player Dropdown
//                 Text(
//                   'Select Player for this Match',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey[300]!),
//                   ),
//                   child: DropdownButtonFormField<String>(
//                     value: _getSelectedPlayer(index),
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.person, color: Colors.grey[500]),
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       hintText: 'Choose a player...',
//                     ),
//                     items: match['players'].map<DropdownMenuItem<String>>((player) {
//                       return DropdownMenuItem<String>(
//                         value: player,
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 12,
//                               backgroundColor: _getSportColor(match['sport']).withOpacity(0.1),
//                               child: Text(
//                                 player[0].toUpperCase(),
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                   color: _getSportColor(match['sport']),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(player),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _setSelectedPlayer(index, newValue);
//                       });
//                     },
//                   ),
//                 ),

//                 // TextFormField(
//                 //   decoration: InputDecoration(
//                 //     border: OutlineInputBorder(

//                 //     ),
//                 //     labelText: 'Add Player'
//                 //   ),
//                 // ),

//                 const SizedBox(height: 20),

//                 // Action Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton.icon(
//                         onPressed: () => _openMatchLink(match['link']),
//                         icon: const Icon(Icons.link, size: 16),
//                         label: const Text('Copy'),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           side: BorderSide(color: _getSportColor(match['sport'])),
//                           foregroundColor: _getSportColor(match['sport']),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton.icon(
//                         onPressed: _getSelectedPlayer(index) != null 
//                             ? () => _joinMatch(match, _getSelectedPlayer(index)!)
//                             : null,
//                         icon: const Icon(Icons.sports, size: 16),
//                         label: const Text('Join Match'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           backgroundColor: _getSportColor(match['sport']),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 16, color: Colors.grey[500]),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[500],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Color _getSportColor(String sport) {
//     switch (sport.toLowerCase()) {
//       case 'football':
//         return const Color(0xFF4CAF50);
//       case 'cricket':
//         return const Color(0xFF2196F3);
//       case 'basketball':
//         return const Color(0xFFFF9800);
//       case 'tennis':
//         return const Color(0xFF9C27B0);
//       case 'volleyball':
//         return const Color(0xFFE91E63);
//       default:
//         return const Color(0xFF00BF8F);
//     }
//   }

//   IconData _getSportIcon(String sport) {
//     switch (sport.toLowerCase()) {
//       case 'football':
//         return Icons.sports_soccer;
//       case 'cricket':
//         return Icons.sports_cricket;
//       case 'basketball':
//         return Icons.sports_basketball;
//       case 'tennis':
//         return Icons.sports_tennis;
//       case 'volleyball':
//         return Icons.sports_volleyball;
//       default:
//         return Icons.sports;
//     }
//   }

//   String? _getSelectedPlayer(int matchIndex) {
//     switch (matchIndex) {
//       case 0:
//         return selectedPlayerForMatch1;
//       case 1:
//         return selectedPlayerForMatch2;
//       case 2:
//         return selectedPlayerForMatch3;
//       default:
//         return null;
//     }
//   }

//   void _setSelectedPlayer(int matchIndex, String? player) {
//     switch (matchIndex) {
//       case 0:
//         selectedPlayerForMatch1 = player;
//         break;
//       case 1:
//         selectedPlayerForMatch2 = player;
//         break;
//       case 2:
//         selectedPlayerForMatch3 = player;
//         break;
//     }
//   }

//   void _openMatchLink(String link) {
//     // Simulate opening a web link
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.link, color: Colors.white, size: 20),
//             const SizedBox(width: 8),
//             Expanded(child: Text('Opening: $link')),
//           ],
//         ),
//         backgroundColor: const Color(0xFF2196F3),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   void _joinMatch(Map<String, dynamic> match, String playerName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Row(
//             children: [
//               Icon(
//                 Icons.check_circle,
//                 color: _getSportColor(match['sport']),
//                 size: 28,
//               ),
//               const SizedBox(width: 10),
//               const Text('Match Joined!'),
//             ],
//           ),
//           content: Text(
//             'Player "$playerName" has successfully joined "${match['name']}".\n\nYou will receive match updates and notifications.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text(
//                 'Great!',
//                 style: TextStyle(
//                   color: _getSportColor(match['sport']),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _createNewTeam() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const CreateNewTeam(),
//       ),
//     );
//   }
// }













// ignore_for_file: deprecated_member_use

import 'package:booking_application/views/team/create_new_team.dart';
import 'package:flutter/material.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  String? selectedPlayerForMatch1;
  String? selectedPlayerForMatch2;
  String? selectedPlayerForMatch3;

  // Controllers for add player text fields
  final TextEditingController _addPlayerController1 = TextEditingController();
  final TextEditingController _addPlayerController2 = TextEditingController();
  final TextEditingController _addPlayerController3 = TextEditingController();

  // Sample match data
  final List<Map<String, dynamic>> matches = [
    {
      'id': 1,
      'name': 'Championship Final',
      'sport': 'Football',
      'date': '2024-09-15',
      'time': '6:00 PM',
      'location': 'City Stadium',
      'type': 'Tournament',
      'maxParticipants': 22,
      'description': 'Annual championship final match between top teams.',
      'link': 'https://example.com/match/1',
      'players': ['Alex Rodriguez', 'Sarah Johnson', 'Michael Chen', 'Emma Wilson', 'David Martinez']
    },
    {
      'id': 2,
      'name': 'Cricket League Match',
      'sport': 'Cricket',
      'date': '2024-09-20',
      'time': '2:00 PM',
      'location': 'Sports Complex',
      'type': 'League',
      'maxParticipants': 22,
      'description': 'Regular season league match for points.',
      'link': 'https://example.com/match/2',
      'players': ['Lisa Thompson', 'Chris Anderson', 'Maya Patel', 'James Brown', 'Sofia Garcia']
    },
    {
      'id': 3,
      'name': 'Basketball Friendly',
      'sport': 'Basketball',
      'date': '2024-09-25',
      'time': '7:00 PM',
      'location': 'Indoor Court',
      'type': 'Friendly Match',
      'maxParticipants': 10,
      'description': 'Casual basketball game for practice and fun.',
      'link': 'https://example.com/match/3',
      'players': ['Alex Rodriguez', 'Michael Chen', 'David Martinez', 'Chris Anderson', 'James Brown']
    },
  ];

  @override
  void dispose() {
    _addPlayerController1.dispose();
    _addPlayerController2.dispose();
    _addPlayerController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Available Matches',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return _buildMatchCard(match, index);
              },
            ),
          ),

          // Create New Team Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _createNewTeam,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BF8F),
                  elevation: 2,
                  shadowColor: const Color(0xFF00BF8F).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                     SizedBox(width: 8),
                     Text(
                      'Create New Team',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Match Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getSportColor(match['sport']),
                  _getSportColor(match['sport']).withOpacity(0.8),
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
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getSportIcon(match['sport']),
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
                        match['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${match['sport']} • ${match['type']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${match['maxParticipants']} max',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Match Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date, Time, Location
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(Icons.calendar_today, 'Date', match['date']),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoRow(Icons.access_time, 'Time', match['time']),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.location_on, 'Location', match['location']),
                
                const SizedBox(height: 16),
                
                // Description
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  match['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                // Add New Player Section
                Text(
                  'Add New Player',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: TextFormField(
                          controller: _getAddPlayerController(index),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            hintText: 'Enter player name...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon: Icon(Icons.person_add, color: Colors.grey[500]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: _getSportColor(match['sport']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => _addPlayer(index),
                        icon: const Icon(Icons.add, color: Colors.white),
                        tooltip: 'Add Player',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Player Dropdown
                Text(
                  'Select Player for this Match',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _getSelectedPlayer(index),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      hintText: 'Choose a player...',
                    ),
                    items: match['players'].map<DropdownMenuItem<String>>((player) {
                      return DropdownMenuItem<String>(
                        value: player,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: _getSportColor(match['sport']).withOpacity(0.1),
                              child: Text(
                                player[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getSportColor(match['sport']),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(player),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _setSelectedPlayer(index, newValue);
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _openMatchLink(match['link']),
                        icon: const Icon(Icons.link, size: 16),
                        label: const Text('Copy'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: _getSportColor(match['sport'])),
                          foregroundColor: _getSportColor(match['sport']),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _getSelectedPlayer(index) != null 
                            ? () => _joinMatch(match, _getSelectedPlayer(index)!)
                            : null,
                        icon: const Icon(Icons.sports, size: 16),
                        label: const Text('Join Match'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: _getSportColor(match['sport']),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextEditingController _getAddPlayerController(int matchIndex) {
    switch (matchIndex) {
      case 0:
        return _addPlayerController1;
      case 1:
        return _addPlayerController2;
      case 2:
        return _addPlayerController3;
      default:
        return TextEditingController();
    }
  }

  void _addPlayer(int matchIndex) {
    final controller = _getAddPlayerController(matchIndex);
    final playerName = controller.text.trim();
    
    if (playerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Please enter a player name'),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    // Check if player already exists
    if (matches[matchIndex]['players'].contains(playerName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.info, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Player already exists in this match'),
            ],
          ),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() {
      matches[matchIndex]['players'].add(playerName);
      controller.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Player "$playerName" added successfully!'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Color _getSportColor(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return const Color(0xFF4CAF50);
      case 'cricket':
        return const Color(0xFF2196F3);
      case 'basketball':
        return const Color(0xFFFF9800);
      case 'tennis':
        return const Color(0xFF9C27B0);
      case 'volleyball':
        return const Color(0xFFE91E63);
      default:
        return const Color(0xFF00BF8F);
    }
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'cricket':
        return Icons.sports_cricket;
      case 'basketball':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'volleyball':
        return Icons.sports_volleyball;
      default:
        return Icons.sports;
    }
  }

  String? _getSelectedPlayer(int matchIndex) {
    switch (matchIndex) {
      case 0:
        return selectedPlayerForMatch1;
      case 1:
        return selectedPlayerForMatch2;
      case 2:
        return selectedPlayerForMatch3;
      default:
        return null;
    }
  }

  void _setSelectedPlayer(int matchIndex, String? player) {
    switch (matchIndex) {
      case 0:
        selectedPlayerForMatch1 = player;
        break;
      case 1:
        selectedPlayerForMatch2 = player;
        break;
      case 2:
        selectedPlayerForMatch3 = player;
        break;
    }
  }

  void _openMatchLink(String link) {
    // Simulate opening a web link
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.link, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text('Opening: $link')),
          ],
        ),
        backgroundColor: const Color(0xFF2196F3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _joinMatch(Map<String, dynamic> match, String playerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: _getSportColor(match['sport']),
                size: 28,
              ),
              const SizedBox(width: 10),
              const Text('Match Joined!'),
            ],
          ),
          content: Text(
            'Player "$playerName" has successfully joined "${match['name']}".\n\nYou will receive match updates and notifications.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Great!',
                style: TextStyle(
                  color: _getSportColor(match['sport']),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _createNewTeam() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewTeam(),
      ),
    );
  }
}