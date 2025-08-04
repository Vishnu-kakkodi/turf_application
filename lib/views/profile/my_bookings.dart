import 'package:booking_application/views/details_screen.dart';
import 'package:booking_application/views/tournament_details_screen.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  final String?id;
  const MyBookings({super.key,this.id});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title: const Text(
            'My Bookings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          bottom:const PreferredSize(
            preferredSize:  Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              // indicator: BoxDecoration(
              //   color: Colors.blue,
              //   borderRadius: BorderRadius.circular(1),
              // ),
              tabs:  [
                Tab(text: 'Venue'),
                Tab(text: 'Tournament'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [VenueList(), TournamentList()],
        ),
      ),
    );
  }
}

class VenueList extends StatelessWidget {
  final List<Map<String, String>> venueData = const [
    {
      'title': 'Cricket Complex',
      'location': 'Kakinada',
      'time': '09 AM - 12 PM open',
      'price': '₹500/hr',
      'image':
          'https://i.pinimg.com/736x/1f/c2/6e/1fc26ef23ce91121d01e2281512e896b.jpg',
      'size': '295 feet x 148 feet'
    },
   
  ];

  VenueList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: venueData.length,
      itemBuilder: (context, index) {
        final venue = venueData[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      venue['image']!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        venue['size']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue['title']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(venue['location']!),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(venue['time']!),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          venue['price']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class TournamentList extends StatefulWidget {
  final String?id;
  const TournamentList({super.key,this.id});

  @override
  State<TournamentList> createState() => _TournamentListState();
}

class _TournamentListState extends State<TournamentList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      'https://www.livemint.com/lm-img/img/2023/10/13/600x338/Cricket_1696767612753_1697173162336.JPG',
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Positioned(
                  //   top: 8,
                  //   left: 8,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 10, vertical: 4),
                  //     decoration: BoxDecoration(
                  //       color: Colors.red,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     // child: const Text(
                  //     //   'Completed',
                  //     //   style: TextStyle(
                  //     //     color: Colors.white,
                  //     //     fontSize: 12,
                  //     //     fontWeight: FontWeight.bold,
                  //     //   ),
                  //     // ),
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cricket Tournament',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children:  [
                        Icon(Icons.location_on, size: 16, color: Colors.blue),
                        SizedBox(width: 4),
                        Text('Kakinada'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.blue),
                        SizedBox(width: 4),
                        Text('09 AM - 12 PM'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '₹500',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        OutlinedButton(
                          onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>TournamentDetailsScreen(tournamentId:widget.id.toString(),)));
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'View Details',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
