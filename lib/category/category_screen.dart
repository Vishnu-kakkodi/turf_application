// // import 'package:flutter/material.dart';

// // class CategoryScreen extends StatefulWidget {
// //   const CategoryScreen({super.key});

// //   @override
// //   State<CategoryScreen> createState() => _CategoryScreenState();
// // }

// // class _CategoryScreenState extends State<CategoryScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   List<Map<String, String>> _filteredGames = [];

// //   final List<Map<String, String>> _games = const [
// //     {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
// //     {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
// //     {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
// //     {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
// //     {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
// //     {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
// //     {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
// //     {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
// //     {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
// //     {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
// //     {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
// //     {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _filteredGames = _games;
// //     _searchController.addListener(_onSearchChanged);
// //   }

// //   void _onSearchChanged() {
// //     final query = _searchController.text.toLowerCase();
// //     setState(() {
// //       _filteredGames = _games
// //           .where((game) => game['name']!.toLowerCase().contains(query))
// //           .toList();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Select Category',
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         bottom: const PreferredSize(
// //           preferredSize: Size.fromHeight(1),
// //           child: Divider(height: 1, thickness: 1),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Professional Search Field
// //             TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 hintText: 'Search game...',
// //                 prefixIcon: const Icon(Icons.search),
// //                 contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                 ),
// //                 filled: true,
// //                 fillColor: Colors.grey[100],
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               'Select Game',
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 16),
// //             Expanded(
// //               child: GridView.builder(
// //                 itemCount: _filteredGames.length,
// //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 4,
// //                   mainAxisSpacing: 20,
// //                   crossAxisSpacing: 12,
// //                   childAspectRatio: 0.8,
// //                 ),
// //                 itemBuilder: (context, index) {
// //                   final game = _filteredGames[index];
// //                   return Column(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 30,
// //                         backgroundColor: Colors.grey[200],
// //                         child: Image.asset(
// //                           game['image']!,
// //                           width: 32,
// //                           height: 32,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 6),
// //                       Text(
// //                         game['name']!,
// //                         style: const TextStyle(fontSize: 12),
// //                         textAlign: TextAlign.center,
// //                       )
// //                     ],
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:booking_application/modal/category_model.dart';
// // import 'package:booking_application/provider/category_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class CategoryScreen extends StatefulWidget {
// //   const CategoryScreen({super.key});

// //   @override
// //   State<CategoryScreen> createState() => _CategoryScreenState();
// // }

// // class _CategoryScreenState extends State<CategoryScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   List<Category> _filteredCategories = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _searchController.addListener(_onSearchChanged);

// //     // Fetch categories when screen loads
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       final categoryProvider =
// //           Provider.of<CategoryProvider>(context, listen: false);
// //       categoryProvider.fetchCategories().then((_) {
// //         setState(() {
// //           _filteredCategories = categoryProvider.categories;
// //         });
// //       });
// //     });
// //   }

// //   void _onSearchChanged() {
// //     final query = _searchController.text.toLowerCase();
// //     final categoryProvider =
// //         Provider.of<CategoryProvider>(context, listen: false);

// //     setState(() {
// //       _filteredCategories = categoryProvider.categories
// //           .where((category) => category.name.toLowerCase().contains(query))
// //           .toList();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Select Category',
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         automaticallyImplyLeading: false,
// //         centerTitle: true,
// //         // leading: IconButton(
// //         //   icon: const Icon(Icons.arrow_back),
// //         //   onPressed: () => Navigator.pop(context),
// //         // ),
// //         bottom: const PreferredSize(
// //           preferredSize: Size.fromHeight(1),
// //           child: Divider(height: 1, thickness: 1),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Professional Search Field
// //             TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 hintText: 'Search game...',
// //                 prefixIcon: const Icon(Icons.search),
// //                 contentPadding:
// //                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                 ),
// //                 filled: true,
// //                 fillColor: Colors.grey[100],
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               'Select Game',
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 16),
// //             Expanded(
// //               child: Consumer<CategoryProvider>(
// //                 builder: (context, categoryProvider, child) {
// //                   // Show loading indicator
// //                   if (categoryProvider.isLoading) {
// //                     return const Center(
// //                       child: CircularProgressIndicator(),
// //                     );
// //                   }

