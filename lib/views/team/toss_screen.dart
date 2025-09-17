
// // toss_screen.dart
// import 'dart:math';
// import 'package:booking_application/provider/single_match_provider.dart';
// import 'package:booking_application/views/team/match_flow_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TossScreen extends StatefulWidget {
//   final String matchId;
//   final String userId;

//   const TossScreen({Key? key, required this.matchId, required this.userId}) : super(key: key);

//   @override
//   State<TossScreen> createState() => _TossScreenState();
// }

// class _TossScreenState extends State<TossScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _isFlipping = false;
//   String? _result;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: pi * 6).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         final results = ['Heads', 'Tails'];
//         final result = results[DateTime.now().millisecond % 2];
//         setState(() {
//           _result = result;
//           _isFlipping = false;
//         });
//         _controller.reset();
//       }
//     });

//     // Load match data when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<SingleMatchGameProvider>().loadMatchData(widget.userId, widget.matchId);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _flipCoin() {
//     if (_isFlipping) return;

//     setState(() {
//       _isFlipping = true;
//       _result = null;
//     });

//     _controller.forward();
//   }

//   Widget _buildCoinFace(String face) {
//     return Container(
//       width: 120,
//       height: 120,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: LinearGradient(
//           colors: face == "Heads"
//               ? [Colors.amber.shade400, Colors.amber.shade700]
//               : [Colors.blueGrey.shade400, Colors.blueGrey.shade700],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Text(
//           face,
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             shadows: [
//               Shadow(
//                   offset: Offset(2, 2), blurRadius: 4, color: Colors.black45),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Toss Coin',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//         elevation: 0,
//       ),
//       body: Consumer<SingleMatchGameProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 60, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error loading match data',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     provider.error!,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       provider.loadMatchData(widget.userId, widget.matchId);
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           final matchData = provider.matchData;
//           if (matchData == null) {
//             return const Center(child: Text('No match data available'));
//           }

//           final teamNames = provider.getTeamNames();

//           return Align(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: Colors.grey, width: 2)),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Match Toss',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.lightBlue,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           '${teamNames.isNotEmpty ? teamNames[0] : 'Team A'} vs ${teamNames.length > 1 ? teamNames[1] : 'Team B'}',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(height: 40),

//                         // ✅ Coin Animation
//                         AnimatedBuilder(
//                           animation: _animation,
//                           builder: (context, child) {
//                             final angle = _animation.value;
//                             final isHeads = (angle % (2 * pi)) < pi;
//                             return Transform(
//                               alignment: Alignment.center,
//                               transform: Matrix4.identity()
//                                 ..setEntry(3, 2, 0.002) // 3D perspective
//                                 ..rotateY(angle),
//                               child:
//                                   _buildCoinFace(isHeads ? "Heads" : "Tails"),
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         if (_result != null)
//                           Text(
//                             "It's $_result!",
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),

//                         const SizedBox(height: 20),

//                         // ✅ Flip Coin button (optional)
//                         if (!_isFlipping)
//                           ElevatedButton(
//                             onPressed: _flipCoin,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.amber,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 40, vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text(
//                               'Flip Coin',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         if (_isFlipping) const CircularProgressIndicator(),

//                         const SizedBox(height: 8),
//                         const Text(
//                           "(Optional - You can use physical coin)",
//                           style: TextStyle(fontSize: 13, color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // ✅ Team selection dropdowns
//                   const Text(
//                     'Who Won the toss?',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       labelText: 'Select Team',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     value: provider.tossWinner,
//                     items: teamNames.map((teamName) {
//                       return DropdownMenuItem(
//                         value: teamName,
//                         child: Text(teamName),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       if (value != null) {
//                         provider.setTossWinner(value);
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Elected to',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       labelText: 'Select Decision',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     value: provider.electedTo,
//                     items: const [
//                       DropdownMenuItem(value: 'Bat', child: Text('Bat')),
//                       DropdownMenuItem(value: 'Bowl', child: Text('Bowl')),
//                     ],
//                     onChanged: (value) {
//                       if (value != null) {
//                         provider.setElectedTo(value);
//                       }
//                     },
//                   ),

