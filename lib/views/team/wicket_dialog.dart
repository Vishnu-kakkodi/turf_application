
// // wicket_dialog.dart
// import 'package:booking_application/provider/match_game_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WicketDialog extends StatefulWidget {
//   final Function(String wicketType, String? fielder) onWicketConfirmed;
  
//   const WicketDialog({Key? key, required this.onWicketConfirmed}) : super(key: key);

//   @override
//   State<WicketDialog> createState() => _WicketDialogState();
// }

// class _WicketDialogState extends State<WicketDialog> {
//   String? _wicketType;
//   String? _fielder;
  
//   final List<String> _wicketTypes = [
//     'Caught',
//     'Bowled',
//     'LBW',
//     'Run Out',
//     'Stumped',
//     'Hit Wicket',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Wicket!',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text('How was Player A1 Dismissed?'),
//             const SizedBox(height: 16),
            
//             const Text(
//               'Type',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               items: _wicketTypes.map((type) {
//                 return DropdownMenuItem(value: type, child: Text(type));
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _wicketType = value;
//                 });
//               },
//             ),
            
//             const SizedBox(height: 16),
//             const Text(
//               'Fielder',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Consumer<MatchGameProvider>(
//               builder: (context, provider, child) {
//                 final fielders = provider.getBowlingTeamPlayers();
//                 return DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Select Fielder',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   items: fielders.map((fielder) {
//                     return DropdownMenuItem(value: fielder, child: Text(fielder));
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _fielder = value;
//                     });
//                   },
//                 );
//               },
//             ),
            
//             const SizedBox(height: 16),
//             const Text(
//               'Runs on this Delivery',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: 'Select Fielder',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               items: const [
//                 DropdownMenuItem(value: '0', child: Text('0')),
//                 DropdownMenuItem(value: '1', child: Text('1')),
//                 DropdownMenuItem(value: '2', child: Text('2')),
//                 DropdownMenuItem(value: '3', child: Text('3')),
//                 DropdownMenuItem(value: '4', child: Text('4')),
//                 DropdownMenuItem(value: '6', child: Text('6')),
//               ],
//               onChanged: (value) {},
//             ),
            
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text('Cancel'),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _wicketType != null ? () {
//                       widget.onWicketConfirmed(_wicketType!, _fielder);
//                       Navigator.pop(context);
//                     } : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Confirm Wicket',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









// wicket_dialog.dart
import 'package:flutter/material.dart';

class WicketDialog extends StatefulWidget {
  final Function(String wicketType, String fielder) onWicketConfirmed;
  
  const WicketDialog({
    Key? key,
    required this.onWicketConfirmed,
  }) : super(key: key);

  @override
  State<WicketDialog> createState() => _WicketDialogState();
}

class _WicketDialogState extends State<WicketDialog> {
  String? _selectedWicketType;
  String? _selectedFielder;
  
  final List<String> _wicketTypes = [
    'Bowled',
    'Caught',
    'LBW',
    'Run Out',
    'Stumped',
    'Hit Wicket',
  ];
  
  final List<String> _fielders = [
    'Wicket Keeper',
    'Mid Off',
    'Mid On',
    'Point',
    'Cover',
    'Square Leg',
    'Fine Leg',
    'Third Man',
    'Deep Mid Wicket',
    'Long Off',
    'Long On',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.sports_cricket,
                  color: Colors.red,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Wicket!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Wicket Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedWicketType,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Select wicket type'),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedWicketType = value;
                      // Reset fielder selection for certain wicket types
                      if (value == 'Bowled' || value == 'LBW' || value == 'Hit Wicket') {
                        _selectedFielder = 'Bowler';
                      } else {
                        _selectedFielder = null;
                      }
                    });
                  },
                  items: _wicketTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(type),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            if (_selectedWicketType != null && 
                _selectedWicketType != 'Bowled' && 
                _selectedWicketType != 'LBW' && 
                _selectedWicketType != 'Hit Wicket') ...[
              const Text(
                'Fielder',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedFielder,
                    hint: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Select fielder'),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedFielder = value;
                      });
                    },
                    items: _fielders.map((fielder) {
                      return DropdownMenuItem(
                        value: fielder,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(fielder),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canConfirm() ? () {
                      widget.onWicketConfirmed(
                        _selectedWicketType!,
                        _selectedFielder ?? 'Bowler',
                      );
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  bool _canConfirm() {
    if (_selectedWicketType == null) return false;
    
    // For Bowled, LBW, Hit Wicket - no fielder selection needed
    if (_selectedWicketType == 'Bowled' || 
        _selectedWicketType == 'LBW' || 
        _selectedWicketType == 'Hit Wicket') {
      return true;
    }
    
    // For other wicket types, fielder selection is required
    return _selectedFielder != null;
  }
}