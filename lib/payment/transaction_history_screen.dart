import 'package:booking_application/modal/getall_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final TurfBooking? turfBooking;
  final TournamentBooking? tournamentBooking;
  final String bookingType; // 'turf' or 'tournament'

  const TransactionHistoryScreen({
    super.key,
    this.turfBooking,
    this.tournamentBooking,
    required this.bookingType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _shareBookingDetails(context),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: bookingType == 'turf' 
          ? _buildTurfBookingDetails(context)
          : _buildTournamentBookingDetails(context),
    );
  }

  Widget _buildTurfBookingDetails(BuildContext context) {
    if (turfBooking == null) {
      return const Center(
        child: Text('Booking details not available'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Image Section
          if (turfBooking!.images.isNotEmpty)
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('http://31.97.206.144:3081${turfBooking!.images.first}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        turfBooking!.turfName ?? 'Turf Booking',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(turfBooking!.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          turfBooking!.status ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Booking Information Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildInfoRow(
                      icon: Icons.confirmation_number,
                      label: 'Booking ID',
                      value: turfBooking!.bookingId ?? 'N/A',
                      copyable: true,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      icon: Icons.sports_soccer,
                      label: 'Turf Name',
                      value: turfBooking!.turfName ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      icon: Icons.calendar_today,
                      label: 'Booking Date',
                      value: turfBooking!.date ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      icon: Icons.access_time,
                      label: 'Time Slot',
                      value: turfBooking!.timeSlot ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      icon: Icons.location_on,
                      label: 'Location',
                      value: turfBooking!.turfLocation ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    
                    // if (turfBooking!.price != null)
                    //   _buildInfoRow(
                    //     icon: Icons.currency_rupee,
                    //     label: 'Amount Paid',
                    //     value: '₹${turfBooking!.price}',
                    //     highlighted: true,
                    //   ),
                  ],
                ),
              ),
            ),
          ),

          // Images Gallery
          if (turfBooking!.images.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: turfBooking!.images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _showImageDialog(context, turfBooking!.images, index),
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage('http://31.97.206.144:3081${turfBooking!.images[index]}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTournamentBookingDetails(BuildContext context) {
    if (tournamentBooking == null) {
      return const Center(
        child: Text('Tournament booking details not available'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Image Section
          if (tournamentBooking!.tournament?.imageUrl != null && 
              tournamentBooking!.tournament!.imageUrl.isNotEmpty)
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('http://31.97.206.144:3081${tournamentBooking!.tournament!.imageUrl}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournamentBooking!.tournament?.name ?? 'Tournament Booking',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(tournamentBooking!.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tournamentBooking!.status ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Tournament Information Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tournament Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildInfoRow(
                      icon: Icons.confirmation_number,
                      label: 'Booking ID',
                      value: tournamentBooking!.bookingId ?? 'N/A',
                      copyable: true,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      icon: Icons.emoji_events,
                      label: 'Tournament Name',
                      value: tournamentBooking!.tournament?.name ?? 'N/A',
                    ),
                    const SizedBox(height: 16),
                    
                    if (tournamentBooking!.date != null) ...[
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        label: 'Tournament Date',
                        value: tournamentBooking!.date!,
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    if (tournamentBooking!.timeSlot != null) ...[
                      _buildInfoRow(
                        icon: Icons.access_time,
                        label: 'Time Slot',
                        value: tournamentBooking!.timeSlot!,
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    if (tournamentBooking!.tournament?.location != null) ...[
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: 'Location',
                        value: tournamentBooking!.tournament!.location,
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    if (tournamentBooking!.tournament?.price != null)
                      _buildInfoRow(
                        icon: Icons.currency_rupee,
                        label: 'Registration Fee',
                        value: '₹${tournamentBooking!.tournament!.price}',
                        highlighted: true,
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Tournament Description
          if (tournamentBooking!.tournament?.description != null && 
              tournamentBooking!.tournament!.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        tournamentBooking!.tournament!.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool copyable = false,
    bool highlighted = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: highlighted ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: highlighted ? FontWeight.bold : FontWeight.w500,
                        color: highlighted ? Colors.green : Colors.black87,
                      ),
                    ),
                  ),
                  if (copyable)
                    GestureDetector(
                      onTap: () => _copyToClipboard(value),
                      child: const Icon(
                        Icons.copy,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // Note: You might want to show a snackbar here to confirm copy
  }

  void _showImageDialog(BuildContext context, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: images.length,
                  controller: PageController(initialPage: initialIndex),
                  itemBuilder: (context, index) {
                    return InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 3.0,
                      child: Image.network(
                        'http://31.97.206.144:3081${images[index]}',
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _shareBookingDetails(BuildContext context) {
    String bookingDetails = '';
    
    if (bookingType == 'turf' && turfBooking != null) {
      bookingDetails = '''
Turf Booking Details:
Booking ID: ${turfBooking!.bookingId ?? 'N/A'}
Turf Name: ${turfBooking!.turfName ?? 'N/A'}
Date: ${turfBooking!.date ?? 'N/A'}
Time: ${turfBooking!.timeSlot ?? 'N/A'}
Location: ${turfBooking!.turfLocation ?? 'N/A'}
Status: ${turfBooking!.status ?? 'N/A'}
''';
    } else if (bookingType == 'tournament' && tournamentBooking != null) {
      bookingDetails = '''
Tournament Booking Details:
Booking ID: ${tournamentBooking!.bookingId ?? 'N/A'}
Tournament: ${tournamentBooking!.tournament?.name ?? 'N/A'}
Date: ${tournamentBooking!.date ?? 'N/A'}
Time: ${tournamentBooking!.timeSlot ?? 'N/A'}
Location: ${tournamentBooking!.tournament?.location ?? 'N/A'}
Status: ${tournamentBooking!.status ?? 'N/A'}
''';
    }

    // Copy to clipboard for now - you can integrate with share_plus package for actual sharing
    Clipboard.setData(ClipboardData(text: bookingDetails));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking details copied to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
      case 'confirmed':
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