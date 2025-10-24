
// import 'package:booking_application/views/Cricket/live_match_screen.dart';
// import 'package:flutter/material.dart';

// // Main screen that handles the flow
// class MatchSetupScreen extends StatefulWidget {
//   final String teamA;
//   final String teamB;
//   final String battingTeam;
//   final String bowlingTeam;
  
//   const MatchSetupScreen({
//     super.key,
//     required this.teamA,
//     required this.teamB,
//     required this.battingTeam,
//     required this.bowlingTeam,
//   });

//   @override
//   State<MatchSetupScreen> createState() => _MatchSetupScreenState();
// }

// class _MatchSetupScreenState extends State<MatchSetupScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Show the batsmen selection dialog immediately when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showBatsmenSelectionDialog();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: const Center(
//         child: CircularProgressIndicator(
//           color: Color(0xFF1976D2),
//         ),
//       ),
//     );
//   }

//   void _showBatsmenSelectionDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return BatsmenSelectionDialog(
//           battingTeam: widget.battingTeam,
//           onConfirm: (striker, nonStriker) {
//             Navigator.of(context).pop();
//             _showBowlerSelectionDialog(striker, nonStriker);
//           },
//         );
//       },
//     );
//   }

//   void _showBowlerSelectionDialog(String striker, String nonStriker) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return BowlerSelectionDialog(
//           bowlingTeam: widget.bowlingTeam,
//           onConfirm: (bowler, bowlingStyle) {
//             Navigator.of(context).pop();
//             _navigateToLiveMatch(striker, nonStriker, bowler, bowlingStyle);
//           },
//         );
//       },
//     );
//   }

//   void _navigateToLiveMatch(String striker, String nonStriker, String bowler, String bowlingStyle) {
//     // Here you would navigate to the live match screen with all the selected players
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Match setup complete!\n${widget.battingTeam} batting: $striker (striker), $nonStriker (non-striker)\n${widget.bowlingTeam} bowling: $bowler ($bowlingStyle)'),
//         backgroundColor: const Color(0xFF1976D2),
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(seconds: 4),
//       ),
//     );
    
//     // Navigate to live match screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LiveMatchScreen(

//         ),
//       ),
//     );
//   }
// }

// // Batsmen Selection Dialog
// class BatsmenSelectionDialog extends StatefulWidget {
//   final String battingTeam;
//   final Function(String striker, String nonStriker) onConfirm;

//   const BatsmenSelectionDialog({
//     super.key,
//     required this.battingTeam,
//     required this.onConfirm,
//   });

//   @override
//   State<BatsmenSelectionDialog> createState() => _BatsmenSelectionDialogState();
// }

// class _BatsmenSelectionDialogState extends State<BatsmenSelectionDialog> {
//   String? _selectedStriker;
//   String? _selectedNonStriker;

