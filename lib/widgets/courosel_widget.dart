// import 'dart:async';

// import 'package:flutter/material.dart';

// class SoccerCarousel extends StatefulWidget {
//   @override
//   _SoccerCarouselState createState() => _SoccerCarouselState();
// }

// class _SoccerCarouselState extends State<SoccerCarousel> {
//   PageController _pageController = PageController();
//   int _currentIndex = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       if (_currentIndex < soccerImages.length - 1) {
//         _currentIndex++;
//       } else {
//         _currentIndex = 0;
//       }
//       _pageController.animateToPage(
//         _currentIndex,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: PageView.builder(
//             itemCount: soccerImages.length,
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF4A90E2), Color(0xFF7BB3F0)],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Stack(
//                   children: [
//                     // Image covering the entire container
//                     Positioned.fill(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           soccerImages[index],
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white24,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: const Center(
//                                 child: Icon(
//                                   Icons.sports_soccer,
//                                   color: Colors.white,
//                                   size: 40,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     // Semi-transparent overlay
//                     Positioned.fill(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.black.withOpacity(0.3),
//                               Colors.transparent,
//                             ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Positioned text
//                     const Positioned(
//                       left: 20,
//                       top: 20,
//                       child: Text(
//                         'SOCCER',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           shadows: [
//                             Shadow(
//                               offset: Offset(1, 1),
//                               blurRadius: 3,
//                               color: Colors.black54,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         // Page indicator dots positioned after the container
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             soccerImages.length,
//             (dotIndex) => Container(
//               width: 8,
//               height: 8,
//               margin: const EdgeInsets.symmetric(horizontal: 2),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: dotIndex == _currentIndex 
//                     ? Colors.blue 
//                     : Colors.grey.withOpacity(0.4),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Define your image list (add this outside the widget)
// final List<String> soccerImages = [
//   'https://npr.brightspotcdn.com/dims4/default/79f7691/2147483647/strip/true/crop/1500x993+0+0/resize/880x583!/quality/90/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Flegacy%2Fsites%2Fvpr%2Ffiles%2F201609%2Fsoccer-ball-istock-Ohmega1982.jpg',
//   'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=800&q=80',
//   'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800&q=80',
//   'https://images.unsplash.com/photo-1553778263-73a83bab9b0c?w=800&q=80',
// ];






















import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SoccerCarousel extends StatefulWidget {
  @override
  _SoccerCarouselState createState() => _SoccerCarouselState();
}

class _SoccerCarouselState extends State<SoccerCarousel> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  List<String> soccerImages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('http://31.97.206.144:3081/admin/getallbanners'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['banners'] != null) {
          setState(() {
            soccerImages = List<String>.from(
              data['banners'].map((banner) => 'http://31.97.206.144:3081${banner['image ']}'),
            );
            isLoading = false;
            _startAutoScroll();
          });
        }
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (soccerImages.isEmpty) return;
      if (_currentIndex < soccerImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (soccerImages.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: Text("No banners available")),
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: PageView.builder(
            itemCount: soccerImages.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF7BB3F0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          soccerImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.sports_soccer,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                    // const Positioned(
                    //   left: 20,
                    //   top: 20,
                    //   child: Text(
                    //     'SOCCER',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 24,
                    //       fontWeight: FontWeight.bold,
                    //       shadows: [
                    //         Shadow(
                    //           offset: Offset(1, 1),
                    //           blurRadius: 3,
                    //           color: Colors.black54,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            soccerImages.length,
            (dotIndex) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotIndex == _currentIndex
                    ? Colors.blue
                    : Colors.grey.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
