
// import 'package:booking_application/views/Cricket/match_setup_screen.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class MatchTossScreen extends StatefulWidget {
//   final String teamA;
//   final String teamB;
  
//   const MatchTossScreen({
//     super.key,
//     this.teamA = 'Mumbai Indians',
//     this.teamB = 'Chennai Super Kings',
//   });

//   @override
//   State<MatchTossScreen> createState() => _MatchTossScreenState();
// }

// class _MatchTossScreenState extends State<MatchTossScreen> 
//     with TickerProviderStateMixin {
//   late AnimationController _coinController;
//   late Animation<double> _coinAnimation;
  
//   String _coinSide = 'H';
//   String? _tossWinner;
//   String _electedTo = 'Bat';
//   bool _isTossCompleted = false;
//   bool _isFlipping = false;

//   @override
//   void initState() {
//     super.initState();
//     _coinController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
    
//     _coinAnimation = Tween<double>(
//       begin: 0.0,
//       end: 8.0, // 8 full rotations
//     ).animate(CurvedAnimation(
//       parent: _coinController,
//       curve: Curves.easeOut,
//     ));
    
//     _coinAnimation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _isFlipping = false;
//           // Randomly determine final side
//           _coinSide = math.Random().nextBool() ? 'H' : 'T';
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _coinController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
              
//               // Main Card
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: const Color(0xFFE0E0E0),
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(32.0),
//                   child: Column(
//                     children: [
//                       // Title
//                       const Text(
//                         'Match Toss',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1976D2),
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
                      
//                       // Team names
//                       Text(
//                         '${widget.teamA} vs ${widget.teamB}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Color(0xFF212121),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 40),
                      
//                       // Coin
//                       AnimatedBuilder(
//                         animation: _coinAnimation,
//                         builder: (context, child) {
//                           return Transform(
//                             alignment: Alignment.center,
//                             transform: Matrix4.identity()
//                               ..setEntry(3, 2, 0.001)
//                               ..rotateY(_coinAnimation.value * math.pi),
//                             child: Container(
//                               width: 120,
//                               height: 120,
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFFD700),
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 10,
//                                     offset: const Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   _coinSide,
//                                   style: const TextStyle(
//                                     fontSize: 48,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF212121),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 32),
                      
//                       // Flip Coin Button
//                       Container(
//                         height: 48,
//                         constraints: const BoxConstraints(minWidth: 140),
//                         child: ElevatedButton(
//                           onPressed: _isFlipping ? null : _flipCoin,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFFF9800),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 2,
//                             shadowColor: Colors.black.withOpacity(0.2),
//                           ),
//                           child: Text(
//                             _isFlipping ? 'Flipping...' : 'Flip Coin',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
                      
//                       // Optional text
//                       const Text(
//                         '(Optional - You can use a physical coin)',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF666666),
//                           fontStyle: FontStyle.italic,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 32),
                      
//                       // Divider
//                       Container(
//                         height: 1,
//                         color: const Color(0xFFE0E0E0),
//                       ),
//                       const SizedBox(height: 32),
                      
//                       // Toss Result Section
//                       const Text(
//                         'Who won the toss?',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Color(0xFF212121),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
                      
//                       // Team Selection Dropdown
//                       Container(
//                         width: double.infinity,
//                         height: 56,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: const Color(0xFFE0E0E0),
//                             width: 2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: _tossWinner,
//                             hint: const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Text(
//                                 'Select Team',
//                                 style: TextStyle(
//                                   color: Color(0xFF666666),
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             icon: const Padding(
//                               padding: EdgeInsets.only(right: 20),
//                               child: Icon(
//                                 Icons.keyboard_arrow_down,
//                                 color: Color(0xFF666666),
//                               ),
//                             ),
//                             isExpanded: true,
//                             dropdownColor: Colors.white,
//                             style: const TextStyle(color: Color(0xFF212121)),
//                             items: [widget.teamA, widget.teamB].map((String team) {
//                               return DropdownMenuItem<String>(
//                                 value: team,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                                   child: Text(
//                                     team,
//                                     style: const TextStyle(
//                                       color: Color(0xFF212121),
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _tossWinner = value;
//                                 _isTossCompleted = value != null;
//                               });
//                             },
//                             selectedItemBuilder: (BuildContext context) {
//                               return [widget.teamA, widget.teamB].map((String team) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       team,
//                                       style: const TextStyle(
//                                         color: Color(0xFF212121),
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }).toList();
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 24),
                      