//   // Sample players based on batting team - replace with actual team data
//   List<String> get _players {
//     if (widget.battingTeam == 'Mumbai Indians') {
//       return [
//         'Rohit Sharma',
//         'Quinton de Kock',
//         'Suryakumar Yadav',
//         'Ishan Kishan',
//         'Hardik Pandya',
//         'Kieron Pollard',
//         'Krunal Pandya',
//         'Nathan Coulter-Nile',
//         'Rahul Chahar',
//         'Trent Boult',
//         'Jasprit Bumrah',
//       ];
//     } else if (widget.battingTeam == 'Chennai Super Kings') {
//       return [
//         'MS Dhoni',
//         'Faf du Plessis',
//         'Ruturaj Gaikwad',
//         'Ambati Rayudu',
//         'Suresh Raina',
//         'Ravindra Jadeja',
//         'Dwayne Bravo',
//         'Sam Curran',
//         'Deepak Chahar',
//         'Shardul Thakur',
//         'Imran Tahir',
//       ];
//     } else {
//       // Default fallback
//       return [
//         'Player 1',
//         'Player 2',
//         'Player 3',
//         'Player 4',
//         'Player 5',
//         'Player 6',
//         'Player 7',
//         'Player 8',
//         'Player 9',
//         'Player 10',
//         'Player 11',
//       ];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: 400,
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: const Color(0xFFE0E0E0),
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             const Text(
//               'Select Opening Batsmen',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1976D2),
//               ),
//             ),
//             const SizedBox(height: 24),
            
//             // Striker Selection
//             const Text(
//               'Striker',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF212121),
//               ),
//             ),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: _selectedStriker,
//               hint: 'Choose a striker',
//               items: _players,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedStriker = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
            
//             // Non-Striker Selection
//             const Text(
//               'Non-Striker',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF212121),
//               ),
//             ),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: _selectedNonStriker,
//               hint: 'Choose a non-striker',
//               items: _players.where((player) => player != _selectedStriker).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedNonStriker = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 32),
            
//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 _buildButton(
//                   text: 'Cancel',
//                   onPressed: () => Navigator.of(context).pop(),
//                   isSecondary: true,
//                 ),
//                 const SizedBox(width: 12),
//                 _buildButton(
//                   text: 'Confirm',
//                   onPressed: _selectedStriker != null && _selectedNonStriker != null
//                       ? () => widget.onConfirm(_selectedStriker!, _selectedNonStriker!)
//                       : null,
//                   isSecondary: false,
//                 ),
//               ],
//             ),
//           ],
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
//       width: double.infinity,
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: const Color(0xFFE0E0E0),
//           width: 2,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               hint,
//               style: const TextStyle(
//                 color: Color(0xFF666666),
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           icon: const Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Icon(
//               Icons.keyboard_arrow_down,
//               color: Color(0xFF666666),
//             ),
//           ),
//           isExpanded: true,
//           dropdownColor: Colors.white,
//           style: const TextStyle(color: Color(0xFF212121)),
//           items: items.map((String item) {
//             return DropdownMenuItem<String>(
//               value: item,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   item,
//                   style: const TextStyle(
//                     color: Color(0xFF212121),
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
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       color: Color(0xFF212121),
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

//   Widget _buildButton({
//     required String text,
//     required VoidCallback? onPressed,
//     required bool isSecondary,
//   }) {
//     return Container(
//       height: 40,
//       constraints: const BoxConstraints(minWidth: 80),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSecondary 
//               ? const Color(0xFFF5F5F5)
//               : (onPressed != null ? const Color(0xFF1976D2) : const Color(0xFFE0E0E0)),
//           foregroundColor: isSecondary
//               ? const Color(0xFF666666)
//               : (onPressed != null ? Colors.white : const Color(0xFF666666)),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           elevation: isSecondary ? 0 : (onPressed != null ? 2 : 0),
//           shadowColor: isSecondary ? Colors.transparent : Colors.black.withOpacity(0.2),
//           side: isSecondary ? const BorderSide(color: Color(0xFFE0E0E0)) : null,
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Bowler Selection Dialog
// class BowlerSelectionDialog extends StatefulWidget {
//   final String bowlingTeam;
//   final Function(String bowler, String bowlingStyle) onConfirm;

//   const BowlerSelectionDialog({
//     super.key,
//     required this.bowlingTeam,
//     required this.onConfirm,
//   });

//   @override
//   State<BowlerSelectionDialog> createState() => _BowlerSelectionDialogState();
// }

// class _BowlerSelectionDialogState extends State<BowlerSelectionDialog> {
//   String? _selectedBowler;
//   String _selectedBowlingStyle = 'Right Arm Fast';

//   // Sample players based on bowling team - replace with actual team data
//   List<String> get _bowlers {
//     if (widget.bowlingTeam == 'Mumbai Indians') {
//       return [
//         'Rohit Sharma',
//         'Quinton de Kock',
//         'Suryakumar Yadav',
//         'Ishan Kishan',
//         'Hardik Pandya',
//         'Kieron Pollard',
//         'Krunal Pandya',
//         'Nathan Coulter-Nile',
//         'Rahul Chahar',
//         'Trent Boult',
//         'Jasprit Bumrah',
//       ];
//     } else if (widget.bowlingTeam == 'Chennai Super Kings') {
//       return [
//         'MS Dhoni',
//         'Faf du Plessis',
//         'Ruturaj Gaikwad',
//         'Ambati Rayudu',
//         'Suresh Raina',
//         'Ravindra Jadeja',
//         'Dwayne Bravo',
//         'Sam Curran',
//         'Deepak Chahar',
//         'Shardul Thakur',
//         'Imran Tahir',
//       ];
//     } else {
//       // Default fallback
//       return [
//         'Player 1',
//         'Player 2',
//         'Player 3',
//         'Player 4',
//         'Player 5',
//         'Player 6',
//         'Player 7',
//         'Player 8',
//         'Player 9',
//         'Player 10',
//         'Player 11',
//       ];
//     }
//   }

//   final List<String> _bowlingStyles = [
//     'Right Arm Fast',
//     'Left Arm Fast',
//     'Right Arm Medium',
//     'Left Arm Medium',
//     'Right Arm Spin',
//     'Left Arm Spin',
//     'Right Arm Off Spin',
//     'Left Arm Orthodox',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: 400,
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: const Color(0xFFE0E0E0),
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             const Text(
//               'Select Bowler',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1976D2),
//               ),
//             ),
//             const SizedBox(height: 24),
            
//             // Bowler Selection
//             const Text(
//               'Bowler',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF212121),
//               ),
//             ),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: _selectedBowler,
//               hint: 'Choose a player',
//               items: _bowlers,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedBowler = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
            
//             // Bowling Style Selection
//             const Text(
//               'Bowling Style',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF212121),
//               ),
//             ),
//             const SizedBox(height: 8),
//             _buildDropdown(
//               value: _selectedBowlingStyle,
//               hint: 'Right Arm Fast',
//               items: _bowlingStyles,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedBowlingStyle = value!;
//                 });
//               },
//             ),
//             const SizedBox(height: 32),
            
//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 _buildButton(
//                   text: 'Cancel',
//                   onPressed: () => Navigator.of(context).pop(),
//                   isSecondary: true,
//                 ),
//                 const SizedBox(width: 12),
//                 _buildButton(
//                   text: 'Confirm',
//                   onPressed: _selectedBowler != null
//                       ? () => widget.onConfirm(_selectedBowler!, _selectedBowlingStyle)
//                       : null,
//                   isSecondary: false,
//                 ),
//               ],
//             ),
//           ],
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
//       width: double.infinity,
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: const Color(0xFFE0E0E0),
//           width: 2,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               hint,
//               style: const TextStyle(
//                 color: Color(0xFF666666),
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           icon: const Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Icon(
//               Icons.keyboard_arrow_down,
//               color: Color(0xFF666666),
//             ),
//           ),
//           isExpanded: true,
//           dropdownColor: Colors.white,
//           style: const TextStyle(color: Color(0xFF212121)),
//           items: items.map((String item) {
//             return DropdownMenuItem<String>(
//               value: item,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   item,
//                   style: const TextStyle(
//                     color: Color(0xFF212121),
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
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       color: Color(0xFF212121),
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

//   Widget _buildButton({
//     required String text,
//     required VoidCallback? onPressed,
//     required bool isSecondary,
//   }) {
//     return Container(
//       height: 40,
//       constraints: const BoxConstraints(minWidth: 80),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSecondary 
//               ? const Color(0xFFF5F5F5)
//               : (onPressed != null ? const Color(0xFF1976D2) : const Color(0xFFE0E0E0)),
//           foregroundColor: isSecondary
//               ? const Color(0xFF666666)
//               : (onPressed != null ? Colors.white : const Color(0xFF666666)),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           elevation: isSecondary ? 0 : (onPressed != null ? 2 : 0),
//           shadowColor: isSecondary ? Colors.transparent : Colors.black.withOpacity(0.2),
//           side: isSecondary ? const BorderSide(color: Color(0xFFE0E0E0)) : null,
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }





















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Cricket/views/live_match_screen.dart';
import 'package:booking_application/views/Cricket/views/view_matches_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// Main screen that handles the flow
class MatchSetupScreen extends StatefulWidget {
  final String? tossWinner;
  final Team team1;
  final Team team2;
  final Team battingTeam;
  final Team bowlingTeam;
  final String matchId;
  
  const MatchSetupScreen({
    super.key,
     this.tossWinner,
    required this.team1,
    required this.team2,
    required this.battingTeam,
    required this.bowlingTeam,
    required this.matchId,
  });

  @override
  State<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends State<MatchSetupScreen> {
     String? userId; 

  @override
  void initState() {
    super.initState();
            _loadUserId();

    // Show the batsmen selection dialog immediately when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBatsmenSelectionDialog();
    });
  }

        void _loadUserId() async {
    final user = await UserPreferences.getUser();
    if (user != null) {
      userId = user.id;
    } 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1976D2),
        ),
      ),
    );
  }

  void _showBatsmenSelectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BatsmenSelectionDialog(
          battingTeam: widget.battingTeam,
          onConfirm: (striker, nonStriker) {
            Navigator.of(context).pop();
            _showBowlerSelectionDialog(striker, nonStriker);
          },
        );
      },
    );
  }

  void _showBowlerSelectionDialog(Player striker, Player nonStriker) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BowlerSelectionDialog(
          bowlingTeam: widget.bowlingTeam,
          onConfirm: (bowler, bowlingStyle) {
            Navigator.of(context).pop();
            _startMatch(striker, nonStriker, bowler, bowlingStyle);
          },
        );
      },
    );
  }

  Future<void> _startMatch(Player striker, Player nonStriker, Player bowler, String bowlingStyle) async {
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk22222222222222222222222222222222222");

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1976D2),
        ),
      ),
    );

