import 'package:booking_application/category/category_screen.dart';
import 'package:booking_application/home/enroll_screen.dart';
import 'package:booking_application/views/details_screen.dart';
import 'package:booking_application/views/live_screen.dart';
import 'package:booking_application/views/profile/notification_screen.dart';
import 'package:booking_application/views/profile/profile_screen.dart';
import 'package:booking_application/widgets/cricket_courosel_widget.dart';
import 'package:flutter/material.dart';

class CricketScreen extends StatefulWidget {
  final String ?id;
  const CricketScreen({super.key,this.id});

  @override
  State<CricketScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CricketScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
          },
          child: const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
            // child: const Icon(Icons.menu, color: Colors.white),
          ),
        ),
        title: const Text(
          'Hello',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
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
                // color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
              },
              child: const Icon(Icons.notifications, color: Colors.black)),
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
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune),
                  labelText: 'Search here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            SizedBox(
              height: 18,
            ),

            CricketCouroselWidget(),

            const SizedBox(height: 24),

            // Select Game Section
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Game',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 130,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                )
              ],
            ),

            const SizedBox(height: 12),

            // Sports Icons Row
            SportSelector(),
            const SizedBox(height: 24),

           GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiveScreen()),
    );
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top Row: IPL Logo, Match Info, Live Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Image.asset(
                //   'lib/assets/1863940e894174666ffb037b633917c477e22fe1.png',
                //   height: 30,
                // ),
                const SizedBox(width: 8),
                const Text(
                  'Match 38 (RCB opt bowl)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

        // RCB vs CSK Scores
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // RCB
            Column(
              children: [
                Image.asset(
                  'lib/assets/1863940e894174666ffb037b633917c477e22fe1.png',
                  height: 40,
                ),
                const SizedBox(height: 6),
                const Text(
                  'RCB',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '48/3 (4.3 ov)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'CRR: 10.90',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            // VS
            const Text(
              'vs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            // CSK
            Column(
              children: [
                Image.asset(
                  'lib/assets/f8980886d3bccd794ad888444c87b7ae12c672c1.png',
                  height: 40,
                ),
                const SizedBox(height: 6),
                const Text(
                  'CSK',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '215/2 (4.3 ov)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'RR: 10.90',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Required Run Rate
        const Text(
          'RRR: 12.30',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 12),

        // Bottom Status Bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'RCB needs 169 in 93 balls',
              style: TextStyle(
                color: Color.fromARGB(255, 33, 86, 243),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

            const SizedBox(height: 24),

            // Upcoming Matches
            const Text(
              'Upcoming Matches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),
            _buildUpcomingMatch(),
            // _buildUpcomingMatch(
            //     'Premier League', 'Newcastle', 'Chelsea', '7:45 PM'),

            const SizedBox(height: 24),

            // Upcoming Tournament
            const Text(
              'Upcoming Tournament',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),
            Container(
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
                        // Background image covering the entire container
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'lib/assets/cricketimage.png',
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
                              // border: Border.all(),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cricket Tournament',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '₹500',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Color(0xFF1E88E5),
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Kakinada',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(
                        Icons.access_time,
                        color: Color(0xFF1E88E5),
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '09 AM-12 PM',
                        style: TextStyle(
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
                                  builder: (context) => EnrollScreen()));
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
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Select Game For Turf Booking
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Game For Turf Booking',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            ),

            const SizedBox(height: 12),
            SportSelector(),
            // Second Sports Icons Row
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     _buildSportIcon(Icons.sports_cricket, 'Cricket'),
            //     _buildSportIcon(Icons.sports_soccer, 'Football'),
            //     _buildSportIcon(Icons.sports_volleyball, 'Volleyball'),
            //     _buildSportIcon(Icons.sports_hockey, 'Hockey'),
            //   ],
            // ),
            SportSelector(),

            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Nearby Turf',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 130,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ))
              ],
            ),
            // Nearby Turf
            // const Text(
            //   'Nearby Turf',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),

            const SizedBox(height: 12),

            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cricketComplexes.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final complex = cricketComplexes[index];
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
                        // Image section
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Container(
                            height: 95,
                            width: double.infinity,
                            child: Image.network(
                              complex['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
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
                            ),
                          ),
                        ),

                        // Content section
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and price row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      complex['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      complex['price'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                // Location row
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: Colors.blue[600],
                                    ),
                                    const SizedBox(width: 2),
                                    const Text(
                                      'Kokinada',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 2),

                                // Timing row
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 12,
                                      color: Colors.blue[600],
                                    ),
                                    const SizedBox(width: 2),
                                    const Text(
                                      '09 AM - 12 PM open',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),

                                // Book Now button
                                Container(
                                  width: double.infinity,
                                  height: 28,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[600],
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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
              ),
            ),

            const SizedBox(height: 16),

            // Recommended Section
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 110,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            ),

            const SizedBox(height: 12),

            // Horizontal ListView.builder for Recommended cards
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
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cricket World Cup 2025',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

          // Match Details Card
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                // Newcastle (Left Side)
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
                          child: Image.asset(
                            'lib/assets/fc6ee94f8e14bdfffac67a84c061dea4baa9ed2e.png', // Replace with your Newcastle logo path
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'India',
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

                // Time Display (Center)
             const   Column(
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
                    // Container(
                    //   width: 8,
                    //   height: 8,
                    //   decoration: const BoxDecoration(
                    //     color: Colors.red,
                    //     shape: BoxShape.circle,
                    //   ),
                    // ),
                  ],
                ),

                // Chelsea (Right Side)
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
                          child: Image.asset(
                            'lib/assets/e1274028b636cbd91cd06c50c10218f0ba7a9d90.png', // Replace with your Chelsea logo path
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Pakistan',
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
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(
      String title, String price, String location, String imageUrl) {
    return Container(
      width: 140,
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
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>const DetailsScreen()));
              },
              child: Container(
                height: 110,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
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

          // Content section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Location row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.blue[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Price
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
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


// class SportSelector extends StatelessWidget {
//   final List<Map<String, dynamic>> sports = [
//     {
//       'label': 'Cricket',
//       'image': 'https://cdn-icons-png.flaticon.com/128/10595/10595563.png',
//     },
//     {
//       'label': 'Football',
//       'image':
//           'https://cdn4.iconfinder.com/data/icons/sport-icons-set-1/512/a117-512.png',
//     },
//     {
//       'label': 'Volleyball',
//       'image': 'https://atlas-content-cdn.pixelsquid.com/stock-images/cartoon-volleyball-ball-XorJXL9-600.jpg',
//     },
//     {
//       'label': 'Hockey',
//       'image':
//           'https://i.pinimg.com/736x/8d/06/c0/8d06c012e086225e0038247a55c62b5c.jpg',
//     },
//   ];

//   final int selectedIndex =
//       1; // You can make this dynamic with state management

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100, 
//       width: 50,// Set fixed height for horizontal list
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: sports.length,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         itemBuilder: (context, index) {
//           return _buildSportItem(
//             imageUrl: sports[index]['image'],
//             label: sports[index]['label'],
//             isSelected: selectedIndex == index,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSportItem({
//     required String imageUrl,
//     required String label,
//     bool isSelected = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
//             child: CircleAvatar(
//               radius: 26,
//               backgroundImage: NetworkImage(imageUrl),
//               backgroundColor: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: isSelected ? Colors.blue : Colors.grey[700],
//               fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class SportSelector extends StatelessWidget {
  final List<Map<String, dynamic>> sports = [
    {
      'label': 'Cricket',
      'image': 'https://cdn-icons-png.flaticon.com/128/10595/10595563.png',
    },
    {
      'label': 'Football',
      'image': 'https://cdn4.iconfinder.com/data/icons/sport-icons-set-1/512/a117-512.png',
    },
    {
      'label': 'Volleyball',
      'image': 'https://atlas-content-cdn.pixelsquid.com/stock-images/cartoon-volleyball-ball-XorJXL9-600.jpg',
    },
    {
      'label': 'Hockey',
      'image': 'https://i.pinimg.com/736x/8d/06/c0/8d06c012e086225e0038247a55c62b5c.jpg',
    },
  ];

  // final int selectedIndex = 1; // Make this dynamic using state management if needed

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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => ProfileScreen(
                
              //     ),
              //   ),
              // );
            },
            child: _buildSportItem(
              imageUrl: sports[index]['image'],
              label: sports[index]['label'],
              // isSelected: selectedIndex == index,
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
              backgroundImage: NetworkImage(imageUrl),
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