//                       // Elected to Section
//                       const Text(
//                         'Elected to',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Color(0xFF212121),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
                      
//                       // Bat/Bowl Selection Dropdown
//                       Container(
//                         width: double.infinity,
//                         height: 56,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: const Color(0xFFE0E0E0),
//                             width: 2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: _electedTo,
//                             icon: const Padding(
//                               padding: EdgeInsets.only(right: 20),
//                               child: Icon(
//                                 Icons.keyboard_arrow_down,
//                                 color: Color(0xFF666666),
//                               ),
//                             ),
//                             isExpanded: true,
//                             dropdownColor: Colors.white,
//                             style: const TextStyle(color: Color(0xFF212121)),
//                             items: ['Bat', 'Bowl'].map((String choice) {
//                               return DropdownMenuItem<String>(
//                                 value: choice,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                                   child: Text(
//                                     choice,
//                                     style: const TextStyle(
//                                       color: Color(0xFF212121),
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _electedTo = value!;
//                               });
//                             },
//                             selectedItemBuilder: (BuildContext context) {
//                               return ['Bat', 'Bowl'].map((String choice) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       choice,
//                                       style: const TextStyle(
//                                         color: Color(0xFF212121),
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }).toList();
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
                      
//                       // Start Match Button
//                       Container(
//                         width: double.infinity,
//                         height: 52,
//                         child: ElevatedButton(
//                           onPressed: _isTossCompleted ? _startMatch : null,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: _isTossCompleted 
//                                 ? const Color(0xFF1976D2) 
//                                 : const Color(0xFFE0E0E0),
//                             foregroundColor: _isTossCompleted
//                                 ? Colors.white
//                                 : const Color(0xFF666666),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: _isTossCompleted ? 2 : 0,
//                             shadowColor: _isTossCompleted 
//                                 ? Colors.black.withOpacity(0.2)
//                                 : Colors.transparent,
//                           ),
//                           child: const Text(
//                             'Start Match',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
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

//   void _flipCoin() {
//     setState(() {
//       _isFlipping = true;
//     });
    
//     _coinController.reset();
//     _coinController.forward();
//   }

//   void _startMatch() {
//     if (_tossWinner == null) {
//       _showSnackBar('Please select the toss winner');
//       return;
//     }
    
//     // Determine batting and bowling teams based on toss result
//     String battingTeam;
//     String bowlingTeam;
    
//     if (_electedTo == 'Bat') {
//       battingTeam = _tossWinner!;
//       bowlingTeam = _tossWinner == widget.teamA ? widget.teamB : widget.teamA;
//     } else {
//       bowlingTeam = _tossWinner!;
//       battingTeam = _tossWinner == widget.teamA ? widget.teamB : widget.teamA;
//     }
    
//     // Navigate to match setup screen with proper team assignments
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MatchSetupScreen(
//           teamA: widget.teamA,
//           teamB: widget.teamB,
//           battingTeam: battingTeam,
//           bowlingTeam: bowlingTeam,
//         ),
//       ),
//     );
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: const Color(0xFF1976D2),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
// }














import 'package:booking_application/views/Cricket/match_setup_screen.dart';
import 'package:booking_application/views/Cricket/view_matches_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MatchTossScreen extends StatefulWidget {
  final Team team1;
  final Team team2;
    final String matchId;
  final String userId;
  
  const MatchTossScreen({
    super.key,
    required this.team1,
    required this.team2,
        required this.matchId,
    required this.userId
  });

  @override
  State<MatchTossScreen> createState() => _MatchTossScreenState();
}

