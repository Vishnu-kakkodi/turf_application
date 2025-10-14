import 'package:flutter/material.dart';

// Modal dialog utilities for cricket match management
class CricketModals {
  
  // 1. Select Bowler Modal
  // static Future<Map<String, String>?> showBowlerSelectionModal(
  //   BuildContext context, {
  //   required List<String> availablePlayers,
  // }) {
  //   String? selectedBowler;
  //   String selectedBowlingStyle = 'Right Arm Fast';
    
  //   final bowlingStyles = [
  //     'Right Arm Fast',
  //     'Left Arm Fast',
  //     'Right Arm Medium',
  //     'Left Arm Medium',
  //     'Off Spin',
  //     'Leg Spin',
  //     'Left Arm Spin',
  //   ];

  //   return showDialog<Map<String, String>>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Dialog(
  //             backgroundColor: const Color(0xFF2A3441),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(24),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     'Select Bowler',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Color(0xFF00BCD4),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 24),
                    
  //                   // Bowler Selection
  //                   const Text(
  //                     'Bowler',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     width: double.infinity,
  //                     padding: const EdgeInsets.symmetric(horizontal: 16),
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFF3A4551),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: DropdownButtonHideUnderline(
  //                       child: DropdownButton<String>(
  //                         value: selectedBowler,
  //                         hint: const Text(
  //                           'Choose a player',
  //                           style: TextStyle(color: Color(0xFF8A9BA8)),
  //                         ),
  //                         dropdownColor: const Color(0xFF3A4551),
  //                         style: const TextStyle(color: Colors.white),
  //                         items: availablePlayers.map((String player) {
  //                            print("Dropdown item: $player");
  //                           return DropdownMenuItem<String>(
  //                             value: player,
  //                             child: Text(player),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String? newValue) {
  //                           setState(() {
  //                             selectedBowler = newValue;
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
                    
  //                   const SizedBox(height: 20),
                    
  //                   // Bowling Style Selection
  //                   const Text(
  //                     'Bowling Style',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     width: double.infinity,
  //                     padding: const EdgeInsets.symmetric(horizontal: 16),
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFF3A4551),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: DropdownButtonHideUnderline(
  //                       child: DropdownButton<String>(
  //                         value: selectedBowlingStyle,
  //                         dropdownColor: const Color(0xFF3A4551),
  //                         style: const TextStyle(color: Colors.white),
  //                         items: bowlingStyles.map((String style) {
  //                           return DropdownMenuItem<String>(
  //                             value: style,
  //                             child: Text(style),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String? newValue) {
  //                           setState(() {
  //                             selectedBowlingStyle = newValue!;
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
                    
  //                   const SizedBox(height: 32),
                    
  //                   // Action Buttons
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         onPressed: () => Navigator.of(context).pop(),
  //                         child: const Text(
  //                           'Cancel',
  //                           style: TextStyle(
  //                             color: Color(0xFF8A9BA8),
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(width: 16),
  //                       ElevatedButton(
  //                         onPressed: selectedBowler != null
  //                             ? () => Navigator.of(context).pop({
  //                                   'bowler': selectedBowler!,
  //                                   'style': selectedBowlingStyle,
  //                                 })
  //                             : null,
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color(0xFF00BCD4),
  //                           foregroundColor: Colors.white,
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 24,
  //                             vertical: 12,
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                         ),
  //                         child: const Text('Confirm'),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }



static Future<Map<String, String>?> showBowlerSelectionModal(
  BuildContext context, {
  required List<Map<String, String>> availablePlayers, // Changed to accept player objects
}) {
  Map<String, String>? selectedBowler;
  String selectedBowlingStyle = 'Right Arm Fast';
  
  final bowlingStyles = [
    'Right Arm Fast',
    'Left Arm Fast',
    'Right Arm Medium',
    'Left Arm Medium',
    'Off Spin',
    'Leg Spin',
    'Left Arm Spin',
  ];

  return showDialog<Map<String, String>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: const Color(0xFF2A3441),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Bowler',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00BCD4),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Bowler Selection
                  const Text(
                    'Bowler',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4551),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedBowler?['id'], // Use ID as value
                        hint: const Text(
                          'Choose a player',
                          style: TextStyle(color: Color(0xFF8A9BA8)),
                        ),
                        dropdownColor: const Color(0xFF3A4551),
                        style: const TextStyle(color: Colors.white),
                        items: availablePlayers.map((Map<String, String> player) {
                          return DropdownMenuItem<String>(
                            value: player['id'], // ID is the unique value
                            child: Text(player['name']!), // Display name
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBowler = availablePlayers.firstWhere(
                              (p) => p['id'] == newValue,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Bowling Style Selection
                  const Text(
                    'Bowling Style',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4551),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedBowlingStyle,
                        dropdownColor: const Color(0xFF3A4551),
                        style: const TextStyle(color: Colors.white),
                        items: bowlingStyles.map((String style) {
                          return DropdownMenuItem<String>(
                            value: style,
                            child: Text(style),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBowlingStyle = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF8A9BA8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: selectedBowler != null
                            ? () => Navigator.of(context).pop({
                                  'id': selectedBowler!['id']!,
                                  'name': selectedBowler!['name']!,
                                  'style': selectedBowlingStyle,
                                })
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Confirm'),
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


  // 2. Wicket Details Modal
  // static Future<Map<String, dynamic>?> showWicketModal(
  //   BuildContext context, {
  //   required String dismissedPlayer,
  //   required List<String> fielders,
  // }) {
  //   String wicketType = 'Caught';
  //   String? selectedFielder;
  //   int runsOnDelivery = 0;
    
  //   final wicketTypes = [
  //     'Bowled',
  //     'Caught',
  //     'LBW',
  //     'Run Out',
  //     'Stumped',
  //     'Hit Wicket',
  //   ];

  //   return showDialog<Map<String, dynamic>>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Dialog(
  //             backgroundColor: const Color(0xFF2A3441),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(24),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     'Wicket!',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Color(0xFFFF6B6B),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Text(
  //                     'How was $dismissedPlayer dismissed?',
  //                     style: const TextStyle(
  //                       fontSize: 16,
  //                       color: Color(0xFF8A9BA8),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 24),
                    
  //                   // Wicket Type
  //                   const Text(
  //                     'Type',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     width: double.infinity,
  //                     padding: const EdgeInsets.symmetric(horizontal: 16),
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFF3A4551),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: DropdownButtonHideUnderline(
  //                       child: DropdownButton<String>(
  //                         value: wicketType,
  //                         dropdownColor: const Color(0xFF3A4551),
  //                         style: const TextStyle(color: Colors.white),
  //                         items: wicketTypes.map((String type) {
  //                           return DropdownMenuItem<String>(
  //                             value: type,
  //                             child: Text(type),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String? newValue) {
  //                           setState(() {
  //                             wicketType = newValue!;
  //                             if (wicketType != 'Caught' && wicketType != 'Run Out') {
  //                               selectedFielder = null;
  //                             }
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
                    
  //                   // Fielder Selection (if applicable)
  //                   if (wicketType == 'Caught' || wicketType == 'Run Out') ...[
  //                     const SizedBox(height: 20),
  //                     const Text(
  //                       'Fielder',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Container(
  //                       width: double.infinity,
  //                       padding: const EdgeInsets.symmetric(horizontal: 16),
  //                       decoration: BoxDecoration(
  //                         color: const Color(0xFF3A4551),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: DropdownButtonHideUnderline(
  //                         child: DropdownButton<String>(
  //                           value: selectedFielder,
  //                           hint: const Text(
  //                             'Select fielder',
  //                             style: TextStyle(color: Color(0xFF8A9BA8)),
  //                           ),
  //                           dropdownColor: const Color(0xFF3A4551),
  //                           style: const TextStyle(color: Colors.white),
  //                           items: fielders.map((String fielder) {
  //                             return DropdownMenuItem<String>(
  //                               value: fielder,
  //                               child: Text(fielder),
  //                             );
  //                           }).toList(),
  //                           onChanged: (String? newValue) {
  //                             setState(() {
  //                               selectedFielder = newValue;
  //                             });
  //                           },
  //                         ),
  //                       ),
  //                     ),
  //                   ],
                    
  //                   const SizedBox(height: 20),
                    
  //                   // Runs on delivery
  //                   const Text(
  //                     'Runs on this delivery',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   TextField(
  //                     style: const TextStyle(color: Colors.white),
  //                     decoration: InputDecoration(
  //                       hintText: '0',
  //                       hintStyle: const TextStyle(color: Color(0xFF8A9BA8)),
  //                       filled: true,
  //                       fillColor: const Color(0xFF3A4551),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide: BorderSide.none,
  //                       ),
  //                     ),
  //                     keyboardType: TextInputType.number,
  //                     onChanged: (value) {
  //                       runsOnDelivery = int.tryParse(value) ?? 0;
  //                     },
  //                   ),
                    
  //                   const SizedBox(height: 32),
                    
  //                   // Action Buttons
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         onPressed: () => Navigator.of(context).pop(),
  //                         child: const Text(
  //                           'Cancel',
  //                           style: TextStyle(
  //                             color: Color(0xFF8A9BA8),
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(width: 16),
  //                       ElevatedButton(
  //                         onPressed: () => Navigator.of(context).pop({
  //                           'type': wicketType,
  //                           'fielder': selectedFielder,
  //                           'runs': runsOnDelivery,
  //                         }),
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color(0xFFFF6B6B),
  //                           foregroundColor: Colors.white,
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 24,
  //                             vertical: 12,
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                         ),
  //                         child: const Text('Confirm Wicket'),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

static Future<Map<String, dynamic>?> showWicketModal(
  BuildContext context, {
  required Map<String, String> dismissedPlayer, // Changed to accept player object with ID
  required List<Map<String, String>> fielders,
}) {
  print("Dismissed Player: ${dismissedPlayer['name']} (ID: ${dismissedPlayer['id']})");
  print("Available Fielders: $fielders");

  String wicketType = 'Caught';
  Map<String, String>? selectedFielder;
  int runsOnDelivery = 0;
  
  final wicketTypes = [
    'Bowled',
    'Caught',
    'LBW',
    'Run Out',
    'Stumped',
    'Hit Wicket',
  ];

  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: const Color(0xFF2A3441),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wicket!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF5252),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dismissedPlayer['name']!, // Display player name
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Wicket Type Selection
                  const Text(
                    'Wicket Type',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4551),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: wicketType,
                        dropdownColor: const Color(0xFF3A4551),
                        style: const TextStyle(color: Colors.white),
                        items: wicketTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            wicketType = newValue!;
                            // Reset fielder if wicket type doesn't need one
                            if (wicketType == 'Bowled' || 
                                wicketType == 'LBW' || 
                                wicketType == 'Hit Wicket') {
                              selectedFielder = null;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Fielder Selection (only for certain wicket types)
                  if (wicketType == 'Caught' || 
                      wicketType == 'Run Out' || 
                      wicketType == 'Stumped') ...[
                    const Text(
                      'Fielder',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A4551),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedFielder?['id'],
                          hint: const Text(
                            'Select fielder (optional)',
                            style: TextStyle(color: Color(0xFF8A9BA8)),
                          ),
                          dropdownColor: const Color(0xFF3A4551),
                          style: const TextStyle(color: Colors.white),
                          items: fielders.map((Map<String, String> fielder) {
                            return DropdownMenuItem<String>(
                              value: fielder['id'],
                              child: Text(fielder['name']!),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedFielder = fielders.firstWhere(
                                (f) => f['id'] == newValue,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  // Runs on Delivery
                  const Text(
                    'Runs on Delivery',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [0, 1, 2, 3, 4, 6].map((runs) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                runsOnDelivery = runs;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: runsOnDelivery == runs
                                    ? const Color(0xFF00BCD4)
                                    : const Color(0xFF3A4551),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: runsOnDelivery == runs
                                      ? const Color(0xFF00BCD4)
                                      : const Color(0xFF4A5561),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  runs.toString(),
                                  style: TextStyle(
                                    color: runsOnDelivery == runs
                                        ? Colors.white
                                        : const Color(0xFF8A9BA8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF8A9BA8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop({
                            'dismissedPlayerId': dismissedPlayer['id']!, // Return dismissed player ID
                            'dismissedPlayerName': dismissedPlayer['name']!, // Return name for display
                            'type': wicketType,
                            'fielderId': selectedFielder?['id'],
                            'fielderName': selectedFielder?['name'],
                            'runs': runsOnDelivery.toString(),
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5252),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Confirm'),
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

  // 3. Select Next Batsman Modal
  // static Future<String?> showNextBatsmanModal(
  //   BuildContext context, {
  //   required List<String> availableBatsmen,
  // }) {
  //   String? selectedBatsman;

  //   return showDialog<String>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Dialog(
  //             backgroundColor: const Color(0xFF2A3441),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(24),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     'Select Next Batsman',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Color(0xFF00BCD4),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 24),
                    
  //                   // Batsman Selection
  //                   const Text(
  //                     'Incoming Batsman',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     width: double.infinity,
  //                     padding: const EdgeInsets.symmetric(horizontal: 16),
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFF3A4551),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: DropdownButtonHideUnderline(
  //                       child: DropdownButton<String>(
  //                         value: selectedBatsman,
  //                         hint: const Text(
  //                           'Choose a player',
  //                           style: TextStyle(color: Color(0xFF8A9BA8)),
  //                         ),
  //                         dropdownColor: const Color(0xFF3A4551),
  //                         style: const TextStyle(color: Colors.white),
  //                         items: availableBatsmen.map((String player) {
  //                           return DropdownMenuItem<String>(
  //                             value: player,
  //                             child: Text(player),
  //                           );
  //                         }).toList(),
  //                         onChanged: (String? newValue) {
  //                           setState(() {
  //                             selectedBatsman = newValue;
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
                    
  //                   const SizedBox(height: 32),
                    
  //                   // Action Button
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       ElevatedButton(
  //                         onPressed: selectedBatsman != null
  //                             ? () => Navigator.of(context).pop(selectedBatsman)
  //                             : null,
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color(0xFF00BCD4),
  //                           foregroundColor: Colors.white,
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 24,
  //                             vertical: 12,
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                         ),
  //                         child: const Text('Confirm'),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


  static Future<Map<String, String>?> showNextBatsmanModal(
  BuildContext context, {
  required List<Map<String, String>> availableBatsmen,
}) {
  Map<String, String>? selectedBatsman;

  return showDialog<Map<String, String>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: const Color(0xFF2A3441),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Next Batsman',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00BCD4),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Incoming Batsman',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4551),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, String>>(
                        value: selectedBatsman,
                        hint: const Text(
                          'Choose a player',
                          style: TextStyle(color: Color(0xFF8A9BA8)),
                        ),
                        dropdownColor: const Color(0xFF3A4551),
                        style: const TextStyle(color: Colors.white),
                        items: availableBatsmen.map((player) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: player,
                            child: Text(player['name'] ?? ''),
                          );
                        }).toList(),
                        onChanged: (Map<String, String>? newValue) {
                          setState(() {
                            selectedBatsman = newValue;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: selectedBatsman != null
                            ? () => Navigator.of(context).pop(selectedBatsman)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Confirm'),
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


  // 4. Innings Break Modal
  static Future<bool?> showInningsBreakModal(
    BuildContext context, {
    required String chasingTeam,
    required int targetRuns,
    required double targetOvers,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A3441),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Innings Break',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00BCD4),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'The first innings has concluded.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8A9BA8),
                  ),
                ),
                const SizedBox(height: 32),
                
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A4551),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$chasingTeam need to score',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$targetRuns',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'runs in ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '$targetOvers',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF00BCD4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' overs to win.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start Chase',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static Future<int?> showRunSelectionModal(BuildContext context) {
  return showDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final List<int> runsList = [0, 1, 2, 3, 4, 5, 6];

      return Dialog(
        backgroundColor: const Color(0xFF2A3441),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Runs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BCD4),
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: runsList.map((run) {
                  return ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(run),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A4551),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      run.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF8A9BA8),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  // 5. Select Opening Batsmen Modal
static Future<Map<String, String>?> showOpeningBatsmenModal(
  BuildContext context, {
  required List<Map<String, String>> availableBatsmen, // now Map list
}) {
    for (var batsman in availableBatsmen) {
    print("ID: ${batsman["id"]}, Name: ${batsman["name"]}");
  }
  Map<String, String>? striker;
  Map<String, String>? nonStriker;

  return showDialog<Map<String, String>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: const Color(0xFF2A3441),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Opening Batsmen',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00BCD4),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Striker Selection
                  const Text(
                    'Striker',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4551),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, String>>(
                        value: striker,
                        hint: const Text(
                          'Choose a player',
                          style: TextStyle(color: Color(0xFF8A9BA8)),
                        ),
                        dropdownColor: const Color(0xFF3A4551),
                        style: const TextStyle(color: Colors.white),
                        items: availableBatsmen
                            .where((player) => player != nonStriker)
                            .map((player) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: player,
                            child: Text(player["name"] ?? ""),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            striker = newValue;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Non-Striker Selection
                  const Text(
                    'Non-Striker',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4551),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF00BCD4),
                        width: 1,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, String>>(
                        value: nonStriker,
                        hint: const Text(
                          'Choose a player',
                          style: TextStyle(color: Color(0xFF8A9BA8)),
                        ),
                        dropdownColor: const Color(0xFF3A4551),
                        style: const TextStyle(color: Colors.white),
                        items: availableBatsmen
                            .where((player) => player != striker)
                            .map((player) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: player,
                            child: Text(player["name"] ?? ""),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            nonStriker = newValue;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF8A9BA8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: (striker != null && nonStriker != null)
                            ? () => Navigator.of(context).pop({
                                  'strikerId': striker!["id"] ?? "",
                                  'strikerName': striker!["name"] ?? "",
                                  'nonStrikerId': nonStriker!["id"] ?? "",
                                  'nonStrikerName': nonStriker!["name"] ?? "",
                                })
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Confirm'),
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


  // 6. Match Over Modal
  static Future<bool?> showMatchOverModal(
    BuildContext context, {
    required String result,
    String? winningTeam,
    String? margin,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A3441),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Match Over!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'The match has concluded.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8A9BA8),
                  ),
                ),
                const SizedBox(height: 32),
                
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A4551),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        result,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF00BCD4),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (winningTeam != null && margin != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          '$winningTeam won by $margin',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Finish & Exit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}