try {
  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
  final payload = {
    'tossWinner': widget.tossWinner,
    'electedTo': 'Bat',
    'striker': striker.id,
    'nonStriker': nonStriker.id,
    'bowler': bowler.id,
    'bowlingStyle': bowlingStyle,
  };

  print("Payload before API call: ${json.encode(payload)}");
  print("Printinggggggggggggggggggggggggggg${userId.toString()}");

  final response = await http.post(
    Uri.parse('http://31.97.206.144:3081/users/startmatch/${userId.toString()}/${widget.matchId}'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(payload),
  );

  // Close loading dialog
  Navigator.of(context).pop();

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    
    if (data['success'] == true) {
            _showSnackBar('${data['message'] ?? 'Match Started'}');

      // Navigate to live match screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LiveMatchScreen(matchId:widget.matchId,),
        ),
      );
    } else {
      _showSnackBar('Failed to start match: ${data['message'] ?? 'Unknown error'}');
    }
  } else {
    _showSnackBar('Failed to start match. Status: ${response.statusCode}');
  }
}
 catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();
      _showSnackBar('Error starting match: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1976D2),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// Batsmen Selection Dialog
class BatsmenSelectionDialog extends StatefulWidget {
  final Team battingTeam;
  final Function(Player striker, Player nonStriker) onConfirm;

  const BatsmenSelectionDialog({
    super.key,
    required this.battingTeam,
    required this.onConfirm,
  });

  @override
  State<BatsmenSelectionDialog> createState() => _BatsmenSelectionDialogState();
}

class _BatsmenSelectionDialogState extends State<BatsmenSelectionDialog> {
  Player? _selectedStriker;
  Player? _selectedNonStriker;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Select Opening Batsmen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.battingTeam.teamName,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 24),
            
            // Striker Selection
            const Text(
              'Striker',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _selectedStriker,
              hint: 'Choose a striker',
              items: widget.battingTeam.players,
              onChanged: (value) {
                setState(() {
                  _selectedStriker = value;
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Non-Striker Selection
            const Text(
              'Non-Striker',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _selectedNonStriker,
              hint: 'Choose a non-striker',
              items: widget.battingTeam.players
                  .where((player) => player.id != _selectedStriker?.id)
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedNonStriker = value;
                });
              },
            ),
            const SizedBox(height: 32),
            
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                  isSecondary: true,
                ),
                const SizedBox(width: 12),
                _buildButton(
                  text: 'Confirm',
                  onPressed: _selectedStriker != null && _selectedNonStriker != null
                      ? () => widget.onConfirm(_selectedStriker!, _selectedNonStriker!)
                      : null,
                  isSecondary: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required Player? value,
    required String hint,
    required List<Player> items,
    required Function(Player?) onChanged,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Player>(
          value: value,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              hint,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 16,
              ),
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF666666),
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          style: const TextStyle(color: Color(0xFF212121)),
          items: items.map((Player player) {
            return DropdownMenuItem<Player>(
              value: player,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  player.name,
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (BuildContext context) {
            return items.map((Player player) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    player.name,
                    style: const TextStyle(
                      color: Color(0xFF212121),
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

  Widget _buildButton({
    required String text,
    required VoidCallback? onPressed,
    required bool isSecondary,
  }) {
    return Container(
      height: 40,
      constraints: const BoxConstraints(minWidth: 80),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary 
              ? const Color(0xFFF5F5F5)
              : (onPressed != null ? const Color(0xFF1976D2) : const Color(0xFFE0E0E0)),
          foregroundColor: isSecondary
              ? const Color(0xFF666666)
              : (onPressed != null ? Colors.white : const Color(0xFF666666)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: isSecondary ? 0 : (onPressed != null ? 2 : 0),
          shadowColor: isSecondary ? Colors.transparent : Colors.black.withOpacity(0.2),
          side: isSecondary ? const BorderSide(color: Color(0xFFE0E0E0)) : null,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Bowler Selection Dialog
class BowlerSelectionDialog extends StatefulWidget {
  final Team bowlingTeam;
  final Function(Player bowler, String bowlingStyle) onConfirm;

  const BowlerSelectionDialog({
    super.key,
    required this.bowlingTeam,
    required this.onConfirm,
  });

  @override
  State<BowlerSelectionDialog> createState() => _BowlerSelectionDialogState();
}

class _BowlerSelectionDialogState extends State<BowlerSelectionDialog> {
  Player? _selectedBowler;
  String _selectedBowlingStyle = 'Right-arm fast';

  final List<String> _bowlingStyles = [
    'Right-arm fast',
    'Left-arm fast',
    'Right-arm medium',
    'Left-arm medium',
    'Right-arm spin',
    'Left-arm spin',
    'Right-arm off-spin',
    'Left-arm orthodox',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Select Bowler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.bowlingTeam.teamName,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 24),
            
            // Bowler Selection
            const Text(
              'Bowler',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 8),
            _buildPlayerDropdown(
              value: _selectedBowler,
              hint: 'Choose a player',
              items: widget.bowlingTeam.players,
              onChanged: (value) {
                setState(() {
                  _selectedBowler = value;
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Bowling Style Selection
            const Text(
              'Bowling Style',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 8),
            _buildStyleDropdown(
              value: _selectedBowlingStyle,
              items: _bowlingStyles,
              onChanged: (value) {
                setState(() {
                  _selectedBowlingStyle = value!;
                });
              },
            ),
            const SizedBox(height: 32),
            
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                  isSecondary: true,
                ),
                const SizedBox(width: 12),
                _buildButton(
                  text: 'Confirm',
                  onPressed: _selectedBowler != null
                      ? () => widget.onConfirm(_selectedBowler!, _selectedBowlingStyle)
                      : null,
                  isSecondary: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerDropdown({
    required Player? value,
    required String hint,
    required List<Player> items,
    required Function(Player?) onChanged,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Player>(
          value: value,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              hint,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 16,
              ),
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF666666),
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          style: const TextStyle(color: Color(0xFF212121)),
          items: items.map((Player player) {
            return DropdownMenuItem<Player>(
              value: player,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  player.name,
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (BuildContext context) {
            return items.map((Player player) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    player.name,
                    style: const TextStyle(
                      color: Color(0xFF212121),
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

  Widget _buildStyleDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF666666),
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          style: const TextStyle(color: Color(0xFF212121)),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xFF212121),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xFF212121),
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

  Widget _buildButton({
    required String text,
    required VoidCallback? onPressed,
    required bool isSecondary,
  }) {
    return Container(
      height: 40,
      constraints: const BoxConstraints(minWidth: 80),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary 
              ? const Color(0xFFF5F5F5)
              : (onPressed != null ? const Color(0xFF1976D2) : const Color(0xFFE0E0E0)),
          foregroundColor: isSecondary
              ? const Color(0xFF666666)
              : (onPressed != null ? Colors.white : const Color(0xFF666666)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: isSecondary ? 0 : (onPressed != null ? 2 : 0),
          shadowColor: isSecondary ? Colors.transparent : Colors.black.withOpacity(0.2),
          side: isSecondary ? const BorderSide(color: Color(0xFFE0E0E0)) : null,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}