class _MatchTossScreenState extends State<MatchTossScreen> 
    with TickerProviderStateMixin {
  late AnimationController _coinController;
  late Animation<double> _coinAnimation;
  
  String _coinSide = 'H';
  Team? _tossWinner;
  String _electedTo = 'Bat';
  bool _isTossCompleted = false;
  bool _isFlipping = false;

  @override
  void initState() {
    super.initState();
    _coinController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _coinAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0, // 8 full rotations
    ).animate(CurvedAnimation(
      parent: _coinController,
      curve: Curves.easeOut,
    ));
    
    _coinAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isFlipping = false;
          // Randomly determine final side
          _coinSide = math.Random().nextBool() ? 'H' : 'T';
        });
      }
    });
  }

  @override
  void dispose() {
    _coinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Main Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      // Title
                      const Text(
                        'Match Toss',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Team names
                      Text(
                        '${widget.team1.teamName} vs ${widget.team2.teamName}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Coin
                      AnimatedBuilder(
                        animation: _coinAnimation,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_coinAnimation.value * math.pi),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  _coinSide,
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF212121),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      // Flip Coin Button
                      Container(
                        height: 48,
                        constraints: const BoxConstraints(minWidth: 140),
                        child: ElevatedButton(
                          onPressed: _isFlipping ? null : _flipCoin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9800),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            shadowColor: Colors.black.withOpacity(0.2),
                          ),
                          child: Text(
                            _isFlipping ? 'Flipping...' : 'Flip Coin',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Optional text
                      const Text(
                        '(Optional - You can use a physical coin)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      
                      // Divider
                      Container(
                        height: 1,
                        color: const Color(0xFFE0E0E0),
                      ),
                      const SizedBox(height: 32),
                      
                      // Toss Result Section
                      const Text(
                        'Who won the toss?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Team Selection Dropdown
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                          child: DropdownButton<Team>(
                            value: _tossWinner,
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Select Team',
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF666666),
                              ),
                            ),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            style: const TextStyle(color: Color(0xFF212121)),
                            items: [widget.team1, widget.team2].map((Team team) {
                              return DropdownMenuItem<Team>(
                                value: team,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    team.teamName,
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (Team? value) {
                              setState(() {
                                _tossWinner = value;
                                _isTossCompleted = value != null;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return [widget.team1, widget.team2].map((Team team) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      team.teamName,
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
                      ),
                      const SizedBox(height: 24),
                      
                      // Elected to Section
                      const Text(
                        'Elected to',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Bat/Bowl Selection Dropdown
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                            value: _electedTo,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF666666),
                              ),
                            ),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            style: const TextStyle(color: Color(0xFF212121)),
                            items: ['Bat', 'Bowl'].map((String choice) {
                              return DropdownMenuItem<String>(
                                value: choice,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    choice,
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _electedTo = value!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ['Bat', 'Bowl'].map((String choice) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      choice,
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
                      ),
                      const SizedBox(height: 40),
                      
                      // Start Match Button
                      Container(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isTossCompleted ? _startMatch : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isTossCompleted 
                                ? const Color(0xFF1976D2) 
                                : const Color(0xFFE0E0E0),
                            foregroundColor: _isTossCompleted
                                ? Colors.white
                                : const Color(0xFF666666),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: _isTossCompleted ? 2 : 0,
                            shadowColor: _isTossCompleted 
                                ? Colors.black.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: const Text(
                            'Start Match',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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

  void _flipCoin() {
    setState(() {
      _isFlipping = true;
    });
    
    _coinController.reset();
    _coinController.forward();
  }

  void _startMatch() {
    if (_tossWinner == null) {
      _showSnackBar('Please select the toss winner');
      return;
    }
    
    // Determine batting and bowling teams based on toss result
    Team battingTeam;
    Team bowlingTeam;
    
    if (_electedTo == 'Bat') {
      battingTeam = _tossWinner!;
      bowlingTeam = _tossWinner!.id == widget.team1.id ? widget.team2 : widget.team1;
    } else {
      bowlingTeam = _tossWinner!;
      battingTeam = _tossWinner!.id == widget.team1.id ? widget.team2 : widget.team1;
    }
    
    // Navigate to match setup screen with proper team assignments
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MatchSetupScreen(
          team1: widget.team1,
          team2: widget.team2,
          battingTeam: battingTeam,
          bowlingTeam: bowlingTeam,
          matchId: widget.matchId,
        userId: widget.userId,
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1976D2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}