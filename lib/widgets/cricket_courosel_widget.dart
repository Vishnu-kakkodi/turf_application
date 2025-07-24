import 'dart:async';

import 'package:flutter/material.dart';

class CricketCouroselWidget extends StatefulWidget {
  @override
  _SoccerCarouselState createState() => _SoccerCarouselState();
}

class _SoccerCarouselState extends State<CricketCouroselWidget> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < cricketImages.length - 1) {
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
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: PageView.builder(
            itemCount: cricketImages.length,
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
                    // Image covering the entire container
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          cricketImages[index],
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
                    // Semi-transparent overlay
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
                    // Positioned text
                    const Positioned(
                      left: 20,
                      top: 20,
                      child: Text(
                        'CRICKET',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Page indicator dots positioned after the container
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cricketImages.length,
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

// Define your image list (add this outside the widget)
final List<String> cricketImages = [
  'https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_880/esci/media/motion/2023/0306/dm_230306_INET_CRIC_WTC23_FINAL_DATE_ANNOUNCEMENT/dm_230306_INET_CRIC_WTC23_FINAL_DATE_ANNOUNCEMENT.jpg',
  'https://static.toiimg.com/thumb/msid-101318324,width-1280,height-720,resizemode-4/101318324.jpg',
  'https://www.cricbuzz.com/a/img/v1/600x400/i1/c360834/who-will-prevail-in-the-final.jpg',
  'https://images.news18.com/ibnlive/uploads/2022/05/cricket-ipl-2022.jpg',
];