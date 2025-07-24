// import 'package:booking_application/views/details_screen.dart';
// import 'package:booking_application/views/tournament_details_screen.dart';
// import 'package:flutter/material.dart';

// class EnrollScreen extends StatelessWidget {
//   EnrollScreen({super.key});

//   final List<Map<String, dynamic>> sports = [
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/previews/029/709/704/non_2x/cartoon-illustration-cricket-bat-and-balls-sport-icon-isolated-on-white-background-vector.jpg',
//       'label': 'Cricket'
//     },
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/previews/021/821/069/non_2x/football-ball-cartoon-soccer-ball-isolated-on-yellow-background-illustration-free-vector.jpg',
//       'label': 'Football'
//     },
//     {
//       'image':
//           'https://media.istockphoto.com/id/181294594/vector/hockey-sticks-puck.jpg?s=612x612&w=0&k=20&c=E0O-RJX6Af1zPaAEfnKAP6LWMQKGOVfOSBp256YOTKU=',
//       'label': 'Hockey'
//     },
//     {
//       'image':
//           'https://atlas-content-cdn.pixelsquid.com/stock-images/cartoon-volleyball-ball-XorJXL9-600.jpg',
//       'label': 'Volleyball'
//     },
//   ];

//   final List<Map<String, String>> venues = [
//     {
//       'title': 'Cricket Complex',
//       'location': 'Kakkanad',
//       'time': '09 AM - 12 PM open',
//       'price': '₹500/hr',
//       'image':
//           'https://nwscdn.com/media/catalog/product/cache/h900xw900/a/r/artificial-match-wicket-_1__3.jpg',
//     },
//     {
//       'title': 'Football Complex',
//       'location': 'Kakkanad',
//       'time': '09 AM - 12 PM open',
//       'price': '₹500/hr',
//       'image':
//           'https://5.imimg.com/data5/SELLER/Default/2023/10/350327019/NU/WB/TZ/38215148/7-a-side-football-turf.jpg',
//     },
//     {
//       'title': 'Cricket Complex',
//       'location': 'Kakkanad',
//       'time': '09 AM - 12 PM open',
//       'price': '₹500/hr',
//       'image':
//           'https://nwscdn.com/media/catalog/product/cache/h900xw900/a/r/artificial-match-wicket-_1__3.jpg',
//     },
//   ];

//   final List<Map<String, String>> venuess = [
//     {
//       'title': 'Cricket Tournament',
//       'location': 'Kakkanad',
//       'time': '09 AM - 12 PM open',
//       'price': '₹500/hr',
//       'image':
//           'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
//     },
//     {
//       'title': 'Cricket Tournament',
//       'location': 'Kakkanad',
//       'time': '09 AM - 12 PM open',
//       'price': '₹500/hr',
//       'image':
//           'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
//     },
//     {
//       'title': 'Cricket Tournament',
//       'location': 'Kakkanad',
//       'time': '09 AM - 12 PM open',
//       'price': '₹500/hr',
//       'image':
//           'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 12),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Hello',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.black54)),
//                             Text('PMS',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Icon(Icons.notifications_none),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     prefixIcon: const Icon(Icons.search),
//                     suffixIcon: const Icon(Icons.tune),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     fillColor: Colors.grey[200],
//                     filled: true,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Select Game',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     const SizedBox(
//                       width: 130,
//                     ),
//                     const Text('See All',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold)),
//                     IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.arrow_forward_ios,
//                           size: 18,
//                         ))
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 SizedBox(
//                   height: 90,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: sports.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 48),
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors.grey[200],
//                               radius: 25,
//                               child: ClipOval(
//                                 child: Image.network(
//                                   sports[index]['image'],
//                                   width: 50,
//                                   height: 50,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(
//                                       Icons.error,
//                                       color: Colors.red,
//                                       size: 30,
//                                     );
//                                   },
//                                   loadingBuilder:
//                                       (context, child, loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               sports[index]['label'],
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.grey[200],
//                   ),
//                   child: const TabBar(
//                     labelColor: Colors.blue,
//                     unselectedLabelColor: Colors.black,
//                     // indicator: BoxDecoration(
//                     //   color: Colors.blue,
//                     //   borderRadius: BorderRadius.circular(30),
//                     // ),
//                     tabs: [
//                       Tab(text: 'Venue'),
//                       Tab(text: 'Tournament'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       ListView.builder(
//                         itemCount: venues.length,
//                         itemBuilder: (context, index) {
//                           final venue = venues[index];
//                           return Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                       top: Radius.circular(12)),
//                                   child: Image.network(
//                                     venue['image']!,
//                                     height: 150,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         venue['title']!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         venue['location']!,
//                                         style: const TextStyle(
//                                             color: Colors.blue, fontSize: 14),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         venue['time']!,
//                                         style: const TextStyle(
//                                             color: Colors.blue, fontSize: 14),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             venue['price']!,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16),
//                                           ),
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.blue,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               'Book Now',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       ListView.builder(
//                         itemCount: venuess.length,
//                         itemBuilder: (context, index) {
//                           final venue = venuess[index];
//                           return Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                       top: Radius.circular(12)),
//                                   child: Image.network(
//                                     venue['image']!,
//                                     height: 150,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         venue['title']!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         venue['location']!,
//                                         style: const TextStyle(
//                                             color: Colors.blue, fontSize: 14),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         venue['time']!,
//                                         style: const TextStyle(
//                                             color: Colors.blue, fontSize: 14),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             venue['price']!,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16),
//                                           ),
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           TournamentDetailsScreen()));
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.blue,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               'Enroll Now',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       // const Center(child: Text("Tournament Tab Coming Soon")),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








