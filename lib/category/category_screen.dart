import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredGames = [];

  final List<Map<String, String>> _games = const [
    {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
    {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
    {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
    {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
    {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
    {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
    {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
    {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
    {"name": "Cricket", "image": "lib/assets/bc343ff763667486407a9dd7f8e58fd9ae581649.png"},
    {"name": "Football", "image": "lib/assets/9fecf28051403e7ab62bf1924884a57e36a00fe8.png"},
    {"name": "Volleyball", "image": "lib/assets/656c5a97cce75cd48d9a0e226b993f635e6ffd08.png"},
    {"name": "Hockey", "image": "lib/assets/8438a1b9d49b151960c78d4f8f0b0eb3ef34350d.png"},
  ];

  @override
  void initState() {
    super.initState();
    _filteredGames = _games;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredGames = _games
          .where((game) => game['name']!.toLowerCase().contains(query))
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
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
              child: GridView.builder(
                itemCount: _filteredGames.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final game = _filteredGames[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: Image.asset(
                          game['image']!,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        game['name']!,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ],
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
