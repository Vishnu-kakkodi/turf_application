// import 'package:booking_application/views/player_details_screen.dart';
// import 'package:flutter/material.dart';

// class TournamentDetailsScreen extends StatelessWidget {
//   const TournamentDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // Header with background image
//           Stack(
//             children: [
//               Container(
//                 height: 280,
//                 width: double.infinity,

//                 child: Image.network('https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',fit: BoxFit.cover,)
//               ),
//               // Back button
//               Positioned(
//                 top: 50,
//                 left: 16,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           ),

//           // Content section
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title and Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Cricket Tournament',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       Text(
//                         '₹500',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 19,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 8),

//                   // Organization
//                   Text(
//                     'All India Cricket Association',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                   ),

//                   SizedBox(height: 24),

//                   // Description Section
//                   Text(
//                     'Description',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),

//                   SizedBox(height: 12),

//                   Text(
//                     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 14,
//                       height: 1.5,
//                     ),
//                   ),

//                   SizedBox(height: 24),

//                   // Details Section
//                   Text(
//                     'Details',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),

//                   SizedBox(height: 16),

//                   // Details Grid
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Date',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               '24-06-25',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Time',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               '09 AM - 12 PM',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Age',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'Age 18-24',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 24),

//                   // Location Section
//                   Text(
//                     'Location',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),

//                   SizedBox(height: 12),

//                   Container(
//                     height: 56,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           'Kakinda, Town Ground, T-89-1, Near \nHospital',
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),

//           // Continue Button
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerDetailsScreen()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 child: Text(
//                   'Continue',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:booking_application/provider/single_tournament_provider.dart';
// import 'package:booking_application/views/player_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TournamentDetailsScreen extends StatefulWidget {
//   final String tournamentId;
//   final String?name;
//   final String?price;
//   final String?imageUrl;
//   const TournamentDetailsScreen({
//     super.key,
//     required this.tournamentId,
//     this.name,
//     this.price,
//     this.imageUrl
//   });

//   @override
//   State<TournamentDetailsScreen> createState() => _TournamentDetailsScreenState();
// }

// class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch tournament data when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<SingleTournamentProvider>().fetchTournament(widget.tournamentId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<SingleTournamentProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (provider.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline,
//                     size: 64,
//                     color: Colors.red[300],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error loading tournament',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     provider.errorMessage ?? 'Unknown error occurred',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       provider.fetchTournament(widget.tournamentId);
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           final tournament = provider.tournament;
//           if (tournament == null) {
//             return const Center(
//               child: Text('No tournament data available'),
//             );
//           }

//           return Column(
//             children: [
//               // Header with background image
//               Stack(
//                 children: [
//                   Container(
//                     height: 280,
//                     width: double.infinity,
//                     child: tournament.imageUrl != null
//                         ? Image.network(
//                             tournament.imageUrl!,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Image.network(
//                                 'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                           )
//                         : Image.network(
//                             'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                   // Back button
//                   Positioned(
//                     top: 50,
//                     left: 16,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),

//               // Content section
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Price
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               tournament.name,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '₹${tournament.price}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 19,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 8),

//                       // // Organization
//                       // Text(
//                       //   tournament.organization ?? 'All India Cricket Association',
//                       //   style: TextStyle(
//                       //     color: Colors.grey[600],
//                       //     fontSize: 14,
//                       //   ),
//                       // ),

//                       const SizedBox(height: 24),

//                       // Description Section
//                       const Text(
//                         'Description',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       Text(
//                         tournament.description ??
//                         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 14,
//                           height: 1.5,
//                         ),
//                       ),

//                       const SizedBox(height: 24),

//                       // Details Section
//                       const Text(
//                         'Details',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       // Details Grid
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Date',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   tournament.details?.date ?? '24-06-25',
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Time',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   tournament.details?.time ?? '09 AM - 12 PM',
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Age',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 // Text(
//                                 //   tournament.age ?? 'Age 18-24',
//                                 //   style: const TextStyle(
//                                 //     color: Colors.black87,
//                                 //     fontSize: 14,
//                                 //     fontWeight: FontWeight.w500,
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 24),

//                       // Location Section
//                       const Text(
//                         'Location',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               color: Colors.blue,
//                               size: 20,
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 tournament.location ?? 'Kakinda, Town Ground, T-89-1, Near Hospital',
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),

//               // Continue Button
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const PlayerDetailsScreen(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     child: const Text(
//                       'Continue',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clear provider data when leaving the screen
//     context.read<SingleTournamentProvider>().clearData();
//     super.dispose();
//   }
// }

import 'package:booking_application/views/player_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tournament_provider.dart'; // Update path as needed

class TournamentDetailsScreen extends StatefulWidget {
  final String tournamentId;
  final String? name;
  final String? price;
  final String? imageUrl;
  final String?time;
  final String?date;

  const TournamentDetailsScreen({
    super.key,
    required this.tournamentId,
    this.name,
    this.price,
    this.imageUrl,
    this.time,
    this.date,
  });

  @override
  State<TournamentDetailsScreen> createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tournament data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TournamentProvider>()
          .loadSingleTournament(widget.tournamentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TournamentProvider>(
        builder: (context, provider, child) {
          if (provider.isSingleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.hasSingleError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading tournament',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.singleError ?? 'Unknown error occurred',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      provider.retrySingleTournament(widget.tournamentId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final tournament = provider.singleTournament;
          if (tournament == null) {
            return const Center(
              child: Text('No tournament data available'),
            );
          }

          return Column(
            children: [
              // Header with background image
              Stack(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    child:
                        tournament.image != null && tournament.image!.isNotEmpty
                            ? Image.network(
                                tournament.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.network(
                                widget.imageUrl ??
                                    'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',
                                fit: BoxFit.cover,
                              ),
                  ),
                  // Back button
                  Positioned(
                    top: 50,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),

              // Content section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tournament.name ??
                                  widget.name ??
                                  'Cricket Tournament',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            '₹${tournament.price ?? widget.price ?? '500'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Organization (if available in your tournament model)
                      // Text(
                      //   tournament.organization ?? 'All India Cricket Association',
                      //   style: TextStyle(
                      //     color: Colors.grey[600],
                      //     fontSize: 14,
                      //   ),
                      // ),

                      const SizedBox(height: 24),

                      // Description Section
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        tournament.description ??
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Details Section
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Details Grid
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tournament.details?.date ?? '24-06-25',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tournament.details?.time ?? '09 AM - 12 PM',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   'Age',
                                //   style: TextStyle(
                                //     color: Colors.grey[600],
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                const SizedBox(height: 4),
                                // Text(
                                //   tournament.ageGroup ?? 'Age 18-24',
                                //   style: const TextStyle(
                                //     color: Colors.black87,
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Location Section
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                tournament.location ??
                                    'Kakinda, Town Ground, T-89-1, Near Hospital',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Continue Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayerDetailsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clear single tournament data when leaving the screen
    context.read<TournamentProvider>().clearSingleTournament();
    super.dispose();
  }
}
