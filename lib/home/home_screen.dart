import 'package:booking_application/category/category_screen.dart';
import 'package:booking_application/category/cricket_screen.dart';
import 'package:booking_application/details.dart';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/home/enroll_screen.dart';
import 'package:booking_application/modal/registration_model.dart';
import 'package:booking_application/provider/category_provider.dart';
import 'package:booking_application/provider/tournament_category_provider.dart';
import 'package:booking_application/provider/upcoming_tournament_provider.dart';
import 'package:booking_application/views/details_screen.dart';
import 'package:booking_application/views/live_screen.dart';
import 'package:booking_application/views/profile/notification_screen.dart';
import 'package:booking_application/views/profile/profile_screen.dart';
import 'package:booking_application/views/profile/slider_bar_screen.dart';
import 'package:booking_application/widgets/courosel_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/nearby_turf_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'cricket';
  String _selectedTournamentCategory = 'Cricket'; // Add this for tournaments
  String? _currentUserId;

  final List<Map<String, dynamic>> cricketComplexes = [
    {
      'name': 'Cricket Complex',
      'price': '₹500/hr',
      'image':
          'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'name': 'Stadium Arena',
      'price': '₹750/hr',
      'image':
          'https://images.unsplash.com/photo-1531415074968-036ba1b575da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'name': 'Sports Ground',
      'price': '₹400/hr',
      'image':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'name': 'Elite Cricket Club',
      'price': '₹600/hr',
      'image':
          'https://images.unsplash.com/photo-1624526267942-ab0ff8a3e972?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
  ];

  final List<Map<String, dynamic>> recommendedComplexes = [
    {
      'title': 'Cricket Complex',
      'price': '₹500/hr',
      'location': 'Kokinada',
      'image':
          'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Stadium Arena',
      'price': '₹750/hr',
      'location': 'Kokinada',
      'image':
          'https://images.unsplash.com/photo-1531415074968-036ba1b575da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Sports Ground',
      'price': '₹400/hr',
      'location': 'Kokinada',
      'image':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Elite Cricket Club',
      'price': '₹600/hr',
      'location': 'Kokinada',
      'image':
          'https://images.unsplash.com/photo-1624526267942-ab0ff8a3e972?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().fetchCategories();
      context.read<UpcomingTournamentProvider>().fetchUpcomingTournament();
      // Initialize tournament category provider
      context
          .read<TournamentCategoryProvider>()
          .fetchTournamentsByCategory(_selectedTournamentCategory);
      _loadNearbyTurfs();
    });
  }

  void _loadNearbyTurfs() async {
    final user = await UserPreferences.getUser();
    if (user != null && user.id != null) {
      _currentUserId = user.id!;
      if (mounted) {
        Provider.of<LocationProvider>(context, listen: false)
            .fetchNearbyTurfs(userId: user.id!, category: _selectedCategory);
      }
    } else {
      print('User not found or user ID is null');
      if (mounted) {
        Provider.of<LocationProvider>(context, listen: false).clearData();
      }
    }
  }

  // Method to handle category selection
  void _onCategorySelected(String categoryName) {
    if (_currentUserId != null) {
      setState(() {
        _selectedCategory = categoryName.toLowerCase();
        // Update tournament category when turf category changes
        _selectedTournamentCategory = _capitalizeFirstLetter(categoryName);
      });

      // Fetch turfs for the selected category
      Provider.of<LocationProvider>(context, listen: false).fetchNearbyTurfs(
        userId: _currentUserId!,
        category: _selectedCategory,
      );

      // Fetch tournaments for the selected category
      Provider.of<TournamentCategoryProvider>(context, listen: false)
          .fetchTournamentsByCategory(_selectedTournamentCategory);
    }
  }

  // Helper method to capitalize first letter
  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SliderBarScreen(),
        ),
      );
    },
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
          'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
        ),
      ),
    ),
  ),

  title: FutureBuilder<User?>(
    future: UserPreferences.getUser(),
    builder: (context, snapshot) {
      String username = 'Hello';
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData &&
          snapshot.data != null) {
        username = snapshot.data!.name;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.red, size: 16),
              SizedBox(width: 4),
              Text(
                'Hyderabad, India', // 👈 Manual location here
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      );
    },
  ),

  actions: [
    Container(
      margin: const EdgeInsets.all(12),
      width: 38,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationScreen(),
            ),
          );
        },
        child: const Icon(Icons.notifications, color: Colors.black),
      ),
    ),
  ],
),
    

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  labelText: 'Search here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 18),

            SoccerCarousel(),

            const SizedBox(height: 24),

            Row(
              children: [
                const Text(
                  'Select Game',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 130),
                TextButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryScreen()),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      final selectedCategory =
                          result['selectedCategory'] as String?;
                      final userId = result['userId'] as String?;

                      if (selectedCategory != null && userId != null) {
                        setState(() {
                          _selectedCategory = selectedCategory;
                          _currentUserId = userId;
                          _selectedTournamentCategory =
                              _capitalizeFirstLetter(selectedCategory);
                        });

                        Provider.of<LocationProvider>(context, listen: false)
                            .fetchNearbyTurfs(
                          userId: userId,
                          category: selectedCategory,
                        );

                        // Fetch tournaments for the selected category
                        Provider.of<TournamentCategoryProvider>(context,
                                listen: false)
                            .fetchTournamentsByCategory(
                                _selectedTournamentCategory);
                      }
                    }
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                )
              ],
            ),

            const SizedBox(height: 12),

            Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (categoryProvider.errorMessage.isNotEmpty) {
                  return const Center(
                    child: Text(
                      'Error loading categories',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (categoryProvider.categories.isEmpty) {
                  return const Center(
                    child: Text(
                      'No categories available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final displayCategories =
                    categoryProvider.categories.take(4).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: displayCategories.map((category) {
                      bool isSelected =
                          _selectedCategory == category.name.toLowerCase();

                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            print('Selected category: ${category.name}');
                            _onCategorySelected(category.name);
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 27,
                                backgroundColor: isSelected
                                    ? Colors.blue[100]
                                    : Colors.grey[200],
                                child: ClipOval(
                                  child: Image.network(
                                    categoryProvider
                                        .getFullImageUrl(category.imageUrl),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.sports,
                                        size: 35,
                                        color: isSelected
                                            ? Colors.blue[600]
                                            : Colors.grey[600],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 70,
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.blue[600]
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiveScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.purple[800],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.sports_soccer,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Premier League',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Week 10',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
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
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Newcastle_United_Logo.svg/1200px-Newcastle_United_Logo.svg.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Newcastle',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Column(
                            children: [
                              Text(
                                '1 : 4',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                '83\'',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/1200px-Chelsea_FC.svg.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Chelsea',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Away',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Upcoming Matches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),
            _buildUpcomingMatch(),

            const SizedBox(height: 24),

            // Updated Upcoming Tournament Section with Category-based tournaments
            Row(
              children: [
                Text(
                  'Upcoming  Tournament',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnrollScreen(
                                  initialTabIndex: 1,
                                )));
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                // const Icon(
                //   Icons.arrow_forward_ios,
                //   size: 18,
                // )
              ],
            ),

            const SizedBox(height: 12),

            // Updated Consumer to use TournamentCategoryProvider
            Consumer<TournamentCategoryProvider>(
              builder: (context, tournamentProvider, child) {
                if (tournamentProvider.isLoading) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    height: 250,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF1E88E5),
                      ),
                    ),
                  );
                }

                if (tournamentProvider.errorMessage != null) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Text(
                        //   'Error: ${tournamentProvider.errorMessage}',
                        //   style: const TextStyle(color: Colors.red),
                        // ),
                        ElevatedButton(
                          onPressed: () =>
                              tournamentProvider.fetchTournamentsByCategory(
                                  _selectedTournamentCategory),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (tournamentProvider.tournaments.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No $_selectedTournamentCategory tournaments available',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Display first tournament or create a horizontal list for multiple tournaments
                final tournament = tournamentProvider.tournaments.first;
                final baseImageUrl = 'http://31.97.206.144:3081';

                return Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  // tournament.image.isNotEmpty
                                  //     ? '$baseImageUrl${tournament.image}'
                                  //     :
                                  'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF1E88E5),
                                            Color(0xFF4CAF50)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.sports_cricket,
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
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.3),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              // tournament.name ?? 'Tournament Name',
                              '$_selectedTournamentCategory Championship',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '₹${tournament.price ?? 500}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF1E88E5),
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tournament.location ?? 'Kakinada',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (tournament.details?.date != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF1E88E5),
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tournament.details!.date,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EnrollDetails()));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EnrollScreen(initialTabIndex: 1,)));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E88E5),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Enroll Now',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Show tournament count if more than one
                      if (tournamentProvider.tournaments.length > 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${tournamentProvider.tournaments.length - 1} more ${_selectedTournamentCategory.toLowerCase()} tournaments available',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Text(
                  'Select Game For Turf Booking',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryScreen()),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      final selectedCategory =
                          result['selectedCategory'] as String?;
                      final userId = result['userId'] as String?;

                      if (selectedCategory != null && userId != null) {
                        setState(() {
                          _selectedCategory = selectedCategory;
                          _currentUserId = userId;
                        });

                        Provider.of<LocationProvider>(context, listen: false)
                            .fetchNearbyTurfs(
                          userId: userId,
                          category: selectedCategory,
                        );
                      }
                    }
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            ),

            const SizedBox(height: 12),

            // Second category selector for turf booking
            Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (categoryProvider.errorMessage.isNotEmpty) {
                  return const Center(
                    child: Text(
                      'Error loading categories',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (categoryProvider.categories.isEmpty) {
                  return const Center(
                    child: Text(
                      'No categories available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final displayCategories =
                    categoryProvider.categories.take(4).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: displayCategories.map((category) {
                      bool isSelected =
                          _selectedCategory == category.name.toLowerCase();

                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            print('Selected category: ${category.name}');
                            _onCategorySelected(category.name);
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 27,
                                backgroundColor: isSelected
                                    ? Colors.blue[100]
                                    : Colors.grey[200],
                                child: ClipOval(
                                  child: Image.network(
                                    categoryProvider
                                        .getFullImageUrl(category.imageUrl),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.sports,
                                        size: 35,
                                        color: isSelected
                                            ? Colors.blue[600]
                                            : Colors.grey[600],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 70,
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.blue[600]
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Text(
                  'Nearby Turf',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryScreen()),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 220,
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  if (locationProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (locationProvider.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   'Error: ${locationProvider.errorMessage}',
                          //   style: const TextStyle(color: Colors.red),
                          //   textAlign: TextAlign.center,
                          // ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              if (_currentUserId != null) {
                                locationProvider.fetchNearbyTurfs(
                                  userId: _currentUserId!,
                                  category: _selectedCategory,
                                );
                              }
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (locationProvider.nearbyTurfs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_cricket,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No ${_selectedCategory} turfs found nearby',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: locationProvider.nearbyTurfs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final turf = locationProvider.nearbyTurfs[index];
                      return Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Container(
                                height: 95,
                                width: double.infinity,
                                child: turf.images.isNotEmpty
                                    ? Image.network(
                                        'http://31.97.206.144:3081${turf.images.first}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.green[100],
                                            child: const Center(
                                              child: Icon(
                                                Icons.sports_cricket,
                                                color: Colors.green,
                                                size: 30,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: Colors.green[100],
                                        child: const Center(
                                          child: Icon(
                                            Icons.sports_cricket,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            turf.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '₹${turf.pricePerHour}/hr',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 12,
                                          color: Colors.blue[600],
                                        ),
                                        const SizedBox(width: 2),
                                        Expanded(
                                          child: Text(
                                            turf.location,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 12,
                                          color: Colors.blue[600],
                                        ),
                                        const SizedBox(width: 2),
                                        Expanded(
                                          child: Text(
                                            turf.openingTime,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: double.infinity,
                                      height: 28,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                turfId: turf.id,
                                                userId: _currentUserId,
                                                image: turf.images[0],
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[600],
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          elevation: 1,
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: const Text(
                                          'Book Now',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
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
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoryScreen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedComplexes.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final complex = recommendedComplexes[index];
                  return _buildRecommendedCard(
                    complex['title'],
                    complex['price'],
                    complex['location'],
                    complex['image'],
                    context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSportIcon(IconData icon, String label,
      {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[100],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[600],
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.blue : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingMatch() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Premier League',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MatchDetails()));
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Newcastle_United_Logo.svg/1200px-Newcastle_United_Logo.svg.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Newcastle',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          '14th Match, 18 June',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        '02h15m',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/1200px-Chelsea_FC.svg.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Chelsea',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'Today, 02:00 PM',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(String title, String price, String location,
      String imageUrl, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.38,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              userId: _currentUserId,
                            )));
              },
              child: Container(
                height: screenWidth * 0.25,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenWidth * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.sports_cricket,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: screenWidth * 0.03,
                        color: Colors.blue[600],
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SportSelector extends StatelessWidget {
  final List<Map<String, dynamic>> sports = [
    {
      'label': 'Cricket',
      'image': 'lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png',
    },
    {
      'label': 'Football',
      'image': 'lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png',
    },
    {
      'label': 'Volleyball',
      'image': 'lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png',
    },
    {
      'label': 'Hockey',
      'image': 'lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sports.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CricketScreen(),
                ),
              );
            },
            child: _buildSportItem(
              imageUrl: sports[index]['image'],
              label: sports[index]['label'],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSportItem({
    required String imageUrl,
    required String label,
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            child: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(imageUrl),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blue : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
