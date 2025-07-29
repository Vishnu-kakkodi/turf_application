// import 'package:flutter/material.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, String>> _filteredGames = [];

//   final List<Map<String, String>> _games = const [
//     {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
//     {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
//     {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
//     {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
//     {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
//     {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
//     {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
//     {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
//     {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
//     {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
//     {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
//     {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _filteredGames = _games;
//     _searchController.addListener(_onSearchChanged);
//   }

//   void _onSearchChanged() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredGames = _games
//           .where((game) => game['name']!.toLowerCase().contains(query))
//           .toList();
//     });
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
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
//               child: GridView.builder(
//                 itemCount: _filteredGames.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 12,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) {
//                   final game = _filteredGames[index];
//                   return Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundColor: Colors.grey[200],
//                         child: Image.asset(
//                           game['image']!,
//                           width: 32,
//                           height: 32,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         game['name']!,
//                         style: const TextStyle(fontSize: 12),
//                         textAlign: TextAlign.center,
//                       )
//                     ],
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




import 'package:booking_application/modal/category_model.dart';
import 'package:booking_application/provider/category_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    // Fetch categories when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.fetchCategories().then((_) {
        setState(() {
          _filteredCategories = categoryProvider.categories;
        });
      });
    });
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Professional Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search game...',
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
            const Text(
              'Select Game',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, categoryProvider, child) {
                  // Show loading indicator
                  if (categoryProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Show error message
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

                  // Show empty state
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

                  // Show categories grid
                  return GridView.builder(
                    itemCount: _filteredCategories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final category = _filteredCategories[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle category selection
                          Navigator.pop(context, category);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[200],
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
                                      size: 32,
                                      color: Colors.grey[600],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              category.name,
                              style: const TextStyle(fontSize: 12),
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
            ),
          ],
        ),
      ),
    );
  }
}
