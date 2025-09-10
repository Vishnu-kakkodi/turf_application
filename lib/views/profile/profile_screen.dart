// import 'package:booking_application/payment/payment_history.dart';
// import 'package:booking_application/views/player_profile_screen.dart';
// import 'package:booking_application/views/profile/booking_history.dart';
// import 'package:booking_application/views/profile/personal_information_screen.dart';
// import 'package:booking_application/views/subscription_screen.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, icon:const Icon(Icons.arrow_back)),
//         title: const Text('Profile',style: TextStyle(fontWeight: FontWeight.bold),),
//         centerTitle: false,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const SectionTitle(title: 'Account'),
//           const SizedBox(height: 8),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalInformationScreen()));
//             },
//             child: const ProfileTile(
//               icon: Icons.person_outline,
//               title: 'Personal information',
//             ),
//           ),
//            const SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerProfileScreen()));
//             },
//             child: const ProfileTile(
//               icon: Icons.person_4_rounded,
//               title: 'Player Profile',
//             ),
//           ),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingHistory()));
//             },
//             child: const ProfileTile(
//               icon: Icons.history,
//               title: 'Booking History',
//             ),
//           ),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentHistory()));
//             },
//             child: const ProfileTile(
//               icon: Icons.payment,
//               title: 'Payment History',
//             ),
//           ),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionScreen()));
//             },
//             child: const ProfileTile(
//               icon: Icons.verified,
//               title: 'Upgrade to Premium',
//             ),
//           ),
//           const SizedBox(height: 24),
//           const SectionTitle(title: 'Account'),
//           const SizedBox(height: 8),
//           const ProfileTile(
//             icon: Icons.help_outline,
//             title: 'Need Help?',
//           ),
//           const SizedBox(height: 10),
//           const ProfileTile(
//             icon: Icons.phone_outlined,
//             title: 'Contact Us',
//           ),
//            const SizedBox(height: 10),

//           GestureDetector(
//             onTap: () {
//               // Add logout logic here
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.logout, color: Colors.red),
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Text(
//                       'Logout',
//                       style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style:
//           const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
//     );
//   }
// }

// class ProfileTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   const ProfileTile({super.key, required this.icon, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.black54),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(title, style: const TextStyle(fontSize: 16)),
//           ),
//           const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//         ],
//       ),
//     );
//   }
// }

import 'package:booking_application/auth/login_screen.dart';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/payment/payment_history.dart';
import 'package:booking_application/views/player_profile_screen.dart';
import 'package:booking_application/views/profile/booking_history.dart';
import 'package:booking_application/views/profile/personal_information_screen.dart';
import 'package:booking_application/views/subscription_screen.dart';
// Add this import for your UserPreferences class
// Add import for your login screen - replace with your actual login screen path
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Logout function
  Future<void> _handleLogout(BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Clear user data
      bool success = await UserPreferences.clearUserData();

      // Dismiss loading dialog
      Navigator.of(context).pop();

      if (success) {
        // Navigate to login screen and clear all previous routes
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to logout. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Dismiss loading dialog if it's still showing
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show confirmation dialog before logout
  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(onPressed: (){
        //   Navigator.of(context).pop();
        // }, icon:const Icon(Icons.arrow_back)),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Account'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalInformationScreen()));
            },
            child: const ProfileTile(
              icon: Icons.person_outline,
              title: 'Personal information',
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlayerProfileScreen()));
            },
            child: const ProfileTile(
              icon: Icons.person_4_rounded,
              title: 'Player Profile',
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookingHistory()));
            },
            child: const ProfileTile(
              icon: Icons.history,
              title: 'Booking History',
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingHistory()));
            },
            child: const ProfileTile(
              icon: Icons.person,
              title: 'Want to become a owner',
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentHistory()));
            },
            child: const ProfileTile(
              icon: Icons.payment,
              title: 'Payment History',
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubscriptionScreen()));
            },
            child: const ProfileTile(
              icon: Icons.verified,
              title: 'Upgrade to Premium',
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Support'),
          const SizedBox(height: 8),
          const ProfileTile(
            icon: Icons.help_outline,
            title: 'Need Help?',
          ),
          const SizedBox(height: 10),
          const ProfileTile(
            icon: Icons.phone_outlined,
            title: 'Contact Us',
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _showLogoutDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