// //                   // Show error message
// //                   if (categoryProvider.errorMessage.isNotEmpty) {
// //                     return Center(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(
// //                             Icons.error_outline,
// //                             size: 48,
// //                             color: Colors.red[300],
// //                           ),
// //                           const SizedBox(height: 16),
// //                           Text(
// //                             'Error: ${categoryProvider.errorMessage}',
// //                             style: const TextStyle(fontSize: 16),
// //                             textAlign: TextAlign.center,
// //                           ),
// //                           const SizedBox(height: 16),
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               categoryProvider.fetchCategories().then((_) {
// //                                 setState(() {
// //                                   _filteredCategories =
// //                                       categoryProvider.categories;
// //                                 });
// //                               });
// //                             },
// //                             child: const Text('Retry'),
// //                           ),
// //                         ],
// //                       ),
// //                     );
// //                   }

// //                   // Show empty state
// //                   if (_filteredCategories.isEmpty &&
// //                       categoryProvider.categories.isNotEmpty) {
// //                     return const Center(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(
// //                             Icons.search_off,
// //                             size: 48,
// //                             color: Colors.grey,
// //                           ),
// //                           SizedBox(height: 16),
// //                           Text(
// //                             'No games found',
// //                             style: TextStyle(fontSize: 16, color: Colors.grey),
// //                           ),
// //                         ],
// //                       ),
// //                     );
// //                   }

// //                   // Show categories grid
// //                   return GridView.builder(
// //                     itemCount: _filteredCategories.length,
// //                     gridDelegate:
// //                         const SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 4,
// //                       mainAxisSpacing: 20,
// //                       crossAxisSpacing: 12,
// //                       childAspectRatio: 0.8,
// //                     ),
// //                     itemBuilder: (context, index) {
// //                       final category = _filteredCategories[index];
// //                       return GestureDetector(
// //                         onTap: () {

// //                           print('selected category ${category.name}');
// //                           // Handle category selection
// //                           // Navigator.pop(context, category);
// //                         },
// //                         child: Column(
// //                           children: [
// //                             CircleAvatar(
// //                               radius: 30,
// //                               backgroundColor: Colors.grey[200],
// //                               child: ClipOval(
// //                                 child: Image.network(
// //                                   categoryProvider
// //                                       .getFullImageUrl(category.imageUrl),
// //                                   width: 60,
// //                                   height: 60,
// //                                   fit: BoxFit.cover,
// //                                   loadingBuilder:
// //                                       (context, child, loadingProgress) {
// //                                     if (loadingProgress == null) return child;
// //                                     return SizedBox(
// //                                       width: 32,
// //                                       height: 32,
// //                                       child: CircularProgressIndicator(
// //                                         strokeWidth: 2,
// //                                         value: loadingProgress
// //                                                     .expectedTotalBytes !=
// //                                                 null
// //                                             ? loadingProgress
// //                                                     .cumulativeBytesLoaded /
// //                                                 loadingProgress
// //                                                     .expectedTotalBytes!
// //                                             : null,
// //                                       ),
// //                                     );
// //                                   },
// //                                   errorBuilder: (context, error, stackTrace) {
// //                                     return Icon(
// //                                       Icons.sports,
// //                                       size: 32,
// //                                       color: Colors.grey[600],
// //                                     );
// //                                   },
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 6),
// //                             Text(
// //                               category.name,
// //                               style: const TextStyle(fontSize: 12),
// //                               textAlign: TextAlign.center,
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             )
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:booking_application/modal/category_model.dart';
// import 'package:booking_application/provider/category_provider.dart';
// import 'package:booking_application/helper/storage_helper.dart'; // Add this import
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Category> _filteredCategories = [];
//   String? _currentUserId; // Store user ID

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//     _loadUserId(); // Load user ID

//     // Fetch categories when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final categoryProvider =
//           Provider.of<CategoryProvider>(context, listen: false);
//       categoryProvider.fetchCategories().then((_) {
//         setState(() {
//           _filteredCategories = categoryProvider.categories;
//         });
//       });
//     });
//   }

