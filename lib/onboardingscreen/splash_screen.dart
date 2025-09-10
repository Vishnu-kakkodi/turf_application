
// import 'package:booking_application/auth/login_screen.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _buttonController;

//   @override
//   void initState() {
//     super.initState();

//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     )..forward();

//     _buttonController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     Future.delayed(const Duration(milliseconds: 800), () {
//       _buttonController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _buttonController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(height: 250),
//             Center(
//               child: ScaleTransition(
//                 scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//                   parent: _logoController,
//                   curve: Curves.elasticOut,
//                 )),
//                 child: Container(
//                   height: 165,
//                   width: 165,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFF1EADFF), 
//                   ),
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'LOGO',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                       letterSpacing: 2,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const Spacer(),
//             FadeTransition(
//               opacity: _buttonController,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 40.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Updated navigation to PageView
//                     Navigator.push(
//                       context, 
//                       MaterialPageRoute(builder: (context) => const OnboardingPageView())
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1EADFF),
//                     minimumSize: const Size(350, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     'Get Started',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class OnboardingPageView extends StatefulWidget {
//   const OnboardingPageView({super.key});

//   @override
//   State<OnboardingPageView> createState() => _OnboardingPageViewState();
// }

// class _OnboardingPageViewState extends State<OnboardingPageView> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<OnboardingData> _onboardingData = [
//     OnboardingData(
//       imageUrl: 'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1200,q_50/lsci/db/PICTURES/CMS/395800/395802.jpg',
//       title: 'Create and manage\ntournaments with ease',
//       description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
//     ),
//     OnboardingData(
//       imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Church_Times_Cricket_Cup_final_2019%2C_Wicket_3.jpg/1200px-Church_Times_Cricket_Cup_final_2019%2C_Wicket_3.jpg',
//       title: 'Schedule matches,set\n rules,and track result',
//       description: 'Monitor statistics, analyze games, and help your team improve with detailed insights and reports',
//     ),
//     OnboardingData(
//       imageUrl: 'https://cdn.prod.website-files.com/5ca5fe687e34be0992df1fbe/6235ea7fbaf601e8d3980228_boy-kicking-ball-on-football-field-2021-09-24-03-47-56-utc-min-min.jpg',
//       title: 'Schedule matches,set\n rules,and track result',
//       description: 'Join a global community of sports enthusiasts and discover new opportunities to play and compete',
//     ),
//   ];

//   void _nextPage() {
//     if (_currentPage < _onboardingData.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       // Navigate to login screen when on last page
//       Navigator.pushReplacement(
//         context, 
//         MaterialPageRoute(builder: (context) => LoginScreen())
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             itemCount: _onboardingData.length,
//             itemBuilder: (context, index) {
//               return OnboardingPage(
//                 data: _onboardingData[index],
//                 currentPage: _currentPage,
//                 totalPages: _onboardingData.length,
//                 onNext: _nextPage,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OnboardingPage extends StatelessWidget {
//   final OnboardingData data;
//   final int currentPage;
//   final int totalPages;
//   final VoidCallback onNext;

//   const OnboardingPage({
//     super.key,
//     required this.data,
//     required this.currentPage,
//     required this.totalPages,
//     required this.onNext,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background image
//         SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: Image.network(
//             data.imageUrl,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return Container(
//                 color: Colors.grey[300],
//                 child: const Center(
//                   child: Icon(Icons.error, size: 50, color: Colors.grey),
//                 ),
//               );
//             },
//           ),
//         ),

//         // Dark gradient overlay at bottom
//         Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.transparent,
//                 Colors.black87,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.6, 1],
//             ),
//           ),
//         ),

//         // Content over the image
//         Positioned(
//           left: 20,
//           right: 20,
//           bottom: 80,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 data.title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 data.description,
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Page Indicator and Button
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Dot indicators
//                   Row(
//                     children: List.generate(
//                       totalPages,
//                       (index) => Container(
//                         margin: const EdgeInsets.only(right: 8),
//                         child: _buildDot(isActive: index == currentPage),
//                       ),
//                     ),
//                   ),

