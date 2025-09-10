// import 'package:booking_application/History/history_screen.dart';
// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/views/player_details_screen.dart';
// import 'package:booking_application/views/profile/booking_history.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/tournament_provider.dart';
// import '../provider/book_tournament_provider.dart'; // Add this import

// class TournamentDetailsScreen extends StatefulWidget {
//   final String tournamentId;
//   final String? name;
//   final String? price;
//   final String? imageUrl;
//   final String? time;
//   final String? date;
//   final String?slot;

//   const TournamentDetailsScreen({
//     super.key,
//     required this.tournamentId,
//     this.name,
//     this.price,
//     this.imageUrl,
//     this.time,
//     this.date,
//     this.slot
//   });

//   @override
//   State<TournamentDetailsScreen> createState() =>
//       _TournamentDetailsScreenState();
// }

// class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
//   String? selectedSlotId;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch tournament data when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context
//           .read<TournamentProvider>()
//           .loadSingleTournament(widget.tournamentId);
//     });
//   }

//   // Helper method to find selected slot details
//   dynamic getSelectedSlot(tournament) {
//     if (selectedSlotId == null || tournament.details?.slots == null) return null;

//     try {
//       return tournament.details!.slots.firstWhere(
//         (slot) => slot.id == selectedSlotId,
//       );
//     } catch (e) {
//       return null;
//     }
//   }
// Future<void> _handleBooking(BuildContext context, tournament) async {
//   final bookProvider = context.read<BookTournamentProvider>();
//   final selectedSlot = getSelectedSlot(tournament);

//   if (selectedSlot == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Please select a time slot to continue'),
//         backgroundColor: Colors.orange,
//       ),
//     );
//     return;
//   }

//   // Clear any previous errors
//   bookProvider.clearError();

//   // Get the date from tournament details or widget
//   String originalDate = tournament.details?.date ?? widget.date ?? '';

//   if (originalDate.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Tournament date is missing'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return;
//   }

//   // Format date for API
//   String formattedDate = bookProvider.formatDateForApi(originalDate);

//   // Validate formatted date
//   if (formattedDate.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Invalid date format'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return;
//   }

//   // Validate tournament ID
//   if (widget.tournamentId.trim().isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Tournament ID is missing'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return;
//   }

//   // Validate selected slot
//   if (selectedSlot.timeSlot == null || selectedSlot.timeSlot!.trim().isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Selected time slot is invalid'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return;
//   }

//   try {
//     final success = await bookProvider.bookTournamentSlot(
//       tournamentId: widget.tournamentId.trim(),
//       date: formattedDate.trim(),
//       timeSlot: selectedSlot.timeSlot!.trim(),
//     );

//     if (success) {
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Tournament slot booked successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Get user data - AWAIT the Future
//       final user = await UserPreferences.getUser();