import 'package:booking_application/views/details_screen.dart';
import 'package:booking_application/views/tournament_details_screen.dart';
import 'package:flutter/material.dart';

class EnrollScreen extends StatelessWidget {
  EnrollScreen({super.key});

  final List<Map<String, dynamic>> sports = [
    {
      'image':
          'https://static.vecteezy.com/system/resources/previews/029/709/704/non_2x/cartoon-illustration-cricket-bat-and-balls-sport-icon-isolated-on-white-background-vector.jpg',
      'label': 'Cricket'
    },
    {
      'image':
          'https://static.vecteezy.com/system/resources/previews/021/821/069/non_2x/football-ball-cartoon-soccer-ball-isolated-on-yellow-background-illustration-free-vector.jpg',
      'label': 'Football'
    },
    {
      'image':
          'https://media.istockphoto.com/id/181294594/vector/hockey-sticks-puck.jpg?s=612x612&w=0&k=20&c=E0O-RJX6Af1zPaAEfnKAP6LWMQKGOVfOSBp256YOTKU=',
      'label': 'Hockey'
    },
    {
      'image':
          'https://atlas-content-cdn.pixelsquid.com/stock-images/cartoon-volleyball-ball-XorJXL9-600.jpg',
      'label': 'Volleyball'
    },
  ];

  final List<Map<String, String>> venues = [
    {
      'title': 'Cricket Complex',
      'location': 'Kakkanad',
      'time': '09 AM - 12 PM open',
      'price': '₹500/hr',
      'image':
          'https://nwscdn.com/media/catalog/product/cache/h900xw900/a/r/artificial-match-wicket-_1__3.jpg',
    },
    {
      'title': 'Football Complex',
      'location': 'Kakkanad',
      'time': '09 AM - 12 PM open',
      'price': '₹500/hr',
      'image':
          'https://5.imimg.com/data5/SELLER/Default/2023/10/350327019/NU/WB/TZ/38215148/7-a-side-football-turf.jpg',
    },
    {
      'title': 'Cricket Complex',
      'location': 'Kakkanad',
      'time': '09 AM - 12 PM open',
      'price': '₹500/hr',
      'image':
          'https://nwscdn.com/media/catalog/product/cache/h900xw900/a/r/artificial-match-wicket-_1__3.jpg',
    },
  ];

  final List<Map<String, String>> tournaments = [
    {
      'title': 'Cricket Tournament',
      'location': 'Kakkanad',
      'time': '09 AM - 12 PM open',
      'price': '₹500/hr',
      'image':
          'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
    },
    {
      'title': 'Football Championship',
      'location': 'Ernakulam',
      'time': '10 AM - 01 PM',
      'price': '₹750/team',
      'image':
          'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
    },
    {
      'title': 'Volleyball League',
      'location': 'Kochi',
      'time': '02 PM - 05 PM',
      'price': '₹600/team',
      'image':
          'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
    },
  ];

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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Updated to 6 tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54)),
                            Text('PMS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.notifications_none),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 130),
                    const Text('See All',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ))
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sports.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 48),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 25,
                              child: ClipOval(
                                child: Image.network(
                                  sports[index]['image'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 30,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              sports[index]['label'],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: const TabBar(
                    isScrollable: true, // Make tabs scrollable
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(fontSize: 12),
                    tabs: [
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
                    children: [
                      // Venue Tab
                      ListView.builder(
                        itemCount: venues.length,
                        itemBuilder: (context, index) {
                          final venue = venues[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    venue['image']!,
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
                                        venue['title']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        venue['location']!,
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        venue['time']!,
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            venue['price']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsScreen()));
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
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Tournament Tab
                      ListView.builder(
                        itemCount: tournaments.length,
                        itemBuilder: (context, index) {
                          final tournament = tournaments[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    tournament['image']!,
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
                                        tournament['title']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        tournament['location']!,
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        tournament['time']!,
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            tournament['price']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TournamentDetailsScreen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: const Text(
                                              'Enroll Now',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Schedule Tab
                      ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Upcoming',
                                          style: const TextStyle(
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
                                                fontSize: 11,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add navigation or action
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
                                          style:
                                              TextStyle(color: Colors.white),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                                fontSize: 11,
                                                color: Colors.red),
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
                                          style:
                                              TextStyle(color: Colors.white),
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
      ),
    );
  }
}