//                   // Next button - FIXED: Now uses onNext callback properly
//                   GestureDetector(
//                     onTap: onNext, // This will handle both arrow (next page) and check (login) properly
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFF1EADFF),
//                       ),
//                       child: Icon(
//                         currentPage == totalPages - 1 
//                           ? Icons.check  // Show check icon on last page
//                           : Icons.arrow_forward, // Show arrow on other pages
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDot({required bool isActive}) {
//     return Container(
//       height: 8,
//       width: isActive ? 20 : 8,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : Colors.white54,
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }

// class OnboardingData {
//   final String imageUrl;
//   final String title;
//   final String description;

//   OnboardingData({
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//   });
// }





























import 'package:booking_application/auth/login_screen.dart';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/home/navbar_screen.dart';
import 'package:flutter/material.dart';
// Import your navbar screen here - replace with actual import
// import 'package:booking_application/screens/navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Check login status and navigate accordingly
    _checkLoginStatusAndNavigate();
  }

  Future<void> _checkLoginStatusAndNavigate() async {
    // Wait for animations to complete
    await Future.delayed(const Duration(milliseconds: 1800));
    
    // Check if user is logged in
    final isLoggedIn = await UserPreferences.isLoggedIn();
    
    if (mounted) {
      if (isLoggedIn) {
        // User is logged in - redirect to navbar screen
        _navigateToNavbar();
      } else {
        // User is not logged in - show get started button
        _buttonController.forward();
      }
    }
  }

  void _navigateToNavbar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        // Replace NavbarScreen() with your actual navbar screen
        builder: (context) => const NavbarScreen(), // You need to import this
      ),
    );
  }

  void _navigateToOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const OnboardingPageView(),
    //   ),
    // );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 250),
            Center(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: _logoController,
                  curve: Curves.elasticOut,
                )),
                child: Container(
                  height: 165,
                  width: 165,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1EADFF), 
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'LOGO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),

                ),
              
              ),

            ),
            SizedBox(height: 14,),
            Text('📍  Manjeera Trinity Corporate\nJNTU Road,kukatpally,Hyderabad\n                       50072,India',style: TextStyle(fontWeight: FontWeight.bold),),
            const Spacer(),
            FadeTransition(
              opacity: _buttonController,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: ElevatedButton(
                  onPressed: _navigateToOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1EADFF),
                    minimumSize: const Size(350, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for NavbarScreen - replace with your actual navbar screen


class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      imageUrl: 'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1200,q_50/lsci/db/PICTURES/CMS/395800/395802.jpg',
      title: 'Create and manage\ntournaments with ease',
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
    ),
    OnboardingData(
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Church_Times_Cricket_Cup_final_2019%2C_Wicket_3.jpg/1200px-Church_Times_Cricket_Cup_final_2019%2C_Wicket_3.jpg',
      title: 'Schedule matches,set\n rules,and track result',
      description: 'Monitor statistics, analyze games, and help your team improve with detailed insights and reports',
    ),
    OnboardingData(
      imageUrl: 'https://cdn.prod.website-files.com/5ca5fe687e34be0992df1fbe/6235ea7fbaf601e8d3980228_boy-kicking-ball-on-football-field-2021-09-24-03-47-56-utc-min-min.jpg',
      title: 'Schedule matches,set\n rules,and track result',
      description: 'Join a global community of sports enthusiasts and discover new opportunities to play and compete',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login screen when on last page
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => LoginScreen())
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                data: _onboardingData[index],
                currentPage: _currentPage,
                totalPages: _onboardingData.length,
                onNext: _nextPage,
              );
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(
            data.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.error, size: 50, color: Colors.grey),
                ),
              );
            },
          ),
        ),

        // Dark gradient overlay at bottom
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black87,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 1],
            ),
          ),
        ),

        // Content over the image
        Positioned(
          left: 20,
          right: 20,
          bottom: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              // Page Indicator and Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot indicators
                  Row(
                    children: List.generate(
                      totalPages,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: _buildDot(isActive: index == currentPage),
                      ),
                    ),
                  ),

                  // Next button
                  GestureDetector(
                    onTap: onNext,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1EADFF),
                      ),
                      child: Icon(
                        currentPage == totalPages - 1 
                          ? Icons.check
                          : Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingData {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingData({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}