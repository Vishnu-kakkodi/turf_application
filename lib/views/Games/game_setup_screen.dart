import 'package:booking_application/views/Games/game_manager_screen.dart';
import 'package:flutter/material.dart';

class GameSetupScreen extends StatelessWidget {
  final String gameName;
  
  const GameSetupScreen({
    Key? key, 
    required this.gameName,
  }) : super(key: key);

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
        actions: [
          TextButton(
            onPressed: () {
              // Navigate back to game selection
              Navigator.pop(context);
            },
            child: const Text(
              'Change Game',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // Title and Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Setup: $gameName',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'How do you want to keep score?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 60),
              
              // Scoring Options
              Expanded(
                child: Column(
                  children: [
                    ScoreOptionCard(
                      title: 'Goal Based',
                      description: 'Track a single score for each team, like goals in Football or Hockey.',
                      onTap: () => _onScoreTypeSelected(context, 'Goal Based'),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    ScoreOptionCard(
                      title: 'Set Based',
                      description: 'Track points and sets, ideal for games like Tennis or Volleyball.',
                      onTap: () => _onScoreTypeSelected(context, 'Set Based'),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    ScoreOptionCard(
                      title: 'Win Based',
                      description: 'Award a point to a player when they win a round, like in Chess.',
                      onTap: () => _onScoreTypeSelected(context, 'Win Based'),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onScoreTypeSelected(BuildContext context, String scoreType) {

    
    // Here you would typically navigate to the actual scoring screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameManagerScreen()));
  }
}

class ScoreOptionCard extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ScoreOptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ScoreOptionCard> createState() => _ScoreOptionCardState();
}

class _ScoreOptionCardState extends State<ScoreOptionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: _isPressed 
              ? Colors.grey.shade100 
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isPressed 
                ? const Color(0xFF2E7D32).withOpacity(0.3)
                : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(_isPressed ? 0.2 : 0.1),
              blurRadius: _isPressed ? 12 : 8,
              offset: Offset(0, _isPressed ? 6 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated ChooseGameScreen to navigate to GameSetupScreen
class ChooseGameScreen extends StatelessWidget {
  final String gameMode;
  
  const ChooseGameScreen({Key? key, required this.gameMode}) : super(key: key);

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
                  ],
                ),
              ),
              
              GameCard(
                icon: _buildGolfIcon(),
                title: 'Golf',
                onTap: () => _onGameSelected(context, 'Golf'),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onGameSelected(BuildContext context, String gameName) {
    // Navigate to GameSetupScreen instead of just showing snackbar
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameSetupScreen(
          gameName: gameName,
        ),
      ),
    );
  }

  // Icon methods remain the same as in previous implementation
  Widget _buildBadmintonIcon() {
    return CustomPaint(
      size: const Size(40, 40),
      painter: BadmintonIconPainter(),
    );
  }

  Widget _buildTennisIcon() {
    return const Icon(Icons.sports_tennis, size: 40, color: Color(0xFF2E7D32));
  }

  Widget _buildFootballIcon() {
    return const Icon(Icons.sports_soccer, size: 40, color: Color(0xFF2E7D32));
  }

  Widget _buildChessIcon() {
    return CustomPaint(size: const Size(40, 40), painter: ChessIconPainter());
  }

  Widget _buildVolleyballIcon() {
    return const Icon(Icons.sports_volleyball, size: 40, color: Color(0xFF2E7D32));
  }

  Widget _buildPickleballIcon() {
    return CustomPaint(size: const Size(40, 40), painter: PickleballIconPainter());
  }

  Widget _buildGolfIcon() {
    return const Icon(Icons.sports_golf, size: 40, color: Color(0xFF2E7D32));
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
          border: Border.all(color: Colors.grey.shade300, width: 1),
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

// Custom painters remain the same but with updated colors
class BadmintonIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.2, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.9, size.width * 0.8, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width * 0.5, size.height * 0.2);

    canvas.drawPath(path, paint);
    
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

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.moveTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.4, size.height * 0.4);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.lineTo(size.width * 0.7, size.height * 0.8);
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

    final paddlePath = Path();
    paddlePath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.35),
      width: size.width * 0.6,
      height: size.height * 0.5,
    ));
    
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