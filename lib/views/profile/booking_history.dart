
// views/booking_history.dart
import 'package:booking_application/modal/getall_booking_model.dart' show TurfBooking, TournamentBooking;
import 'package:booking_application/payment/payment_history.dart';
import 'package:booking_application/payment/transaction_history_screen.dart';
import 'package:booking_application/provider/book_tournament_provider.dart';
import 'package:booking_application/provider/getall_booking_provider.dart';
import 'package:booking_application/provider/my_turf_booking_provider.dart';
import 'package:booking_application/provider/book_turf_provider.dart';
import 'package:booking_application/views/details_screen.dart';
import 'package:booking_application/views/tournament_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingHistory extends StatefulWidget {
  final String? id;
  final String? tournamentId;
  final String? date;
  final String? timeSlot;
  final String? turfId;
  final String? userId; // Make this required
  
  const BookingHistory({
    super.key, 
    this.id, 
    this.tournamentId, 
    this.date, 
    this.timeSlot,
    this.turfId,
     this.userId,
  });

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  void initState() {
    super.initState();
    // Fetch bookings when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final getAllBookingProvider = context.read<GetAllBookingProvider>();
      getAllBookingProvider.clearAllData();
      getAllBookingProvider.fetchAllBookings(widget.userId.toString());
      
      // Initialize other providers
      final tournamentProvider = context.read<BookTournamentProvider>();
      tournamentProvider.clearError();
      tournamentProvider.clearBookingResponse();
      
      final bookTurfProvider = context.read<BookTurfProvider>();
      bookTurfProvider.clearError();
      bookTurfProvider.clearBookingResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
          title: const Text(
            'Booking History',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Venue'),
                Tab(text: 'Tournament'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            VenueList(
              turfId: widget.id,
              date: widget.date,
              timeSlot: widget.timeSlot,
              userId: widget.userId.toString(),
            ),
            TournamentList(
              id: widget.id,
              tournamentId: widget.tournamentId,
              date: widget.date,
              timeSlot: widget.timeSlot,
              userId: widget.userId.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class VenueList extends StatelessWidget {
  final String? turfId;
  final String? date;
  final String? timeSlot;
  final String userId;
  
  const VenueList({
    super.key, 
    this.turfId, 
    this.date, 
    this.timeSlot,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetAllBookingProvider, BookTurfProvider>(
      builder: (context, getAllBookingProvider, bookTurfProvider, child) {
        // Show loading state
        if (getAllBookingProvider.isLoading || bookTurfProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show error state
        if (getAllBookingProvider.errorMessage != null || bookTurfProvider.errorMessage != null) {
          final errorMessage = getAllBookingProvider.errorMessage ?? bookTurfProvider.errorMessage!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No booked turf',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    getAllBookingProvider.clearError();
                    bookTurfProvider.clearError();
                    getAllBookingProvider.fetchTurfBookings(userId);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Show empty state
        if (getAllBookingProvider.turfBookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sports_soccer_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No venue bookings found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                if (turfId != null && date != null && timeSlot != null) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _bookTurfSlot(context, bookTurfProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Book This Turf'),
                  ),
                ],
              ],
            ),
          );
        }

        // Show venue bookings
        return RefreshIndicator(
          onRefresh: () => getAllBookingProvider.fetchTurfBookings(userId),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: getAllBookingProvider.turfBookings.length,
            itemBuilder: (context, index) {
              final booking = getAllBookingProvider.turfBookings[index];
              return TurfBookingCard(
                booking: booking,
                onCancel: (bookingId) => _showCancelDialog(context, bookingId, getAllBookingProvider),
                onReschedule: (bookingId) => _showRescheduleDialog(context, bookingId),
                onBookSlot: turfId != null && date != null && timeSlot != null 
                  ? () => _bookTurfSlot(context, bookTurfProvider)
                  : null,
              );
            },
          ),
        );
      },
    );
  }

  void _bookTurfSlot(BuildContext context, BookTurfProvider provider) async {
    if (turfId == null || date == null || timeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Missing booking details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Are you sure you want to book this turf slot?'),
              const SizedBox(height: 8),
              Text('Date: $date'),
              Text('Time: $timeSlot'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final success = await provider.bookTurfSlot(
        turfId: turfId!,
        date: provider.formatDateForApi(date!),
        timeSlot: provider.formatTimeSlotForApi(timeSlot!),
      );

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Turf booked successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh the bookings list
        context.read<GetAllBookingProvider>().fetchTurfBookings(userId);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Failed to book turf'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCancelDialog(BuildContext context, String bookingId, GetAllBookingProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Booking'),
          content: const Text('Are you sure you want to cancel this booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final success = await provider.cancelTurfBooking(bookingId);
                
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking cancelled successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(provider.errorMessage ?? 'Failed to cancel booking'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showRescheduleDialog(BuildContext context, String bookingId) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reschedule feature coming soon'),
      ),
    );
  }
}




class TurfBookingCard extends StatelessWidget {
  final TurfBooking booking;
  final Function(String) onCancel;
  final Function(String) onReschedule;
  final VoidCallback? onBookSlot;

  const TurfBookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
    required this.onReschedule,
    this.onBookSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          if (booking.images.isNotEmpty)
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> TransactionHistoryScreen(turfBooking: booking,bookingType: 'turf')));
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage('http://31.97.206.144:3081${booking.images.first}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with turf name and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        booking.turfName ?? 'Turf Booking',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        booking.status ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                    ),

                 


                  ],

                
                ),
                
                const SizedBox(height: 12),
                
                // Booking details
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      booking.date ?? 'Date not available',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      booking.timeSlot ?? 'Time not available',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        booking.turfLocation ?? 'Address not available',
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Image gallery if there are multiple images
                // if (booking.images.length > 1) ...[
                //   const Text(
                //     'More Images:',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //     ),
                //   ),
                //   const SizedBox(height: 8),
                //   SizedBox(
                //     height: 80,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: booking.images.length,
                //       itemBuilder: (context, index) {
                //         return GestureDetector(
                //           onTap: () {
                //             _showImageDialog(context, booking.images, index);
                //           },
                //           child: Container(
                //             width: 80,
                //             margin: const EdgeInsets.only(right: 8),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(8),
                //               image: DecorationImage(
                //                 image: NetworkImage(booking.images[index]),
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(turfId: booking.bookingId,)));
                        }, child: Text('View Details'))
                  ],
                )
                
                // Action buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     if (booking.status?.toLowerCase() == 'active' || 
                //         booking.status?.toLowerCase() == 'confirmed') ...[
                //       TextButton(
                //         onPressed: () => onReschedule(booking.id ?? ''),
                //         child: const Text(
                //           'Reschedule',
                //           style: TextStyle(color: Colors.orange),
                //         ),
                //       ),
                //       const SizedBox(width: 8),
                //       TextButton(
                //         onPressed: () => onCancel(booking.id ?? ''),
                //         child: const Text(
                //           'Cancel',
                //           style: TextStyle(color: Colors.red),
                //         ),
                //       ),
                //     ],
                //     if (onBookSlot != null && 
                //         (booking.status?.toLowerCase() == 'cancelled' || 
                //          booking.status?.toLowerCase() == 'expired')) ...[
                //       ElevatedButton(
                //         onPressed: onBookSlot,
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.blue,
                //           foregroundColor: Colors.white,
                //         ),
                //         child: const Text('Book Again'),
                //       ),
                //     ],
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              itemCount: images.length,
              controller: PageController(initialPage: initialIndex),
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Image.network(
                    images[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      case 'expired':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

// class TurfBookingCard extends StatelessWidget {
//   final TurfBooking booking;
//   final Function(String) onCancel;
//   final Function(String) onReschedule;
//   final VoidCallback? onBookSlot;

//   const TurfBookingCard({
//     super.key,
//     required this.booking,
//     required this.onCancel,
//     required this.onReschedule,
//     this.onBookSlot,
//   });

//  @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with turf name and status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     booking.turfName ?? 'Turf Booking',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
                
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: _getStatusColor(booking.status),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     booking.status ?? 'Unknown',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
            
//             // Booking details
//             Row(
//               children: [
//                 const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Text(
//                   booking.date ?? 'Date not available',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.access_time, size: 16, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Text(
//                   booking.timeSlot ?? 'Time not available',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     booking.turfLocation ?? 'Address not available',
//                     style: const TextStyle(color: Colors.grey),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             if (booking != null) ...[
//               const SizedBox(height: 8),
//               // Row(
//               //   children: [
//               //     const Icon(Icons.currency_rupee, size: 16, color: Colors.grey),
//               //     const SizedBox(width: 8),
//               //     Text(
//               //       '₹${booking.price}',
//               //       style: const TextStyle(
//               //         color: Colors.grey,
//               //         fontWeight: FontWeight.w500,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ],
            
//             const SizedBox(height: 16),
            
//             // Action buttons
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     if (booking.status?.toLowerCase() == 'active' || 
//             //         booking.status?.toLowerCase() == 'confirmed') ...[
//             //       TextButton(
//             //         onPressed: () => onReschedule(booking.id ?? ''),
//             //         child: const Text(
//             //           'Reschedule',
//             //           style: TextStyle(color: Colors.orange),
//             //         ),
//             //       ),
//             //       const SizedBox(width: 8),
//             //       TextButton(
//             //         onPressed: () => onCancel(booking.id ?? ''),
//             //         child: const Text(
//             //           'Cancel',
//             //           style: TextStyle(color: Colors.red),
//             //         ),
//             //       ),
//             //     ],
//             //     if (onBookSlot != null && 
//             //         (booking.status?.toLowerCase() == 'cancelled' || 
//             //          booking.status?.toLowerCase() == 'expired')) ...[
//             //       ElevatedButton(
//             //         onPressed: onBookSlot,
//             //         style: ElevatedButton.styleFrom(
//             //           backgroundColor: Colors.blue,
//             //           foregroundColor: Colors.white,
//             //         ),
//             //         child: const Text('Book Again'),
//             //       ),
//             //     ],
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'active':
//       case 'confirmed':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       case 'completed':
//         return Colors.blue;
//       case 'expired':
//         return Colors.grey;
//       default:
//         return Colors.grey;
//     }
//   }
// }

class TournamentList extends StatelessWidget {
  final String? id;
  final String? tournamentId;
  final String? date;
  final String? timeSlot;
  final String userId;
  
  const TournamentList({
    super.key, 
    this.id, 
    this.tournamentId, 
    this.date, 
    this.timeSlot,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetAllBookingProvider, BookTournamentProvider>(
      builder: (context, getAllBookingProvider, bookTournamentProvider, child) {
        // Show loading state
        if (getAllBookingProvider.isLoading || bookTournamentProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show error state
        if (getAllBookingProvider.errorMessage != null || bookTournamentProvider.errorMessage != null) {
          final errorMessage = getAllBookingProvider.errorMessage ?? bookTournamentProvider.errorMessage!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No tournament bookings',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    getAllBookingProvider.clearError();
                    bookTournamentProvider.clearError();
                    getAllBookingProvider.fetchTournamentBookings(userId);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Show empty state
        if (getAllBookingProvider.tournamentBookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No tournament bookings found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                if (tournamentId != null) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _bookTournament(context, bookTournamentProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Book This Tournament'),
                  ),
                ],
              ],
            ),
          );
        }

        // Show tournament bookings
        return RefreshIndicator(
          onRefresh: () => getAllBookingProvider.fetchTournamentBookings(userId),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: getAllBookingProvider.tournamentBookings.length,
            itemBuilder: (context, index) {
              final booking = getAllBookingProvider.tournamentBookings[index];
              return TournamentBookingCard(
                booking: booking,
                onCancel: (bookingId) => _showCancelDialog(context, bookingId, getAllBookingProvider),
                onViewDetails: (tournamentId) => _navigateToTournamentDetails(context, tournamentId),
                onBookTournament: tournamentId != null 
                  ? () => _bookTournament(context, bookTournamentProvider)
                  : null,
              );
            },
          ),
        );
      },
    );
  }

  void _bookTournament(BuildContext context, BookTournamentProvider provider) async {
    if (tournamentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tournament ID is missing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Tournament Booking'),
          content: const Text('Are you sure you want to book this tournament?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final success = await provider.bookTournament(
        tournamentId: tournamentId!,
        userId: userId,
      );

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament booked successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh the bookings list
        context.read<GetAllBookingProvider>().fetchTournamentBookings(userId);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Failed to book tournament'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCancelDialog(BuildContext context, String bookingId, GetAllBookingProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Tournament Booking'),
          content: const Text('Are you sure you want to cancel this tournament booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final success = await provider.cancelTournamentBooking(bookingId);
                
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tournament booking cancelled successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(provider.errorMessage ?? 'Failed to cancel booking'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToTournamentDetails(BuildContext context, String tournamentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TournamentDetailsScreen(tournamentId: tournamentId),
      ),
    );
  }
}

// class TournamentBookingCard extends StatelessWidget {
//   final TournamentBooking booking;
//   final Function(String) onCancel;
//   final Function(String) onViewDetails;
//   final VoidCallback? onBookTournament;

//   const TournamentBookingCard({
//     super.key,
//     required this.booking,
//     required this.onCancel,
//     required this.onViewDetails,
//     this.onBookTournament,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with tournament name and status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     booking.tournament?.name ?? 'Tournament Booking',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: _getStatusColor(booking.status),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     booking.status ?? 'Unknown',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
            
//             // Tournament details
//             if (booking.date != null) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.event_available, size: 16, color: Colors.grey),
//                   const SizedBox(width: 8),
//                   // Text(
//                   //   'Start: ${booking.}',
//                   //   style: const TextStyle(color: Colors.grey),
//                   // ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//             // if (booking.endDate != null) ...[
//             //   Row(
//             //     children: [
//             //       const Icon(Icons.event_busy, size: 16, color: Colors.grey),
//             //       const SizedBox(width: 8),
//             //       Text(
//             //         'End: ${booking.endDate}',
//             //         style: const TextStyle(color: Colors.grey),
//             //       ),
//             //     ],
//             //   ),
//             //   const SizedBox(height: 8),
//             // ],
//             if (booking.tournament?.location != null) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                   const SizedBox(width: 8),
//                   // Expanded(
//                   //   child: Text(
//                   //     booking.tournament.location,
//                   //     style: const TextStyle(color: Colors.grey),
//                   //     overflow: TextOverflow.ellipsis,
//                   //   ),
//                   // ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//             if (booking.tournament?.price != null) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.currency_rupee, size: 16, color: Colors.grey),
//                   const SizedBox(width: 8),
//                   Text(
//                     '₹${booking.tournament?.price}',
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//             // if (booking.tournament != null) ...[
//             //   Row(
//             //     children: [
//             //       const Icon(Icons.group, size: 16, color: Colors.grey),
//             //       const SizedBox(width: 8),
//             //       Text(
//             //         'Max Participants: ${booking.maxParticipants}',
//             //         style: const TextStyle(color: Colors.grey),
//             //       ),
//             //     ],
//             //   ),
//             // ],
            
//             const SizedBox(height: 16),
            
//             // Action buttons
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     TextButton(
//             //       onPressed: () => onViewDetails(booking.tournamentId ?? ''),
//             //       child: const Text('View Details'),
//             //     ),
//             //     const SizedBox(width: 8),
//             //     if (booking.status?.toLowerCase() == 'active' || 
//             //         booking.status?.toLowerCase() == 'registered') ...[
//             //       TextButton(
//             //         onPressed: () => onCancel(booking.id ?? ''),
//             //         child: const Text(
//             //           'Cancel',
//             //           style: TextStyle(color: Colors.red),
//             //         ),
//             //       ),
//             //     ],
//             //     if (onBookTournament != null && 
//             //         (booking.status?.toLowerCase() == 'cancelled' || 
//             //          booking.status?.toLowerCase() == 'expired')) ...[
//             //       ElevatedButton(
//             //         onPressed: onBookTournament,
//             //         style: ElevatedButton.styleFrom(
//             //           backgroundColor: Colors.blue,
//             //           foregroundColor: Colors.white,
//             //         ),
//             //         child: const Text('Book Again'),
//             //       ),
//             //     ],
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'active':
//       case 'registered':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       case 'completed':
//       case 'finished':
//         return Colors.blue;
//       case 'expired':
//         return Colors.grey;
//       default:
//         return Colors.grey;
//     }
//   }
// }














class TournamentBookingCard extends StatelessWidget {
  final TournamentBooking booking;
  final Function(String) onCancel;
  final Function(String) onViewDetails;
  final VoidCallback? onBookTournament;

  const TournamentBookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
    required this.onViewDetails,
    this.onBookTournament,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament image
          if (booking.tournament?.imageUrl != null && booking.tournament!.imageUrl.isNotEmpty)
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> TransactionHistoryScreen()));
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage('http://31.97.206.144:3081${booking.tournament!.imageUrl}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with tournament name and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        booking.tournament?.name ?? 'Tournament Booking',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        booking.status ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Tournament details
                if (booking.date != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.event_available, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Date: ${booking.date}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (booking.timeSlot != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Time: ${booking.timeSlot}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (booking.tournament?.location != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          booking.tournament!.location,
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (booking.tournament?.price != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.currency_rupee, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        '₹${booking.tournament!.price}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
                
                const SizedBox(height: 16),
                
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => onViewDetails(booking.tournament?.id ?? ''),
                      child: const Text('View Details'),
                    ),
                    const SizedBox(width: 8),
                    if (booking.status?.toLowerCase() == 'active' || 
                        booking.status?.toLowerCase() == 'registered') ...[
                      TextButton(
                        onPressed: () => onCancel(booking.bookingId),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                    if (onBookTournament != null && 
                        (booking.status?.toLowerCase() == 'cancelled' || 
                         booking.status?.toLowerCase() == 'expired')) ...[
                      ElevatedButton(
                        onPressed: onBookTournament,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Book Again'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
      case 'registered':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
      case 'finished':
        return Colors.blue;
      case 'expired':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}