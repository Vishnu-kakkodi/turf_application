import 'package:booking_application/views/team/create_match.dart';
import 'package:flutter/material.dart';

class CreateMatch extends StatefulWidget {
  const CreateMatch({super.key});

  @override
  State<CreateMatch> createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLoading = false;

  // Sample match history data
  final List<Map<String, dynamic>> _matchHistory = [
    {
      'matchName': 'Cricket Championship',
      'sport': 'Cricket',
      'date': '15/03/2024',
      'time': '10:00 AM',
      'location': 'Sports Complex A',
      'players': '22',
      'status': 'Completed',
      'statusColor': Colors.green,
    },
    {
      'matchName': 'Football League',
      'sport': 'Football',
      'date': '12/03/2024',
      'time': '6:00 PM',
      'location': 'Stadium B',
      'players': '18',
      'status': 'Ongoing',
      'statusColor': Colors.orange,
    },
    {
      'matchName': 'Basketball Tournament',
      'sport': 'Basketball',
      'date': '10/03/2024',
      'time': '4:00 PM',
      'location': 'Indoor Court',
      'players': '12',
      'status': 'Completed',
      'statusColor': Colors.green,
    },
    {
      'matchName': 'Tennis Singles',
      'sport': 'Tennis',
      'date': '08/03/2024',
      'time': '2:00 PM',
      'location': 'Tennis Court 1',
      'players': '4',
      'status': 'Cancelled',
      'statusColor': Colors.red,
    },
  ];

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  Future<void> _navigateToCreateMatch() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate navigation delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateMatchForm()),
      );
    }
  }

  Widget _buildAnimatedCard({required Widget child, required int delay}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (delay * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildMatchHistoryCard(Map<String, dynamic> match, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    match['matchName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: match['statusColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: match['statusColor'], width: 1),
                  ),
                  child: Text(
                    match['status'],
                    style: TextStyle(
                      color: match['statusColor'],
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sports, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text(
                            match['sport'],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              match['location'],
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text(
                            '${match['date']}${match['time']}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.group, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text(
                            '${match['players']} Players',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Matches',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                // _buildAnimatedCard(
                //   delay: 0,
                //   child: Container(
                //     padding: const EdgeInsets.all(20),
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: [Colors.deepPurple, Colors.purple.shade400],
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //       ),
                //       borderRadius: BorderRadius.circular(16),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.deepPurple.withOpacity(0.3),
                //           blurRadius: 10,
                //           offset: const Offset(0, 5),
                //         ),
                //       ],
                //     ),
                //     child: const Column(
                //       children: [
                //         Icon(
                //           Icons.sports_soccer,
                //           size: 50,
                //           color: Colors.white,
                //         ),
                //         SizedBox(height: 10),
                //         Text(
                //           'Your Match History',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                const SizedBox(height: 30),

                // Create New Match Button

                const SizedBox(height: 30),

                // Match History Section
                _buildAnimatedCard(
                  delay: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Matches',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _matchHistory.length,
                        itemBuilder: (context, index) {
                          return _buildAnimatedCard(
                            delay: 3 + index,
                            child: _buildMatchHistoryCard(
                                _matchHistory[index], index),
                          );
                        },
                      ),
                      _buildAnimatedCard(
                        delay: 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 55,
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : _navigateToCreateMatch,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: Colors.deepPurple.withOpacity(0.4),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_circle_outline, size: 24),
                                      SizedBox(width: 10),
                                      Text(
                                        'Create New Match',
                                        style: TextStyle(
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
