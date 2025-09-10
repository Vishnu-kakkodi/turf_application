import 'package:booking_application/category/category_screen.dart';
import 'package:booking_application/details.dart';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/modal/registration_model.dart';
import 'package:booking_application/provider/all_turf_provider.dart';
import 'package:booking_application/provider/category_provider.dart';
import 'package:booking_application/provider/tournament_provider.dart';
import 'package:booking_application/views/details_screen.dart';
import 'package:booking_application/views/profile/notification_screen.dart';
import 'package:booking_application/views/profile/profile_screen.dart';
import 'package:booking_application/views/profile/slider_bar_screen.dart';
import 'package:booking_application/views/tournament_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrollScreen extends StatefulWidget {
  final int? initialTabIndex; // Add this parameter

  const EnrollScreen({super.key, this.initialTabIndex});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Add TabController

  final List<Map<String, String>> schedules = [
    {
      'title': 'Cricket Match',
      'teams': 'Team A vs Team B',
      'date': 'June 28, 2025',
      'time': '10:00 AM',
      'venue': 'Cricket Complex, Kakkanad',
      'status': 'Scheduled'
    },
    {
      'title': 'Football Match',
      'teams': 'FC Lions vs FC Tigers',
      'date': 'June 29, 2025',
      'time': '03:00 PM',
      'venue': 'Football Ground, Ernakulam',
      'status': 'Scheduled'
    },
    {
      'title': 'Volleyball Match',
      'teams': 'Spikers vs Blockers',
      'date': 'June 30, 2025',
      'time': '11:00 AM',
      'venue': 'Sports Complex, Kochi',
      'status': 'Scheduled'
    },
  ];

  final List<Map<String, String>> comingUp = [
    {
      'title': 'Inter-College Cricket',
      'date': 'July 05, 2025',
      'time': '09:00 AM',
      'location': 'Sports Stadium',
      'registrationDeadline': 'July 01, 2025',
      'prize': '₹50,000'
    },
    {
      'title': 'City Football League',
      'date': 'July 10, 2025',
      'time': '05:00 PM',
      'location': 'Municipal Ground',
      'registrationDeadline': 'July 05, 2025',
      'prize': '₹75,000'
    },
    {
      'title': 'Volleyball Championship',
      'date': 'July 15, 2025',
      'time': '02:00 PM',
      'location': 'Indoor Stadium',
      'registrationDeadline': 'July 10, 2025',
      'prize': '₹30,000'
    },
  ];

  final List<Map<String, String>> liveMatches = [
    {
      'title': 'Cricket Live',
      'teams': 'Eagles vs Hawks',
      'score': '145/4 vs 120/7',
      'time': 'Live',
      'overs': '35.2 / 50',
      'status': 'In Progress'
    },
    {
      'title': 'Football Live',
      'teams': 'Strikers vs Defenders',
      'score': '2 - 1',
      'time': '78 min',
      'status': 'Second Half',
      'venue': 'Main Ground'
    },
  ];

  final List<Map<String, String>> registrations = [
    {
      'title': 'Summer Cricket League',
      'startDate': 'August 01, 2025',
      'registrationFee': '₹1,500',
      'deadline': 'July 25, 2025',
      'category': 'Open',
      'maxTeams': '16',
      'description': 'Annual cricket tournament for all age groups'
    },
    {
      'title': 'Football Premier Cup',
      'startDate': 'August 15, 2025',
      'registrationFee': '₹2,000',
      'deadline': 'August 05, 2025',
      'category': 'Under 25',
      'maxTeams': '12',
      'description': 'Premier football competition for young talents'
    },
    {
      'title': 'Volleyball Masters',
      'startDate': 'September 01, 2025',
      'registrationFee': '₹1,200',
      'deadline': 'August 20, 2025',
      'category': 'Mixed',
      'maxTeams': '8',
      'description': 'Professional volleyball tournament'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize TabController with the initial tab index (default to 0 for Venue)
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex:
          widget.initialTabIndex ?? 0, // Use provided index or default to 0
    );

    Provider.of<AllTurfProvider>(context, listen: false).loadTurfs();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    Provider.of<TournamentProvider>(context, listen: false).loadTournaments();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.push(context, MaterialPageRoute(builder: (context)=>const  ProfileScreen()));
              //           },
              //           child:const CircleAvatar(
              //             backgroundImage: NetworkImage(
              //               'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
              //             ),
              //           ),
              //         ),
              //       const  SizedBox(width: 10),
              //       const  Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text('Hello',
              //                 style: TextStyle(
              //                     fontSize: 14, color: Colors.black54)),

              //             // Text('PMS',
              //             //     style: TextStyle(
              //             //         fontWeight: FontWeight.bold, fontSize: 16)),
              //           ],
              //         ),
              //       ],
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const  NotificationScreen()));
              //       },
              //       child:const Icon(Icons.notifications_none)),
              //   ],
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SliderBarScreen()),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FutureBuilder<User?>(
                        future: UserPreferences.getUser(),
                        builder: (context, snapshot) {
                          String username = 'Hello';
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data != null) {
                            username = snapshot.data!.name;
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hello',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                username,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                    child: const Icon(Icons.notifications_none),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Select Game',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  const Text('See All',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  //  const   Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoryScreen()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ))
                ],
              ),
              const SizedBox(height: 12),
              Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const SizedBox(
                      height: 90,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (provider.errorMessage.isNotEmpty) {
                    return SizedBox(
                      height: 90,
                      child: Center(
                        child: Text(
                          provider.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  final sports = provider.categories;

                  return SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sports.length,
                      itemBuilder: (context, index) {
                        final sport = sports[index];
                        final imageUrl =
                            provider.getFullImageUrl(sport.imageUrl);

                        return Padding(
                          padding: const EdgeInsets.only(right: 36),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('item selected ${sport.name}');
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 25,
                                  child: ClipOval(
                                    child: Image.network(
                                      imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 30,
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                sport.name,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200],
                ),
                child: TabBar(
                  controller: _tabController, // Use the custom TabController
                  isScrollable: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontSize: 12),
                  tabs: const [
                    Tab(text: 'Venue'),
                    Tab(text: 'Tournament'),
                    Tab(text: 'Schedule'),
                    Tab(text: 'Coming Up'),
                    Tab(text: 'Live Matches'),
                    Tab(text: 'Register'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController, // Use the custom TabController
                  children: [
                    Consumer<AllTurfProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (provider.hasError) {
                          return const Center(
                              child: Text('Failed to load turfs'));
                        }

                        final venues = provider.turfs;

                        return ListView.builder(
                          itemCount: venues.length,
                          itemBuilder: (context, index) {
                            final venue = venues[index];
                            final imageUrl =
                                'http://31.97.206.144:3081${venue.imageUrls.first}';

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      imageUrl,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          venue.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          venue.location,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          venue.openingTime,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹ ${venue.pricePerHour}/hr',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsScreen(
                                                      turfId: venue.id,
                                                      image: venue.images
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: const Text(
                                                'Book Now',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Consumer<TournamentProvider>(
                      builder: (context, provider, _) {
                        if (provider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (provider.error != null) {
                          return Center(
                            child: Text('Error: ${provider.error}'),
                          );
                        } else {
                          final tournaments = provider.tournaments;

                          return ListView.builder(
                            itemCount: tournaments.length,
                            itemBuilder: (context, index) {
                              final tournament = tournaments[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        'http://31.97.206.144:3081${tournament.image ?? ''}',
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 150,
                                            width: double.infinity,
                                            color: Colors.grey[300],
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.broken_image,
                                              size: 40,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tournament.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          if (tournament.description !=
                                              null) ...[
                                            const SizedBox(height: 4),
                                          ],
                                          Text(
                                            tournament.location != null
                                                ? 'Location: ${tournament.location}'
                                                : 'Location: Not provided',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          if (tournament.details?.date !=
                                              null) ...[
                                            Text(
                                              'Date: ${tournament.details!.date}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                          if (tournament.details?.time !=
                                              null) ...[
                                            Text(
                                              'Time: ${tournament.details!.time}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹${tournament.price}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EnrollDetails()));

                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         TournamentDetailsScreen(
                                                  //       tournamentId:
                                                  //           tournament.id,
                                                  //       imageUrl:
                                                  //           tournament.image,
                                                  //       price: tournament
                                                  //           .price
                                                  //           .toString(),
                                                  //       date: tournament
                                                  //               .details
                                                  //               ?.date ??
                                                  //           '',
                                                  //       time: tournament
                                                  //               .details
                                                  //               ?.time ??
                                                  //           '',
                                                  //           slot: tournament.details?.slots.toString(),
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Enroll Now',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    // Schedule Tab
                    ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];
                        return GestureDetector(
                          onTap: () {
                            print('selected name ${schedule['title']}');
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        schedule['title']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          schedule['status']!,
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    schedule['teams']!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        schedule['date']!,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.access_time,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        schedule['time']!,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 14, color: Colors.blue),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          schedule['venue']!,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Coming Up Tab
                    ListView.builder(
                      itemCount: comingUp.length,
                      itemBuilder: (context, index) {
                        final event = comingUp[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        event['title']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Upcoming',
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      event['date']!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.access_time,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      event['time']!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        size: 14, color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Text(
                                      event['location']!,
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Prize: ${event['prize']}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          'Deadline: ${event['registrationDeadline']}',
                                          style: const TextStyle(
                                              fontSize: 11, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        print(
                                            'selected coming up: ${event['title']}');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text(
                                        'Notify Me',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Live Matches Tab
                    ListView.builder(
                      itemCount: liveMatches.length,
                      itemBuilder: (context, index) {
                        final match = liveMatches[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      match['title']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'LIVE',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  match['teams']!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Score: ${match['score']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                const SizedBox(height: 4),
                                if (match['overs'] != null)
                                  Text(
                                    'Overs: ${match['overs']}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                Text(
                                  '${match['status']} - ${match['time']}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    // Add navigation to live match details
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Watch Live',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Register Tab
                    // Register Tab - Continuation from where it was cut off
                    ListView.builder(
                      itemCount: registrations.length,
                      itemBuilder: (context, index) {
                        final registration = registrations[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        registration['title']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        registration['category']!,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  registration['description']!,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Starts: ${registration['startDate']}',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.group,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Max Teams: ${registration['maxTeams']}',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fee: ${registration['registrationFee']}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Deadline: ${registration['deadline']}',
                                          style: const TextStyle(
                                              fontSize: 11, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add registration action
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Registering for ${registration['title']}'),
                                            backgroundColor: Colors.blue,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text(
                                        'Register Now',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
