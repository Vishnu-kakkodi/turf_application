// import 'package:booking_application/views/payment_screen.dart';
// import 'package:flutter/material.dart';

// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // App Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Cricket Field Image
//                     Container(
//                       height: 250,
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         image: const DecorationImage(
//                           image: AssetImage(
//                               'lib/assets/09d0574e4b33a62a36264c8e5854a3369b652275.png'), // You'll need to add this image
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.3),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Title and Price
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Cricket Complex',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const Text(
//                             '₹500/hr',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Location and Hours
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             color: Colors.blue,
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           const Text(
//                             'Kakinada',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         const SizedBox(width: 16),
//                         const Icon(
//                           Icons.access_time,
//                           color: Colors.blue,
//                           size: 16,
//                         ),
//                         const SizedBox(width: 4),
//                         const Text(
//                           '09 AM - 12 PM open',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     // Description
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Description',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                               height: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Facilities
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Facilities',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Row(
//                             children: [
//                               // Icon(
//                               //   Icons.local_parking,
//                               //   color: Colors.grey,
//                               //   size: 20,
//                               // ),
//                               SizedBox(width: 8),
//                               Container(
//                                 width: 75,
//                                 height: 33,
//                                 decoration: BoxDecoration(
//                                   color:
//                                       const Color.fromARGB(255, 249, 249, 249),
//                                   border: Border.all(
//                                     color: Colors.black,
//                                     width: 1.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(4.0),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Parking',
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Container(
//                                 width: 75,
//                                 height: 33,
//                                 decoration: BoxDecoration(
//                                   color:
//                                       const Color.fromARGB(255, 253, 250, 250),
//                                   border: Border.all(
//                                     color: Colors.black,
//                                     width: 1.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(4.0),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Food Court ',
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Select Slot
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         'Select Slot',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),
//                     TextFormField(
//                       readOnly: true,
//                       initialValue: '01/01/2025',
//                       decoration: InputDecoration(
//                         labelText: 'Select Date',
//                         labelStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                         hintText: '',
//                         hintStyle: TextStyle(
//                           color: Colors.grey[800],
//                           fontSize: 16,
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue, width: 2),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         fillColor: Colors.grey[50],
//                         filled: true,
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Time Slots Grid
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: GridView.count(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 2.5,
//                         children: const [
//                           TimeSlotCard(time: '09 - 10 AM', isAvailable: false),
//                           TimeSlotCard(time: '10 - 11 AM', isAvailable: true),
//                           TimeSlotCard(time: '11 - 12 PM', isAvailable: true),
//                           TimeSlotCard(time: '12 - 01 PM', isAvailable: true),
//                           TimeSlotCard(time: '01 - 02 PM', isAvailable: true),
//                           TimeSlotCard(time: '02 - 03 PM', isAvailable: true),
//                           TimeSlotCard(time: '12 - 01 PM', isAvailable: true),
//                           TimeSlotCard(time: '01 - 02 PM', isAvailable: true),
//                           TimeSlotCard(time: '02 - 03 PM', isAvailable: true),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),

//             // Book Now Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PaymentScreen()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text(
//                     'Book Now',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimeSlotCard extends StatelessWidget {
//   final String time;
//   final bool isAvailable;

//   const TimeSlotCard({
//     super.key,
//     required this.time,
//     required this.isAvailable,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isAvailable ? Colors.green[50] : Colors.red[50],
//         border: Border.all(
//           color: isAvailable ? Colors.green : Colors.red,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Text(
//           time,
//           style: TextStyle(
//             color: isAvailable ? Colors.green[700] : Colors.red[700],
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:booking_application/views/payment_screen.dart';
// import 'package:flutter/material.dart';

// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({super.key});

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   String selectedBookingType = 'full'; // 'full', 'half', 'quarter'
//   String selectedTimeSlot = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // App Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Cricket Field Image
//                     Container(
//                       height: 250,
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         image: const DecorationImage(
//                           image: AssetImage(
//                               'lib/assets/09d0574e4b33a62a36264c8e5854a3369b652275.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.3),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Title and Price
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Cricket Complex',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             _getPriceText(),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Ground Size Information
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.blue[200]!),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.straighten,
//                               color: Colors.blue[700],
//                               size: 20,
//                             ),
//                             const SizedBox(width: 3),
//                             Text(
//                               'Ground Size: 22 × 22 yards (Full Cricket Ground)',
//                               style: TextStyle(
//                                 color: Colors.blue[700],
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Location and Hours
//                  const   Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                            Icon(
//                             Icons.location_on,
//                             color: Colors.blue,
//                             size: 16,
//                           ),
//                            SizedBox(width: 4),
//                            Text(
//                             'Kakinada',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                  const   Row(
//                       children: [
//                          SizedBox(width: 16),
//                          Icon(
//                           Icons.access_time,
//                           color: Colors.blue,
//                           size: 16,
//                         ),
//                          SizedBox(width: 4),
//                          Text(
//                           '09 AM - 12 PM open',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     // Booking Type Selection
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select Booking Type',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: BookingTypeCard(
//                                   title: 'Full Ground',
//                                   subtitle: '22 × 22 yards',
//                                   price: '₹500/hr',
//                                   type: 'full',
//                                   isSelected: selectedBookingType == 'full',
//                                   onTap: () => setState(() => selectedBookingType = 'full'),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: BookingTypeCard(
//                                   title: 'Half Ground',
//                                   subtitle: '11 × 22 yards',
//                                   price: '₹300/hr',
//                                   type: 'half',
//                                   isSelected: selectedBookingType == 'half',
//                                   onTap: () => setState(() => selectedBookingType = 'half'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: BookingTypeCard(
//                                   title: 'Quarter Ground',
//                                   subtitle: '11 × 11 yards',
//                                   price: '₹200/hr',
//                                   type: 'quarter',
//                                   isSelected: selectedBookingType == 'quarter',
//                                   onTap: () => setState(() => selectedBookingType = 'quarter'),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Container(
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.grey[300]!),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       'More options\ncoming soon',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Description
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Description',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Professional cricket ground with well-maintained pitch and outfield. Perfect for matches, practice sessions, and training. Ground can be booked in full or partial sections based on your requirements.',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                               height: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Facilities
//                     // const Padding(
//                     //   padding: EdgeInsets.symmetric(horizontal: 16),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       Text(
//                     //         'Facilities',
//                     //         style: TextStyle(
//                     //           fontSize: 18,
//                     //           fontWeight: FontWeight.bold,
//                     //           color: Colors.black,
//                     //         ),
//                     //       ),
//                     //       SizedBox(height: 12),
//                     //       Wrap(
//                     //         spacing: 8,
//                     //         runSpacing: 8,
//                     //         children: [
//                     //           FacilityChip(text: 'Parking'),
//                     //           FacilityChip(text: 'Food Court'),
//                     //           FacilityChip(text: 'Changing Room'),
//                     //           FacilityChip(text: 'Washroom'),
//                     //           FacilityChip(text: 'Lighting'),
//                     //         ],
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),

