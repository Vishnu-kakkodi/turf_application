import 'package:booking_application/views/Games/GameViews/choose_game_screen.dart';
import 'package:flutter/material.dart';

class ScorecardProScreen extends StatelessWidget {
  const ScorecardProScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F2E),
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
                        Color(0xFF4FC3F7),
                        Color(0xFF29B6F6),
                        Color(0xFF03A9F4),
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
                      color: Color(0xFF8E9AAF),
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
                  color: const Color(0xFF252B3B),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
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
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'What would you like to do today?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8E9AAF),
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
                                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>ChooseGameScreen()));

                              print('Single Game tapped');
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
                                    color: const Color(0xFF7C4DFF).withOpacity(0.3),
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
                                  // SizedBox(height: 8),
                                  // Text(
                                  //   'Track a quick match',
                                  //   style: TextStyle(
                                  //     fontSize: 14,
                                  //     color: Color(0xFFE1BEE7),
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
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
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>ChooseGameScreen()));
                              print('Tournament tapped');
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
                                    color: const Color(0xFF00E676).withOpacity(0.3),
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
                                  // SizedBox(height: 8),
                                  // Text(
                                  //   'Create a competition',
                                  //   style: TextStyle(
                                  //     fontSize: 14,
                                  //     color: Color(0xFFB9F6CA),
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
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
              
              
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage in your main.dart or app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generic Scorecard Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter', // You can use a custom font
      ),
      home: const ScorecardProScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}