//       if (user != null && user.id != null) {
//         // Navigate to booking history screen with user ID
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookingHistory(id: user.id!,date: formattedDate,timeSlot: selectedSlotId,tournamentId: widget.tournamentId,),
//           ),
//         );
//       } else {
//         // Handle case where user data is not available
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Booking successful! User data not available.'),
//             backgroundColor: Colors.orange,
//           ),
//         );
//         Navigator.pop(context); // Go back instead
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(bookProvider.errorMessage ?? 'Booking failed'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   } catch (e) {
//     print('=== BOOKING EXCEPTION ===');
//     print('Exception: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('An error occurred: ${e.toString()}'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     print('imaaaaaaaaaaaaaaaaaaaaaaaaageeeeeeeeeeeeeeeee${widget.imageUrl}');
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer2<TournamentProvider, BookTournamentProvider>( // Changed to Consumer2
//         builder: (context, tournamentProvider, bookProvider, child) {
//           if (tournamentProvider.isSingleLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (tournamentProvider.hasSingleError) {
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
//                     tournamentProvider.singleError ?? 'Unknown error occurred',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       tournamentProvider.retrySingleTournament(widget.tournamentId);
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           final tournament = tournamentProvider.singleTournament;
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
//                     child: Builder(
//                       builder: (context) {
//                         const String baseUrl = 'http://31.97.206.144:3081';

//                         // Determine which image URL to use
//                         String? imageUrl;

//                         // Priority: tournament.image > widget.imageUrl > default fallback
//                         if (tournament.image != null &&
//                             tournament.image!.isNotEmpty) {
//                           // Check if the image URL already contains http/https or if it's a relative path
//                           if (tournament.image!.startsWith('http://') ||
//                               tournament.image!.startsWith('https://')) {
//                             imageUrl = tournament.image!;
//                           } else {
//                             // It's a relative path, prepend the base URL
//                             imageUrl = '$baseUrl${tournament.image!}';
//                           }
//                         } else if (widget.imageUrl != null &&
//                             widget.imageUrl!.isNotEmpty) {
//                           // Same check for widget.imageUrl
//                           if (widget.imageUrl!.startsWith('http://') ||
//                               widget.imageUrl!.startsWith('https://')) {
//                             imageUrl = widget.imageUrl!;
//                           } else {
//                             imageUrl = '$baseUrl${widget.imageUrl!}';
//                           }
//                         } else {
//                           imageUrl =
//                               'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg';
//                         }

//                         print('Loading image URL: $imageUrl'); // Debug print

//                         return Image.network(
//                           imageUrl,
//                           fit: BoxFit.cover,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 value: loadingProgress.expectedTotalBytes !=
//                                         null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                     : null,
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             print('Image loading error: $error'); // Debug print
//                             return Image.network(
//                               'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 // If even the fallback fails, show a placeholder
//                                 return Container(
//                                   color: Colors.grey[300],
//                                   child: const Center(
//                                     child: Icon(
//                                       Icons.image_not_supported,
//                                       size: 64,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   // Back button
//                   Positioned(
//                     top: 50,
//                     left: 16,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back,
//                           color: Colors.white, size: 28),
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
//                               tournament.name ??
//                                   widget.name ??
//                                   'Cricket Tournament',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '₹${tournament.price ?? widget.price ?? '500'}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 19,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 8),

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
//                             'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
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
//                                   'Age Group',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   tournament.details?.allowedAge ?? '18-24',
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 24),
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
//                                 tournament.location ??
//                                     'Kakinda, Town Ground, T-89-1, Near Hospital',
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
//                     onPressed: bookProvider.isLoading ? null : () async {
//                       await _handleBooking(context, tournament);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: bookProvider.isLoading ? Colors.grey : Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     child: bookProvider.isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : Text(
//                             selectedSlotId != null
//                                 ? 'Book Selected Slot'
//                                 : 'Continue',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSlotStatusIndicator({
//     required Color color,
//     required Color borderColor,
//     required String label,
//     required IconData icon,
//   }) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 16,
//           height: 16,
//           decoration: BoxDecoration(
//             color: color,
//             border: Border.all(color: borderColor),
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Icon(
//             icon,
//             size: 10,
//             color: borderColor == Colors.grey[400] ? Colors.grey[600] : borderColor,
//           ),
//         ),
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[700],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     // Clear single tournament data when leaving the screen
//     context.read<TournamentProvider>().clearSingleTournament();
//     // Clear booking provider data
//     context.read<BookTournamentProvider>().clearBookingResponse();
//     context.read<BookTournamentProvider>().clearError();
//     super.dispose();
//   }
// }



import 'package:booking_application/History/history_screen.dart';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/views/player_details_screen.dart';
import 'package:booking_application/views/profile/booking_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tournament_provider.dart';
import '../provider/book_tournament_provider.dart';

class TournamentDetailsScreen extends StatefulWidget {
  final String tournamentId;
  final String? name;
  final String? price;
  final String? imageUrl;
  final String? time;
  final String? date;
  final String? slot;

  const TournamentDetailsScreen(
      {super.key,
      required this.tournamentId,
      this.name,
      this.price,
      this.imageUrl,
      this.time,
      this.date,
      this.slot});

  @override
  State<TournamentDetailsScreen> createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  String? selectedSlotId;
  DateTime? selectedDate; // Add this for date selection

  @override
  void initState() {
    super.initState();
    // Initialize with tournament date if available, but ensure it's not in the past
    if (widget.date != null && widget.date!.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(widget.date!);
        // Only use the parsed date if it's today or in the future
        if (parsedDate
            .isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
          selectedDate = parsedDate;
        } else {
          selectedDate = null; // Don't pre-select past dates
        }
      } catch (e) {
        selectedDate = null; // Don't pre-select if parsing fails
      }
    } else {
      selectedDate = null; // Don't pre-select if no date provided
    }

    // Fetch tournament data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TournamentProvider>()
          .loadSingleTournament(widget.tournamentId);
    });
  }

  // Helper method to find selected slot details
  dynamic getSelectedSlot(tournament) {
    if (selectedSlotId == null || tournament.details?.slots == null)
      return null;

    try {
      return tournament.details!.slots.firstWhere(
        (slot) => slot.id == selectedSlotId,
      );
    } catch (e) {
      return null;
    }
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now, // Use current date if no date selected
      firstDate: now,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Format date for display
  String _formatDateForDisplay(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _handleBooking(BuildContext context, tournament) async {
    final bookProvider = context.read<BookTournamentProvider>();

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date to continue'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Clear any previous errors
    bookProvider.clearError();

    // Format selected date for API
    String formattedDate =
        bookProvider.formatDateForApi(selectedDate.toString());

    // Validate formatted date
    if (formattedDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid date format'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate tournament ID
    if (widget.tournamentId.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tournament ID is missing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final success = await bookProvider.bookTournamentSlot(
        tournamentId: widget.tournamentId.trim(),
        date: formattedDate.trim(),
        timeSlot: selectedSlotId ?? "default_slot",
      );

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament slot booked successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Get user data
        final user = await UserPreferences.getUser();

        if (user != null && user.id != null) {
          // Navigate to booking history screen with user ID
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingHistory(
                id: user.id!,
                date: formattedDate,
                timeSlot: selectedSlotId,
                tournamentId: widget.tournamentId,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking successful! User data not available.'),
              backgroundColor: Colors.orange,
            ),
          );
          Navigator.pop(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(bookProvider.errorMessage ?? 'Booking failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('=== BOOKING EXCEPTION ===');
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer2<TournamentProvider, BookTournamentProvider>(
        builder: (context, tournamentProvider, bookProvider, child) {
          if (tournamentProvider.isSingleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (tournamentProvider.hasSingleError) {
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
                    tournamentProvider.singleError ?? 'Unknown error occurred',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      tournamentProvider
                          .retrySingleTournament(widget.tournamentId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final tournament = tournamentProvider.singleTournament;
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
                    child: Builder(
                      builder: (context) {
                        const String baseUrl = 'http://31.97.206.144:3081';

                        String? imageUrl;

                        if (tournament.image != null &&
                            tournament.image!.isNotEmpty) {
                          if (tournament.image!.startsWith('http://') ||
                              tournament.image!.startsWith('https://')) {
                            imageUrl = tournament.image!;
                          } else {
                            imageUrl = '$baseUrl${tournament.image!}';
                          }
                        } else if (widget.imageUrl != null &&
                            widget.imageUrl!.isNotEmpty) {
                          if (widget.imageUrl!.startsWith('http://') ||
                              widget.imageUrl!.startsWith('https://')) {
                            imageUrl = widget.imageUrl!;
                          } else {
                            imageUrl = '$baseUrl${widget.imageUrl!}';
                          }
                        } else {
                          imageUrl =
                              'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg';
                        }

                        return Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://www.shutterstock.com/image-vector/cricket-championship-concept-participating-team-600nw-2025552998.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
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

                      const SizedBox(height: 24),

                      // Date Selection Section
                      const Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.withOpacity(0.05),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  selectedDate != null
                                      ? _formatDateForDisplay(selectedDate!)
                                      : 'Select Tournament Date',
                                  style: TextStyle(
                                    color: selectedDate != null
                                        ? Colors.black87
                                        : Colors.grey[600],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),

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
                                  'Original Date',
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
                                Text(
                                  'Age Group',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tournament.details?.allowedAge ?? '18-24',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
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

                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Participants',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Entry Feee:2000',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '16 Teams/Players',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
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
                    onPressed: (bookProvider.isLoading || selectedDate == null)
                        ? null
                        : () async {
                            await _handleBooking(context, tournament);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (bookProvider.isLoading || selectedDate == null)
                              ? Colors.grey
                              : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: bookProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            selectedDate != null
                                ? 'Book for ${_formatDateForDisplay(selectedDate!)}'
                                : 'Select Date to Continue',
                            style: const TextStyle(
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
    context.read<TournamentProvider>().clearSingleTournament();
    context.read<BookTournamentProvider>().clearBookingResponse();
    context.read<BookTournamentProvider>().clearError();
    super.dispose();
  }
}