//                     const SizedBox(height: 20),

//                     // Select Slot
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         'Select Slot',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: TextFormField(
//                         readOnly: true,
//                         initialValue: '01/01/2025',
//                         decoration: InputDecoration(
//                           labelText: 'Select Date',
//                           labelStyle: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 14,
//                           ),
//                           suffixIcon: const Icon(Icons.calendar_today, size: 20),
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           focusedBorder:  OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue, width: 2),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           fillColor: Colors.grey[50],
//                           filled: true,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Time Slots Grid
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: GridView.count(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 2.5,
//                         children: [
//                           TimeSlotCard(
//                             time: '09 - 10 AM',
//                             isAvailable: false,
//                             isSelected: selectedTimeSlot == '09 - 10 AM',
//                             onTap: () {},
//                           ),
//                           TimeSlotCard(
//                             time: '10 - 11 AM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '10 - 11 AM',
//                             onTap: () => setState(() => selectedTimeSlot = '10 - 11 AM'),
//                           ),
//                           TimeSlotCard(
//                             time: '11 - 12 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '11 - 12 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '11 - 12 PM'),
//                           ),
//                           TimeSlotCard(
//                             time: '12 - 01 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '12 - 01 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '12 - 01 PM'),
//                           ),
//                           TimeSlotCard(
//                             time: '01 - 02 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '01 - 02 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '01 - 02 PM'),
//                           ),
//                           TimeSlotCard(
//                             time: '02 - 03 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '02 - 03 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '02 - 03 PM'),
//                           ),
//                           TimeSlotCard(
//                             time: '03 - 04 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '03 - 04 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '03 - 04 PM'),
//                           ),
//                           TimeSlotCard(
//                             time: '04 - 05 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '04 - 05 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '04 - 05 PM'),
//                           ),
//                           TimeSlotCard(
//                             time: '05 - 06 PM',
//                             isAvailable: true,
//                             isSelected: selectedTimeSlot == '05 - 06 PM',
//                             onTap: () => setState(() => selectedTimeSlot = '05 - 06 PM'),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),

//             // Book Now Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: selectedTimeSlot.isEmpty ? null : () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PaymentScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: selectedTimeSlot.isEmpty ? Colors.grey : Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text(
//                     selectedTimeSlot.isEmpty
//                         ? 'Select a time slot to continue'
//                         : 'Book ${_getBookingTypeText()} - ${_getPriceText()}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getPriceText() {
//     switch (selectedBookingType) {
//       case 'half':
//         return '₹300/hr';
//       case 'quarter':
//         return '₹200/hr';
//       default:
//         return '₹500/hr';
//     }
//   }

//   String _getBookingTypeText() {
//     switch (selectedBookingType) {
//       case 'half':
//         return 'Half Ground';
//       case 'quarter':
//         return 'Quarter Ground';
//       default:
//         return 'Full Ground';
//     }
//   }
// }

// class BookingTypeCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String price;
//   final String type;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const BookingTypeCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.price,
//     required this.type,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 80,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue[50] : Colors.white,
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey[300]!,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: isSelected ? Colors.blue[600] : Colors.grey[600],
//               ),
//             ),
//             Text(
//               price,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FacilityChip extends StatelessWidget {
//   final String text;

//   const FacilityChip({
//     super.key,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         border: Border.all(color: Colors.grey[400]!),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: Colors.grey[700],
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class TimeSlotCard extends StatelessWidget {
//   final String time;
//   final bool isAvailable;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const TimeSlotCard({
//     super.key,
//     required this.time,
//     required this.isAvailable,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor;
//     Color borderColor;
//     Color textColor;

//     if (!isAvailable) {
//       backgroundColor = Colors.red[50]!;
//       borderColor = Colors.red;
//       textColor = Colors.red[700]!;
//     } else if (isSelected) {
//       backgroundColor = Colors.blue[100]!;
//       borderColor = Colors.blue;
//       textColor = Colors.blue[700]!;
//     } else {
//       backgroundColor = Colors.green[50]!;
//       borderColor = Colors.green;
//       textColor = Colors.green[700]!;
//     }

//     return GestureDetector(
//       onTap: isAvailable ? onTap : null,
//       child: Container(
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           border: Border.all(
//             color: borderColor,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             time,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:booking_application/views/payment_screen.dart';
// import 'package:flutter/material.dart';

// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({super.key});

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   String selectedBookingType = 'full';
//   String selectedTimeSlot = '';
//   int selectedHours = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // App Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Cricket Field Image
//                     Container(
//                       height: 250,
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         image: const DecorationImage(
//                           image: AssetImage(
//                               'lib/assets/09d0574e4b33a62a36264c8e5854a3369b652275.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.3),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Title and Price
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Cricket Complex',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             _getPriceText(),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Ground Size Information
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.blue[200]!),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.straighten,
//                               color: Colors.blue[700],
//                               size: 20,
//                             ),
//                             const SizedBox(width: 3),
//                             Text(
//                               'Ground Size: 22 × 22 yards (Full Cricket Ground)',
//                               style: TextStyle(
//                                 color: Colors.blue[700],
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Location and Hours
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.blue,
//                             size: 16,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Kakinada',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Row(
//                       children: [
//                         SizedBox(width: 16),
//                         Icon(
//                           Icons.access_time,
//                           color: Colors.blue,
//                           size: 16,
//                         ),
//                         SizedBox(width: 4),
//                         Text(
//                           '09 AM - 06 PM open',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     // Booking Type Selection
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select Booking Type',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: BookingTypeCard(
//                                   title: 'Full Ground',
//                                   subtitle: '22 × 22 yards',
//                                   price: '₹500/hr',
//                                   type: 'full',
//                                   isSelected: selectedBookingType == 'full',
//                                   onTap: () => setState(() => selectedBookingType = 'full'),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: BookingTypeCard(
//                                   title: 'Half Ground',
//                                   subtitle: '11 × 22 yards',
//                                   price: '₹300/hr',
//                                   type: 'half',
//                                   isSelected: selectedBookingType == 'half',
//                                   onTap: () => setState(() => selectedBookingType = 'half'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: BookingTypeCard(
//                                   title: 'Quarter Ground',
//                                   subtitle: '11 × 11 yards',
//                                   price: '₹200/hr',
//                                   type: 'quarter',
//                                   isSelected: selectedBookingType == 'quarter',
//                                   onTap: () => setState(() => selectedBookingType = 'quarter'),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Container(
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.grey[300]!),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       'More options\ncoming soon',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Hours Selection
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select Duration',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     for (int i = 1; i <= 4; i++) ...[
//                                       Expanded(
//                                         child: HourSelectionCard(
//                                           hours: i,
//                                           isSelected: selectedHours == i,
//                                           onTap: () => setState(() {
//                                             selectedHours = i;
//                                             selectedTimeSlot = ''; // Reset time slot when hours change
//                                           }),
//                                         ),
//                                       ),
//                                       if (i < 4) const SizedBox(width: 8),
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Description
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Description',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Professional cricket ground with well-maintained pitch and outfield. Perfect for matches, practice sessions, and training. Ground can be booked in full or partial sections based on your requirements.',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                               height: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Select Slot
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         'Select Date & Time',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: TextFormField(
//                         readOnly: true,
//                         initialValue: '01/01/2025',
//                         decoration: InputDecoration(
//                           labelText: 'Select Date',
//                           labelStyle: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 14,
//                           ),
//                           suffixIcon: const Icon(Icons.calendar_today, size: 20),
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue, width: 2),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           fillColor: Colors.grey[50],
//                           filled: true,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Time Slots Grid
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: GridView.count(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 3,
//                         children: _getAvailableTimeSlots(),
//                       ),
//                     ),

//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),

//             // Book Now Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: selectedTimeSlot.isEmpty ? null : () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PaymentScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: selectedTimeSlot.isEmpty ? Colors.grey : Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text(
//                     selectedTimeSlot.isEmpty
//                         ? 'Select a time slot to continue'
//                         : 'Book ${_getBookingTypeText()} - ${_getTotalPriceText()}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _getAvailableTimeSlots() {
//     List<String> allSlots = [
//       '09 - 10 AM',
//       '10 - 11 AM',
//       '11 - 12 PM',
//       '12 - 01 PM',
//       '01 - 02 PM',
//       '02 - 03 PM',
//       '03 - 04 PM',
//       '04 - 05 PM',
//       '05 - 06 PM',
//     ];

//     List<Widget> timeSlotWidgets = [];

//     for (int i = 0; i <= allSlots.length - selectedHours; i++) {
//       String startTime = allSlots[i].split(' - ')[0];
//       String endTime = allSlots[i + selectedHours - 1].split(' - ')[1];
//       String timeSlot = '$startTime - $endTime';

//       // Check if this slot is available (first slot is unavailable as example)
//       bool isAvailable = i != 0;

//       timeSlotWidgets.add(
//         TimeSlotCard(
//           time: timeSlot,
//           isAvailable: isAvailable,
//           isSelected: selectedTimeSlot == timeSlot,
//           onTap: () => setState(() => selectedTimeSlot = timeSlot),
//         ),
//       );
//     }

//     return timeSlotWidgets;
//   }

//   String _getPriceText() {
//     switch (selectedBookingType) {
//       case 'half':
//         return '₹300/hr';
//       case 'quarter':
//         return '₹200/hr';
//       default:
//         return '₹500/hr';
//     }
//   }

//   String _getTotalPriceText() {
//     int hourlyRate;
//     switch (selectedBookingType) {
//       case 'half':
//         hourlyRate = 300;
//         break;
//       case 'quarter':
//         hourlyRate = 200;
//         break;
//       default:
//         hourlyRate = 500;
//     }

//     int totalPrice = hourlyRate * selectedHours;
//     return '₹$totalPrice for ${selectedHours}h';
//   }

//   String _getBookingTypeText() {
//     switch (selectedBookingType) {
//       case 'half':
//         return 'Half Ground';
//       case 'quarter':
//         return 'Quarter Ground';
//       default:
//         return 'Full Ground';
//     }
//   }
// }

// class BookingTypeCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String price;
//   final String type;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const BookingTypeCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.price,
//     required this.type,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 80,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue[50] : Colors.white,
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey[300]!,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: isSelected ? Colors.blue[600] : Colors.grey[600],
//               ),
//             ),
//             Text(
//               price,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HourSelectionCard extends StatelessWidget {
//   final int hours;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const HourSelectionCard({
//     super.key,
//     required this.hours,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue[50] : Colors.white,
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey[300]!,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '$hours ${hours == 1 ? 'Hour' : 'Hours'}',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//             Text(
//               hours == 1 ? '1h' : '${hours}h',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isSelected ? Colors.blue[600] : Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimeSlotCard extends StatelessWidget {
//   final String time;
//   final bool isAvailable;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const TimeSlotCard({
//     super.key,
//     required this.time,
//     required this.isAvailable,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor;
//     Color borderColor;
//     Color textColor;

//     if (!isAvailable) {
//       backgroundColor = Colors.red[50]!;
//       borderColor = Colors.red;
//       textColor = Colors.red[700]!;
//     } else if (isSelected) {
//       backgroundColor = Colors.blue[100]!;
//       borderColor = Colors.blue;
//       textColor = Colors.blue[700]!;
//     } else {
//       backgroundColor = Colors.green[50]!;
//       borderColor = Colors.green;
//       textColor = Colors.green[700]!;
//     }

//     return GestureDetector(
//       onTap: isAvailable ? onTap : null,
//       child: Container(
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           border: Border.all(
//             color: borderColor,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             time,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/provider/book_turf_provider.dart';
// import 'package:booking_application/views/profile/booking_history.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DetailsScreen extends StatefulWidget {
//   final String? turfId;
//   final String? userId;
//   final String? slots;
//   final String? date;
//   final String? timeslot;
//   final String?image;

//   const DetailsScreen(
//       {super.key,
//       this.turfId,
//       this.userId,
//       this.slots,
//       this.timeslot,
//       this.date,
//       this.image
//       });

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   String selectedBookingType = 'full';
//   String selectedTimeSlot = '';
//   String selectedDate = '01/01/2025';
//   int selectedHours = 1;

//   @override
//   Widget build(BuildContext context) {
//    print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${widget.turfId}');
   

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // App Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Cricket Field Image
//                     Container(
//                       height: 250,
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         image: const DecorationImage(
//                           image: AssetImage(
//                               'lib/assets/09d0574e4b33a62a36264c8e5854a3369b652275.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.3),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Title and Price
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Cricket Complex',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             _getPriceText(),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Ground Size Information
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                     //   child: Container(
//                     //     padding: const EdgeInsets.all(12),
//                     //     decoration: BoxDecoration(
//                     //       color: Colors.blue[50],
//                     //       borderRadius: BorderRadius.circular(8),
//                     //       border: Border.all(color: Colors.blue[200]!),
//                     //     ),
//                     //     child: Row(
//                     //       children: [
//                     //         Icon(
//                     //           Icons.straighten,
//                     //           color: Colors.blue[700],
//                     //           size: 20,
//                     //         ),
//                     //         const SizedBox(width: 3),
//                     //         Text(
//                     //           'Ground Size: 22 × 22 yards (Full Cricket Ground)',
//                     //           style: TextStyle(
//                     //             color: Colors.blue[700],
//                     //             fontSize: 12,
//                     //             fontWeight: FontWeight.w500,
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),

//                     const SizedBox(height: 12),

//                     // Location and Hours
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.blue,
//                             size: 16,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Kakinada',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Row(
//                       children: [
//                         SizedBox(width: 16),
//                         Icon(
//                           Icons.access_time,
//                           color: Colors.blue,
//                           size: 16,
//                         ),
//                         SizedBox(width: 4),
//                         Text(
//                           '09 AM - 06 PM open',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),

//                     // const SizedBox(height: 20),

//                     // Booking Type Selection
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       // const Text(
//                     //       //   'Select Booking Type',
//                     //       //   style: TextStyle(
//                     //       //     fontSize: 18,
//                     //       //     fontWeight: FontWeight.bold,
//                     //       //     color: Colors.black,
//                     //       //   ),
//                     //       // ),
//                     //       // const SizedBox(height: 12),
//                     //       // Row(
//                     //       //   children: [
//                     //       //     Expanded(
//                     //       //       child: BookingTypeCard(
//                     //       //         title: 'Full Ground',
//                     //       //         subtitle: '22 × 22 yards',
//                     //       //         price: '₹500/hr',
//                     //       //         type: 'full',
//                     //       //         isSelected: selectedBookingType == 'full',
//                     //       //         onTap: () => setState(
//                     //       //             () => selectedBookingType = 'full'),
//                     //       //       ),
//                     //       //     ),
//                     //       //     const SizedBox(width: 8),
//                     //       //     Expanded(
//                     //       //       child: BookingTypeCard(
//                     //       //         title: 'Half Ground',
//                     //       //         subtitle: '11 × 22 yards',
//                     //       //         price: '₹300/hr',
//                     //       //         type: 'half',
//                     //       //         isSelected: selectedBookingType == 'half',
//                     //       //         onTap: () => setState(
//                     //       //             () => selectedBookingType = 'half'),
//                     //       //       ),
//                     //       //     ),
//                     //       //   ],
//                     //       // ),
//                     //       // const SizedBox(height: 8),
//                     //       // Row(
//                     //       //   children: [
//                     //       //     Expanded(
//                     //       //       child: BookingTypeCard(
//                     //       //         title: 'Quarter Ground',
//                     //       //         subtitle: '11 × 11 yards',
//                     //       //         price: '₹200/hr',
//                     //       //         type: 'quarter',
//                     //       //         isSelected: selectedBookingType == 'quarter',
//                     //       //         onTap: () => setState(
//                     //       //             () => selectedBookingType = 'quarter'),
//                     //       //       ),
//                     //       //     ),
//                     //       //     const SizedBox(width: 8),
//                     //       //     Expanded(
//                     //       //       child: Container(
//                     //       //         height: 80,
//                     //       //         decoration: BoxDecoration(
//                     //       //           color: Colors.grey[100],
//                     //       //           borderRadius: BorderRadius.circular(8),
//                     //       //           border:
//                     //       //               Border.all(color: Colors.grey[300]!),
//                     //       //         ),
//                     //       //         child: Center(
//                     //       //           child: Text(
//                     //       //             'More options\ncoming soon',
//                     //       //             textAlign: TextAlign.center,
//                     //       //             style: TextStyle(
//                     //       //               color: Colors.grey[600],
//                     //       //               fontSize: 12,
//                     //       //             ),
//                     //       //           ),
//                     //       //         ),
//                     //       //       ),
//                     //       //     ),
//                     //       //   ],
//                     //       // ),
//                     //     ],
//                     //   ),
//                     // ),

//                     // const SizedBox(height: 20),

//                     // Hours Selection
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       // const Text(
//                     //       //   'Select Duration',
//                     //       //   style: TextStyle(
//                     //       //     fontSize: 18,
//                     //       //     fontWeight: FontWeight.bold,
//                     //       //     color: Colors.black,
//                     //       //   ),
//                     //       // ),
//                     //       const SizedBox(height: 12),
//                     //       // Row(
//                     //       //   children: [
//                     //       //     Expanded(
//                     //       //       child: Row(
//                     //       //         children: [
//                     //       //           for (int i = 1; i <= 4; i++) ...[
//                     //       //             Expanded(
//                     //       //               child: HourSelectionCard(
//                     //       //                 hours: i,
//                     //       //                 isSelected: selectedHours == i,
//                     //       //                 onTap: () => setState(() {
//                     //       //                   selectedHours = i;
//                     //       //                   selectedTimeSlot =
//                     //       //                       ''; // Reset time slot when hours change
//                     //       //                 }),
//                     //       //               ),
//                     //       //             ),
//                     //       //             if (i < 4) const SizedBox(width: 8),
//                     //       //           ],
//                     //       //         ],
//                     //       //       ),
//                     //       //     ),
//                     //       //   ],
//                     //       // ),
//                     //     ],
//                     //   ),
//                     // ),

//                     const SizedBox(height: 20),

//                     // Description
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Description',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Professional cricket ground with well-maintained pitch and outfield. Perfect for matches, practice sessions, and training. Ground can be booked in full or partial sections based on your requirements.',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                               height: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Select Slot
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         'Select Date & Time',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: GestureDetector(
//                         onTap: () => _selectDate(context),
//                         child: TextFormField(
//                           enabled: false,
//                           controller: TextEditingController(text: selectedDate),
//                           decoration: InputDecoration(
//                             labelText: 'Select Date',
//                             labelStyle: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 14,
//                             ),
//                             suffixIcon:
//                                 const Icon(Icons.calendar_today, size: 20),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             disabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                                 const  BorderSide(color: Colors.blue, width: 2),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             fillColor: Colors.grey[50],
//                             filled: true,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Time Slots Grid
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: GridView.count(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 3,
//                         children: _getAvailableTimeSlots(),
//                       ),
//                     ),

//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),

//             // Book Now Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Consumer<BookTurfProvider>(
//                 builder: (context, bookTurfProvider, child) {
//                   return SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed:
//                           selectedTimeSlot.isEmpty || bookTurfProvider.isLoading
//                               ? null
//                               : () => _handleBooking(context, bookTurfProvider),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: selectedTimeSlot.isEmpty ||
//                                 bookTurfProvider.isLoading
//                             ? Colors.grey
//                             : Colors.blue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: bookTurfProvider.isLoading
//                           ? const Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   'Booking...',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : Text(
//                               selectedTimeSlot.isEmpty
//                                   ? 'Select a time slot to continue'
//                                   : 'Book Now',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate =
//             '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
//         selectedTimeSlot = ''; 
//       });
//     }
//   }

//   Future<void> _handleBooking(
//       BuildContext context, BookTurfProvider bookTurfProvider) async {
//     // Clear any previous errors
//     bookTurfProvider.clearError();

//     final success = await bookTurfProvider.bookTurfSlot(
//       turfId: widget.turfId ??
//           "688865ddf201232f79852955", // Use provided turfId or default
//       date: bookTurfProvider.formatDateForApi(selectedDate),
//       timeSlot: bookTurfProvider.formatTimeSlotForApi(selectedTimeSlot),
//     );

//     if (success) {
//       // Show success message
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Booking successful!'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 3),
//           ),
//         );

//         // Navigate to payment screen
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => PaymentScreen(),
//         //   ),
//         // );

//         final user = await UserPreferences.getUser();
//         final userId = user?.id?.toString();

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookingHistory(id: userId),
//           ),
//         );
//       }
//     } else {
//       // Show error message
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(bookTurfProvider.errorMessage ?? 'Booking failed'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }

//   // List<Widget> _getAvailableTimeSlots() {
//   //   List<String> allSlots = [
//   //     '09 - 10 AM',
//   //     '10 - 11 AM',
//   //     '11 - 12 PM',
//   //     '12 - 01 PM',
//   //     '01 - 02 PM',
//   //     '02 - 03 PM',
//   //     '03 - 04 PM',
//   //     '04 - 05 PM',
//   //     '05 - 06 PM',
//   //   ];

//   //   List<Widget> timeSlotWidgets = [];

//   //   for (int i = 0; i <= allSlots.length - selectedHours; i++) {
//   //     String startTime = allSlots[i].split(' - ')[0];
//   //     String endTime = allSlots[i + selectedHours - 1].split(' - ')[1];
//   //     String timeSlot = '$startTime - $endTime';

//   //     // Make all slots available (remove the i != 0 condition)
//   //     bool isAvailable = true; // Changed from 'i != 0' to 'true'

//   //     timeSlotWidgets.add(
//   //       TimeSlotCard(
//   //         time: timeSlot,
//   //         isAvailable: isAvailable,
//   //         isSelected: selectedTimeSlot == timeSlot,
//   //         onTap: () => setState(() => selectedTimeSlot = timeSlot),
//   //       ),
//   //     );
//   //   }

//   //   return timeSlotWidgets;
//   // }



// List<Widget> _getAvailableTimeSlots() {
//     // Updated to use API-compatible format directly
//     List<String> allSlots = [
//       '09-10 AM',  // Changed from '09 - 10 AM'
//       '10-11 AM',  // Changed from '10 - 11 AM'
//       '11-12 PM',  // Changed from '11 - 12 PM'
//       '12-01 PM',  // Changed from '12 - 01 PM'
//       '01-02 PM',  // Changed from '01 - 02 PM'
//       '02-03 PM',  // Changed from '02 - 03 PM'
//       '03-04 PM',  // Changed from '03 - 04 PM'
//       '04-05 PM',  // Changed from '04 - 05 PM'
//       '05-06 PM',  // Changed from '05 - 06 PM'
//     ];

//     List<Widget> timeSlotWidgets = [];

//     for (int i = 0; i <= allSlots.length - selectedHours; i++) {
//       String startTime = allSlots[i].split('-')[0];
//       String endTime = allSlots[i + selectedHours - 1].split('-')[1];
//       String timeSlot = '$startTime-$endTime';

//       // Make all slots available (remove the i != 0 condition)
//       bool isAvailable = true; // Changed from 'i != 0' to 'true'

//       timeSlotWidgets.add(
//         TimeSlotCard(
//           time: timeSlot.replaceAll('-', ' - '), // Display format with spaces for UI
//           isAvailable: isAvailable,
//           isSelected: selectedTimeSlot == timeSlot,
//           onTap: () => setState(() => selectedTimeSlot = timeSlot), // Store API format
//         ),
//       );
//     }

//     return timeSlotWidgets;
//   }








//   String _getPriceText() {
//     switch (selectedBookingType) {
//       case 'half':
//         return '₹300/hr';
//       case 'quarter':
//         return '₹200/hr';
//       default:
//         return '₹500/hr';
//     }
//   }

//   String _getTotalPriceText() {
//     int hourlyRate;
//     switch (selectedBookingType) {
//       case 'half':
//         hourlyRate = 300;
//         break;
//       case 'quarter':
//         hourlyRate = 200;
//         break;
//       default:
//         hourlyRate = 500;
//     }

//     int totalPrice = hourlyRate * selectedHours;
//     return '₹$totalPrice for ${selectedHours}h';
//   }

//   String _getBookingTypeText() {
//     switch (selectedBookingType) {
//       case 'half':
//         return 'Half Ground';
//       case 'quarter':
//         return 'Quarter Ground';
//       default:
//         return 'Full Ground';
//     }
//   }
// }

// class BookingTypeCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String price;
//   final String type;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const BookingTypeCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.price,
//     required this.type,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 80,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue[50] : Colors.white,
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey[300]!,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: isSelected ? Colors.blue[600] : Colors.grey[600],
//               ),
//             ),
//             Text(
//               price,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HourSelectionCard extends StatelessWidget {
//   final int hours;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const HourSelectionCard({
//     super.key,
//     required this.hours,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue[50] : Colors.white,
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey[300]!,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '$hours ${hours == 1 ? 'Hour' : 'Hours'}',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.blue[700] : Colors.black,
//               ),
//             ),
//             Text(
//               hours == 1 ? '1h' : '${hours}h',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isSelected ? Colors.blue[600] : Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimeSlotCard extends StatelessWidget {
//   final String time;
//   final bool isAvailable;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const TimeSlotCard({
//     super.key,
//     required this.time,
//     required this.isAvailable,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor;
//     Color borderColor;
//     Color textColor;

//     if (!isAvailable) {
//       backgroundColor = Colors.red[50]!;
//       borderColor = Colors.red;
//       textColor = Colors.red[700]!;
//     } else if (isSelected) {
//       backgroundColor = Colors.blue[100]!;
//       borderColor = Colors.blue;
//       textColor = Colors.blue[700]!;
//     } else {
//       backgroundColor = Colors.green[50]!;
//       borderColor = Colors.green;
//       textColor = Colors.green[700]!;
//     }

//     return GestureDetector(
//       onTap: isAvailable ? onTap : null,
//       child: Container(
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           border: Border.all(
//             color: borderColor,
//             width: isSelected ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             time,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }























import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/provider/book_turf_provider.dart';
import 'package:booking_application/provider/all_turf_provider.dart'; // Add this import
import 'package:booking_application/modal/venue_model.dart'; // Add this import
import 'package:booking_application/views/profile/booking_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final String? turfId;
  final String? userId;
  final String? slots;
  final String? date;
  final String? timeslot;
  final String? image;

  const DetailsScreen({
    super.key,
    this.turfId,
    this.userId,
    this.slots,
    this.timeslot,
    this.date,
    this.image
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedBookingType = 'full';
  String selectedTimeSlot = '';
  String selectedDate = '01/01/2025';
  int selectedHours = 1;
  VenueModel? currentVenue;

  @override
  void initState() {
    super.initState();
    _loadVenueDetails();
  }

  void _loadVenueDetails() {
    final allTurfProvider = Provider.of<AllTurfProvider>(context, listen: false);
    if (widget.turfId != null) {
      currentVenue = allTurfProvider.getTurfById(widget.turfId!);
      setState(() {});
    }
  }


  

  @override
  Widget build(BuildContext context) {
    print('Turf ID: ${widget.turfId}');
    print('user id ${widget.userId}');
    print('image ${widget.image}');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Venue Image
                    Container(
                      height: 250,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: currentVenue?.imageUrls.isNotEmpty == true
                              ? NetworkImage('http://31.97.206.144:3081${currentVenue!.imageUrls.first}')
                              : const AssetImage('lib/assets/09d0574e4b33a62a36264c8e5854a3369b652275.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title and Price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentVenue?.name ?? 'Loading...',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            currentVenue != null ? '₹${currentVenue!.pricePerHour}/hr' : '₹0/hr',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Location and Hours
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            currentVenue?.location ?? 'Loading...',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.blue,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            currentVenue?.openingTime ?? 'Loading...',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Facilities
                    if (currentVenue?.facilities.isNotEmpty == true) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: currentVenue!.facilities.map((facility) => 
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Text(
                                facility,
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentVenue?.description ?? 'Loading description...',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Select Slot
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Select Date & Time',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(text: selectedDate),
                          decoration: InputDecoration(
                            labelText: 'Select Date',
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            suffixIcon: const Icon(Icons.calendar_today, size: 20),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fillColor: Colors.grey[50],
                            filled: true,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Available Slots Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Available Time Slots',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Time Slots Grid - Now using backend data
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: currentVenue == null 
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : currentVenue!.slots.isEmpty
                          ? Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: const Center(
                                child: Text(
                                  'No slots available for this venue',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 3,
                              children: _getBackendTimeSlots(),
                            ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Book Now Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<BookTurfProvider>(
                builder: (context, bookTurfProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: selectedTimeSlot.isEmpty || bookTurfProvider.isLoading
                          ? null
                          : () => _handleBooking(context, bookTurfProvider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTimeSlot.isEmpty || bookTurfProvider.isLoading
                            ? Colors.grey
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: bookTurfProvider.isLoading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Booking...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              selectedTimeSlot.isEmpty
                                  ? 'Select a time slot to continue'
                                  : 'Book Now',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
        selectedTimeSlot = ''; // Reset selected time slot when date changes
      });
    }
  }

  Future<void> _handleBooking(BuildContext context, BookTurfProvider bookTurfProvider) async {
    // Clear any previous errors
    bookTurfProvider.clearError();

    final success = await bookTurfProvider.bookTurfSlot(
      turfId: widget.turfId ?? "688865ddf201232f79852955",
      date: bookTurfProvider.formatDateForApi(selectedDate),
      timeSlot: selectedTimeSlot, // Use the actual slot time format from backend
    );

    if (success) {
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking successful!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        final user = await UserPreferences.getUser();
        final userId = user?.id?.toString();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingHistory(id: userId,tournamentId: widget.turfId,date: selectedDate,timeSlot: selectedTimeSlot,),
          ),
        );
      }
    } else {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(bookTurfProvider.errorMessage ?? 'Booking failed'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // New method to get slots from backend
  List<Widget> _getBackendTimeSlots() {
    if (currentVenue?.slots.isEmpty == true) {
      return [];
    }

    // Filter slots for the selected date
    String apiFormattedDate = _formatDateForApi(selectedDate);
    
    List<Slot> slotsForSelectedDate = currentVenue!.slots.where((slot) {
      return slot.date == apiFormattedDate;
    }).toList();

    if (slotsForSelectedDate.isEmpty) {
      return [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange[50],
            border: Border.all(color: Colors.orange[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'No slots available for selected date',
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ];
    }

    return slotsForSelectedDate.map((slot) {
      bool isAvailable = !slot.isBooked;
      bool isSelected = selectedTimeSlot == slot.timeSlot;

      return TimeSlotCard(
        time: slot.timeSlot.replaceAll('-', ' - '), // Display format with spaces
        isAvailable: isAvailable,
        isSelected: isSelected,
        onTap: () => setState(() => selectedTimeSlot = slot.timeSlot), // Store API format
      );
    }).toList();
  }

  // Helper method to format date for API
  String _formatDateForApi(String displayDate) {
    // Convert from "01/01/2025" to "2025-01-01"
    List<String> parts = displayDate.split('/');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
    }
    return displayDate;
  }

  String _getPriceText() {
    if (currentVenue != null) {
      return '₹${currentVenue!.pricePerHour}/hr';
    }
    return '₹0/hr';
  }
}

// Keep your existing widget classes
class BookingTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const BookingTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue[700] : Colors.black,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.blue[700] : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HourSelectionCard extends StatelessWidget {
  final int hours;
  final bool isSelected;
  final VoidCallback onTap;

  const HourSelectionCard({
    super.key,
    required this.hours,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$hours ${hours == 1 ? 'Hour' : 'Hours'}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue[700] : Colors.black,
              ),
            ),
            Text(
              hours == 1 ? '1h' : '${hours}h',
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final String time;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.time,
    required this.isAvailable,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    String displayText;

    if (!isAvailable) {
      backgroundColor = Colors.red[50]!;
      borderColor = Colors.red;
      textColor = Colors.red[700]!;
      displayText = '$time\nBooked';
    } else if (isSelected) {
      backgroundColor = Colors.blue[100]!;
      borderColor = Colors.blue;
      textColor = Colors.blue[700]!;
      displayText = '$time\nSelected';
    } else {
      backgroundColor = Colors.green[50]!;
      borderColor = Colors.green;
      textColor = Colors.green[700]!;
      displayText = '$time\nAvailable';
    }

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}