//                   const SizedBox(height: 16),
// const Text(
//   'Enter Overs',
//   style: TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//   ),
// ),
// const SizedBox(height: 16),
// TextFormField(
//   keyboardType: TextInputType.number,
//   decoration: InputDecoration(
//     labelText: 'Number of Overs',
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   ),
//   onChanged: (value) {
//     if (value.isNotEmpty) {
//       context.read<SingleMatchGameProvider>().setOvers(value);
//     }
//   },
// ),

//                   const SizedBox(height: 30),

//                   if (provider.tossWinner != null && provider.electedTo != null)
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MatchSetupFlowScreen(
//                                 matchId: widget.matchId,
//                                 userId: widget.userId,
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.lightBlue,
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Continue Setup',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }













// toss_screen.dart
import 'dart:math';
import 'package:booking_application/provider/single_match_provider.dart';
import 'package:booking_application/views/team/match_flow_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TossScreen extends StatefulWidget {
  final String matchId;
  final String userId;

  const TossScreen({Key? key, required this.matchId, required this.userId}) : super(key: key);

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipping = false;
  String? _result;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi * 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final results = ['Heads', 'Tails'];
        final result = results[DateTime.now().millisecond % 2];
        setState(() {
          _result = result;
          _isFlipping = false;
        });
        _controller.reset();
      }
    });

    // Load match data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SingleMatchGameProvider>().loadMatchData(widget.userId, widget.matchId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCoin() {
    if (_isFlipping) return;

    setState(() {
      _isFlipping = true;
      _result = null;
    });

    _controller.forward();
  }

  Widget _buildCoinFace(String face) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: face == "Heads"
              ? [Colors.amber.shade400, Colors.amber.shade700]
              : [Colors.blueGrey.shade400, Colors.blueGrey.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          face,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                  offset: Offset(2, 2), blurRadius: 4, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Toss Coin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Consumer<SingleMatchGameProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading match data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.loadMatchData(widget.userId, widget.matchId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final matchData = provider.matchData;
          if (matchData == null) {
            return const Center(child: Text('No match data available'));
          }

          final teamNames = provider.getTeamNames();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Add some top spacing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Column(
                    children: [
                      Text(
                        'Match Toss',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${teamNames.isNotEmpty ? teamNames[0] : 'Team A'} vs ${teamNames.length > 1 ? teamNames[1] : 'Team B'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // ✅ Coin Animation
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          final angle = _animation.value;
                          final isHeads = (angle % (2 * pi)) < pi;
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002) // 3D perspective
                              ..rotateY(angle),
                            child:
                                _buildCoinFace(isHeads ? "Heads" : "Tails"),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      if (_result != null)
                        Text(
                          "It's $_result!",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                      const SizedBox(height: 20),

                      // ✅ Flip Coin button (optional)
                      if (!_isFlipping)
                        ElevatedButton(
                          onPressed: _flipCoin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Flip Coin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      if (_isFlipping) const CircularProgressIndicator(),

                      const SizedBox(height: 8),
                      const Text(
                        "(Optional - You can use physical coin)",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ✅ Team selection dropdowns
                const Text(
                  'Who Won the toss?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Team',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: provider.tossWinner,
                  items: teamNames.map((teamName) {
                    return DropdownMenuItem(
                      value: teamName,
                      child: Text(teamName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      provider.setTossWinner(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Elected to',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Decision',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: provider.electedTo,
                  items: const [
                    DropdownMenuItem(value: 'Bat', child: Text('Bat')),
                    DropdownMenuItem(value: 'Bowl', child: Text('Bowl')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      provider.setElectedTo(value);
                    }
                  },
                ),

                const SizedBox(height: 16),
                const Text(
                  'Enter Overs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Overs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      provider.setOvers(value);
                    }
                  },
                ),

                const SizedBox(height: 30),

                if (provider.tossWinner != null && provider.electedTo != null)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchSetupFlowScreen(
                              matchId: widget.matchId,
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continue Setup',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                
                const SizedBox(height: 20), // Add some bottom spacing
              ],
            ),
          );
        },
      ),
    );
  }
}