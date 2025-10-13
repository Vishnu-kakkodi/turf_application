// // Enhanced CreateMatch
// import 'package:booking_application/views/Games/game_type_selection.dart';
// import 'package:booking_application/views/Games/sport_congig.dart';
// import 'package:flutter/material.dart';


// class CreateMatch extends StatefulWidget {
//   const CreateMatch({super.key});

//   @override
//   State<CreateMatch> createState() => _CreateMatchState();
// }

// class _CreateMatchState extends State<CreateMatch> {
//   SportType? selectedSport;
//   SportConfig? sportConfig;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Create New Match',
//           style: TextStyle(
//             color: Color(0xFF2E7D32),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Select Sport',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF333333),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Choose the sport you want to create a match for',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFF666666),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 1.2,
//                   ),
//                   itemCount: SportType.values.length,
//                   itemBuilder: (context, index) {
//                     final sport = SportType.values[index];
//                     final config = SportConfigurations.getConfig(sport);
                    
//                     return _buildSportCard(
//                       sport: sport,
//                       config: config!,
//                       isSelected: selectedSport == sport,
//                     );
//                   },
//                 ),
//               ),
//               if (selectedSport != null) ...[
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: () => _proceedToNextStep(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF2E7D32),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       'Continue with ${sportConfig!.displayName}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSportCard({
//     required SportType sport,
//     required SportConfig config,
//     required bool isSelected,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedSport = sport;
//           sportConfig = config;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF2E7D32).withOpacity(0.1) : Colors.white,
//           border: Border.all(
//             color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE0E0E0),
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 _getSportIcon(sport),
//                 size: 40,
//                 color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF666666),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 config.displayName,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF333333),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 _getScoreTypeText(config.scoreType),
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF666666),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   IconData _getSportIcon(SportType sport) {
//     switch (sport) {
//       case SportType.badminton:
//         return Icons.sports_tennis;
//       case SportType.tennis:
//         return Icons.sports_tennis;
//       case SportType.football:
//         return Icons.sports_soccer;
//       case SportType.chess:
//         return Icons.extension;
//       case SportType.volleyball:
//         return Icons.sports_volleyball;
//       case SportType.pickleball:
//         return Icons.sports_tennis;
//       case SportType.golf:
//         return Icons.sports_golf;
//     }
//   }

//   String _getScoreTypeText(ScoreType scoreType) {
//     switch (scoreType) {
//       case ScoreType.goalBased:
//         return 'Goal Based';
//       case ScoreType.setBased:
//         return 'Set Based';
//       case ScoreType.winBased:
//         return 'Win Based';
//       case ScoreType.pointBased:
//         return 'Point Based';
//     }
//   }

//   void _proceedToNextStep() {
//     if (sportConfig == null) return;

//     // Always go to score type selection first
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ScoreTypeSelectionScreen(
//           baseSportConfig: sportConfig!,
//         ),
//       ),
//     );
//   }
// }















// Enhanced CreateMatch with API Integration
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/Cricket/view_teams_screen.dart';
import 'package:booking_application/views/Games/GameViews/team_creation.dart';
import 'package:booking_application/views/Games/game_type_selection.dart';
import 'package:booking_application/views/Games/sport_congig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameCategory {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  GameCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory GameCategory.fromJson(Map<String, dynamic> json) {
    return GameCategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: 'http://31.97.206.144:3081${json['imageUrl']}',
    );
  }
}

class CreateMatch extends StatefulWidget {
  const CreateMatch({super.key});

  @override
  State<CreateMatch> createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch> {
  SportType? selectedSport;
  SportConfig? sportConfig;
  String? selectedCategoryId;
  String? selectedCategoryName;
  List<GameCategory> categories = [];
  bool isLoading = true;
  String? errorMessage;
    String? userId;


  @override
  void initState() {
    super.initState();
        loadUserId();

    _fetchGameCategories();
  }

    void loadUserId() async {
    final currentUser = await UserPreferences.getUser();
    setState(() {
      userId = currentUser?.id.toString();
    });
  }

  Future<void> _fetchGameCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/category/gamecategories'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            categories = (data['categories'] as List)
                .map((cat) => GameCategory.fromJson(cat))
                .toList();
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Failed to load categories';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
  }

  SportType? _mapCategoryToSportType(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'badminton':
        return SportType.badminton;
      case 'tennis':
        return SportType.tennis;
      case 'football':
        return SportType.football;
      case 'chess':
        return SportType.chess;
      case 'volleyball':
        return SportType.volleyball;
      case 'pickleball':
        return SportType.pickleball;
      case 'golf':
        return SportType.golf;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create New Match',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2E7D32),
                ),
              )
            : errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                              errorMessage = null;
                            });
                            _fetchGameCategories();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final sport = _mapCategoryToSportType(category.name);
                              
                              if (sport == null) return const SizedBox.shrink();
                              
                              final config = SportConfigurations.getConfig(sport);
                              if (config == null) return const SizedBox.shrink();

                              return _buildSportCard(
                                sport: sport,
                                config: config,
                                category: category,
                                isSelected: selectedSport == sport,
                              );
                            },
                          ),
                        ),
                        if (selectedSport != null) ...[
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () => _proceedToNextStep(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Continue with ${sportConfig!.displayName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildSportCard({
    required SportType sport,
    required SportConfig config,
    required GameCategory category,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSport = sport;
          sportConfig = config;
          selectedCategoryId = category.id;
                    selectedCategoryName = category.name;

        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2E7D32).withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2E7D32)
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getSportIcon(sport),
                size: 40,
                color: isSelected
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFF666666),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                category.description,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSportIcon(SportType sport) {
    switch (sport) {
      case SportType.badminton:
        return Icons.sports_tennis;
      case SportType.tennis:
        return Icons.sports_tennis;
      case SportType.football:
        return Icons.sports_soccer;
      case SportType.chess:
        return Icons.extension;
      case SportType.volleyball:
        return Icons.sports_volleyball;
      case SportType.pickleball:
        return Icons.sports_tennis;
      case SportType.golf:
        return Icons.sports_golf;
    }
  }

  void _proceedToNextStep() {
    if (sportConfig == null || selectedCategoryId == null) return;

    // If individual game → skip team creation
        Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreTypeSelectionScreen(
          baseSportConfig: sportConfig!,
          categoryName: selectedCategoryName.toString(),
          userId: userId.toString(),
          categoryId: selectedCategoryId.toString(),
        ),
      ),
    );
  }

  void _showSnackBar(String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
  
}