//   // Load user ID from preferences
//   void _loadUserId() async {
//     final user = await UserPreferences.getUser();
//     if (user != null && user.id != null) {
//       setState(() {
//         _currentUserId = user.id!;
//       });
//     }
//   }

//   void _onSearchChanged() {
//     final query = _searchController.text.toLowerCase();
//     final categoryProvider =
//         Provider.of<CategoryProvider>(context, listen: false);

//     setState(() {
//       _filteredCategories = categoryProvider.categories
//           .where((category) => category.name.toLowerCase().contains(query))
//           .toList();
//     });
//   }

//   // Handle category selection - navigate back to HomeScreen with selected category
//   void _onCategorySelected(String categoryName) {
//     if (_currentUserId != null) {
//       print('Selected category: $categoryName');

//       // Navigate back to HomeScreen and pass the selected category
//       Navigator.pop(context, {
//         'selectedCategory': categoryName.toLowerCase(),
//         'userId': _currentUserId!,
//       });
//     } else {
//       // Show error if user ID is not available
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('User not found. Please login again.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Select Category',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         bottom: const PreferredSize(
//           preferredSize: Size.fromHeight(1),
//           child: Divider(height: 1, thickness: 1),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Professional Search Field
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search game...',
//                 prefixIcon: const Icon(Icons.search),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Select Game',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: Consumer<CategoryProvider>(
//                 builder: (context, categoryProvider, child) {
//                   // Show loading indicator
//                   if (categoryProvider.isLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }

//                   // Show error message
//                   if (categoryProvider.errorMessage.isNotEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.error_outline,
//                             size: 48,
//                             color: Colors.red[300],
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Error: ${categoryProvider.errorMessage}',
//                             style: const TextStyle(fontSize: 16),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             onPressed: () {
//                               categoryProvider.fetchCategories().then((_) {
//                                 setState(() {
//                                   _filteredCategories =
//                                       categoryProvider.categories;
//                                 });
//                               });
//                             },
//                             child: const Text('Retry'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   // Show empty state
//                   if (_filteredCategories.isEmpty &&
//                       categoryProvider.categories.isNotEmpty) {
//                     return const Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.search_off,
//                             size: 48,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(height: 16),
//                           Text(
//                             'No games found',
//                             style: TextStyle(fontSize: 16, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   // Show categories grid
//                   return GridView.builder(
//                     itemCount: _filteredCategories.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       mainAxisSpacing: 20,
//                       crossAxisSpacing: 12,
//                       childAspectRatio: 0.8,
//                     ),
//                     itemBuilder: (context, index) {
//                       final category = _filteredCategories[index];
//                       return GestureDetector(
//                         onTap: () {
//                           // Handle category selection with navigation
//                           _onCategorySelected(category.name);
//                         },
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.grey[200],
//                               child: ClipOval(
//                                 child: Image.network(
//                                   categoryProvider
//                                       .getFullImageUrl(category.imageUrl),
//                                   width: 60,
//                                   height: 60,
//                                   fit: BoxFit.cover,
//                                   loadingBuilder:
//                                       (context, child, loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return SizedBox(
//                                       width: 32,
//                                       height: 32,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         value: loadingProgress
//                                                     .expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 loadingProgress
//                                                     .expectedTotalBytes!
//                                             : null,
//                                       ),
//                                     );
//                                   },
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Icon(
//                                       Icons.sports,
//                                       size: 32,
//                                       color: Colors.grey[600],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               category.name,
//                               style: const TextStyle(fontSize: 12),
//                               textAlign: TextAlign.center,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:booking_application/details.dart';
import 'package:booking_application/modal/category_model.dart';
import 'package:booking_application/provider/category_provider.dart';
import 'package:booking_application/provider/tournament_category_provider.dart';
import 'package:booking_application/provider/nearby_turf_provider.dart';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/home/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];
  String? _currentUserId;
  String _selectedCategory = 'cricket';
  String _selectedTournamentCategory = 'Cricket';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadUserId();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.fetchCategories().then((_) {
        setState(() {
          _filteredCategories = categoryProvider.categories;
        });
      });

      // Initialize tournament and turf data
      _loadTournamentAndTurfData();
    });
  }

  void _loadUserId() async {
    final user = await UserPreferences.getUser();
    if (user != null && user.id != null) {
      setState(() {
        _currentUserId = user.id!;
      });
    }
  }

  void _loadTournamentAndTurfData() {
    if (_currentUserId != null) {
      // Load tournaments for selected category
      context
          .read<TournamentCategoryProvider>()
          .fetchTournamentsByCategory(_selectedTournamentCategory);

      // Load nearby turfs for selected category
      context.read<LocationProvider>().fetchNearbyTurfs(
            userId: _currentUserId!,
            category: _selectedCategory,
          );
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    setState(() {
      _filteredCategories = categoryProvider.categories
          .where((category) => category.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _onCategorySelected(String categoryName) {
    if (_currentUserId != null) {
      setState(() {
        _selectedCategory = categoryName.toLowerCase();
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

      print('Selected category: $categoryName');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Category',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Professional Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search game here',
                prefixIcon: const Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),

            // Categories Grid Section
            const Text(
              'Select Game',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (categoryProvider.errorMessage.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${categoryProvider.errorMessage}',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            categoryProvider.fetchCategories().then((_) {
                              setState(() {
                                _filteredCategories =
                                    categoryProvider.categories;
                              });
                            });
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (_filteredCategories.isEmpty &&
                    categoryProvider.categories.isNotEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No games found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: _filteredCategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final category = _filteredCategories[index];
                    bool isSelected =
                        _selectedCategory == category.name.toLowerCase();

                    return GestureDetector(
                      onTap: () {
                        _onCategorySelected(category.name);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: isSelected
                                ? Colors.blue[100]
                                : Colors.grey[200],
                            child: ClipOval(
                              child: Image.network(
                                categoryProvider
                                    .getFullImageUrl(category.imageUrl),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                                    size: 32,
                                    color: isSelected
                                        ? Colors.blue[600]
                                        : Colors.grey[600],
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isSelected ? Colors.blue[600] : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 32),

            // Upcoming Tournament Section
            const Text(
              'Upcoming Tournament',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Consumer<TournamentCategoryProvider>(
              builder: (context, tournamentProvider, child) {
                if (tournamentProvider.isLoading) {
                  return Container(
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
                    child: Column(
                      children: [
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

                final tournament = tournamentProvider.tournaments.first;

                return Container(
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const EnrollDetails()));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>const EnrollScreen(initialTabIndex: 1,)));
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

            const SizedBox(height: 32),

            // Nearby Turfs Section
            // const Text(
            //   'Nearby Turfs',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // const SizedBox(height: 12),

            // Consumer<LocationProvider>(
            //   builder: (context, locationProvider, child) {
            //     if (locationProvider.isLoading) {
            //       return Container(
            //         height: 200,
            //         child: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }

            //     if (locationProvider.errorMessage != null) {
            //       return Container(
            //         height: 150,
            //         child: Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               const SizedBox(height: 8),
            //               ElevatedButton(
            //                 onPressed: () {
            //                   if (_currentUserId != null) {
            //                     locationProvider.fetchNearbyTurfs(
            //                       userId: _currentUserId!,
            //                       category: _selectedCategory,
            //                     );
            //                   }
            //                 },
            //                 child: const Text('Retry'),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }

            //     if (locationProvider.nearbyTurfs.isEmpty) {
            //       return Container(
            //         height: 150,
            //         child: Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.sports_cricket,
            //                 size: 48,
            //                 color: Colors.grey[400],
            //               ),
            //               const SizedBox(height: 8),
            //               Text(
            //                 'No ${_selectedCategory} turfs found nearby',
            //                 style: TextStyle(
            //                   color: Colors.grey[600],
            //                   fontSize: 14,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }

            //     return Column(
            //       children: List.generate(
            //         locationProvider.nearbyTurfs.length > 5
            //             ? 5
            //             : locationProvider.nearbyTurfs.length,
            //         (index) {
            //           final turf = locationProvider.nearbyTurfs[index];
            //           return Container(
            //             margin: const EdgeInsets.only(bottom: 16),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(12),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.2),
            //                   spreadRadius: 1,
            //                   blurRadius: 4,
            //                   offset: const Offset(0, 2),
            //                 ),
            //               ],
            //             ),
            //             child: Row(
            //               children: [
            //                 ClipRRect(
            //                   borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(12),
            //                     bottomLeft: Radius.circular(12),
            //                   ),
            //                   child: Container(
            //                     height: 100,
            //                     width: 100,
            //                     child: turf.images.isNotEmpty
            //                         ? Image.network(
            //                             'http://31.97.206.144:3081${turf.images.first}',
            //                             fit: BoxFit.cover,
            //                             errorBuilder: (context, error, stackTrace) {
            //                               return Container(
            //                                 color: Colors.green[100],
            //                                 child: const Center(
            //                                   child: Icon(
            //                                     Icons.sports_cricket,
            //                                     color: Colors.green,
            //                                     size: 30,
            //                                   ),
            //                                 ),
            //                               );
            //                             },
            //                           )
            //                         : Container(
            //                             color: Colors.green[100],
            //                             child: const Center(
            //                               child: Icon(
            //                                 Icons.sports_cricket,
            //                                 color: Colors.green,
            //                                 size: 30,
            //                               ),
            //                             ),
            //                           ),
            //                   ),
            //                 ),
            //                 Expanded(
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(12),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Expanded(
            //                               child: Text(
            //                                 turf.name,
            //                                 style: const TextStyle(
            //                                   fontSize: 16,
            //                                   fontWeight: FontWeight.w600,
            //                                   color: Colors.black87,
            //                                 ),
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                             ),
            //                             Text(
            //                               '₹${turf.pricePerHour}/hr',
            //                               style: const TextStyle(
            //                                 fontSize: 16,
            //                                 fontWeight: FontWeight.w600,
            //                                 color: Colors.black87,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         const SizedBox(height: 4),
            //                         Row(
            //                           children: [
            //                             Icon(
            //                               Icons.location_on,
            //                               size: 16,
            //                               color: Colors.blue[600],
            //                             ),
            //                             const SizedBox(width: 4),
            //                             Expanded(
            //                               child: Text(
            //                                 turf.location,
            //                                 style: const TextStyle(
            //                                   fontSize: 12,
            //                                   color: Colors.grey,
            //                                 ),
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         const SizedBox(height: 2),
            //                         Row(
            //                           children: [
            //                             Icon(
            //                               Icons.access_time,
            //                               size: 16,
            //                               color: Colors.blue[600],
            //                             ),
            //                             const SizedBox(width: 4),
            //                             Expanded(
            //                               child: Text(
            //                                 turf.openingTime,
            //                                 style: const TextStyle(
            //                                   fontSize: 12,
            //                                   color: Colors.grey,
            //                                 ),
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         const SizedBox(height: 8),
            //                         Align(
            //                           alignment: Alignment.centerRight,
            //                           child: SizedBox(
            //                             height: 32,
            //                             child: ElevatedButton(
            //                               onPressed: () {
            //                                 Navigator.push(
            //                                   context,
            //                                   MaterialPageRoute(
            //                                     builder: (context) => DetailsScreen(
            //                                       turfId: turf.id,
            //                                       userId: _currentUserId,
            //                                       image: turf.images[0],
            //                                     ),
            //                                   ),
            //                                 );
            //                               },
            //                               style: ElevatedButton.styleFrom(
            //                                 backgroundColor: Colors.blue[600],
            //                                 foregroundColor: Colors.white,
            //                                 shape: RoundedRectangleBorder(
            //                                   borderRadius: BorderRadius.circular(20),
            //                                 ),
            //                                 elevation: 1,
            //                                 padding: const EdgeInsets.symmetric(horizontal: 16),
            //                               ),
            //                               child: const Text(
            //                                 'Book Now',
            //                                 style: TextStyle(
            //                                   fontSize: 12,
            //                                   fontWeight: FontWeight.w500,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       ),
            //     );
            //   },
            // ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
