import 'package:booking_application/views/Games/game_setup_screen.dart';
import 'package:flutter/material.dart';

class ChooseGameScreen extends StatelessWidget {

  const ChooseGameScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              const Center(
                child: Text(
                  'Choose Your Game',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Game Cards Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    GameCard(
                      icon: _buildBadmintonIcon(),
                      title: 'Badminton',
                      onTap: () => _onGameSelected(context, 'Badminton'),
                    ),
                    GameCard(
                      icon: _buildTennisIcon(),
                      title: 'Tennis',
                      onTap: () => _onGameSelected(context, 'Tennis'),
                    ),
                    GameCard(
                      icon: _buildFootballIcon(),
                      title: 'Football',
                      onTap: () => _onGameSelected(context, 'Football'),
                    ),
                    GameCard(
                      icon: _buildChessIcon(),
                      title: 'Chess',
                      onTap: () => _onGameSelected(context, 'Chess'),
                    ),
                    GameCard(
                      icon: _buildVolleyballIcon(),
                      title: 'Volleyball',
                      onTap: () => _onGameSelected(context, 'Volleyball'),
                    ),
                    GameCard(
                      icon: _buildPickleballIcon(),
                      title: 'Pickleball',
                      onTap: () => _onGameSelected(context, 'Pickleball'),
                    ),
                    GameCard(
                      icon: _buildGolfIcon(),
                      title: 'Golf',
                      onTap: () => _onGameSelected(context, 'Golf'),
                    ),
                  ],
                ),
              ),

              // Show Golf in a separate row if needed
              // GameCard(
              //   icon: _buildGolfIcon(),
              //   title: 'Golf',
              //   onTap: () => _onGameSelected(context, 'Golf'),
              // ),

              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onGameSelected(BuildContext context, String gameName) {
    // Handle game selection
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GameSetupScreen(gameName:gameName,)));
  }

  // Custom Icons for each sport
  Widget _buildBadmintonIcon() {
    return CustomPaint(
      size: const Size(40, 40),
      painter: BadmintonIconPainter(),
    );
  }

  Widget _buildTennisIcon() {
    return const Icon(
      Icons.sports_tennis,
      size: 40,
      color: Color(0xFF2E7D32),
    );
  }

  Widget _buildFootballIcon() {
    return const Icon(
      Icons.sports_soccer,
      size: 40,
      color: Color(0xFF2E7D32),
    );
  }

  Widget _buildChessIcon() {
    return CustomPaint(
      size: const Size(40, 40),
      painter: ChessIconPainter(),
    );
  }

  Widget _buildVolleyballIcon() {
    return const Icon(
      Icons.sports_volleyball,
      size: 40,
      color: Color(0xFF2E7D32),
    );
  }

  Widget _buildPickleballIcon() {
    return CustomPaint(
      size: const Size(40, 40),
      painter: PickleballIconPainter(),
    );
  }

  Widget _buildGolfIcon() {
    return const Icon(
      Icons.sports_golf,
      size: 40,
      color: Color(0xFF2E7D32),
    );
  }
}

class GameCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const GameCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painters for specific sports icons
class BadmintonIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Draw shuttlecock shape
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.4,
      size.width * 0.2,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.9,
      size.width * 0.8,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.2,
    );

    canvas.drawPath(path, paint);

    // Draw feathers
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.2),
        Offset(size.width * (0.35 + i * 0.15), size.height * 0.45),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ChessIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Draw chess piece (simplified king)
    final path = Path();
    // Base
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    // Body
    path.moveTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.4, size.height * 0.4);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.lineTo(size.width * 0.7, size.height * 0.8);
    // Crown
    path.moveTo(size.width * 0.4, size.height * 0.4);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.moveTo(size.width * 0.45, size.height * 0.4);
    path.lineTo(size.width * 0.45, size.height * 0.25);
    path.moveTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.2);
    path.moveTo(size.width * 0.55, size.height * 0.4);
    path.lineTo(size.width * 0.55, size.height * 0.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PickleballIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Draw paddle shape
    final paddlePath = Path();
    paddlePath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.35),
      width: size.width * 0.6,
      height: size.height * 0.5,
    ));

    // Draw handle
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.6),
      Offset(size.width * 0.5, size.height * 0.85),
      paint,
    );

    canvas.drawPath(paddlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Updated ScorecardProScreen with navigation
class ScorecardProScreen extends StatelessWidget {
  const ScorecardProScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Header Section
              Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF1976D2),
                        Color(0xFF1565C0),
                        Color(0xFF0D47A1),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Generic Scorecard Pro',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The last scorecard you\'ll ever need.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 80),

              // Welcome Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to Scorecard Pro',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'What would you like to do today?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Buttons Row
                    Row(
                      children: [
                        // Single Game Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChooseGameScreen(
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF7C4DFF),
                                    Color(0xFF651FFF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7C4DFF)
                                        .withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Single Game',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Track a quick match',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFE1BEE7),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Tournament Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChooseGameScreen(
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00E676),
                                    Color(0xFF00C853),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00E676)
                                        .withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tournament',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Create a competition',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFB9F6CA),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Footer
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Powered by React, Tailwind CSS, and Gemini API',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}