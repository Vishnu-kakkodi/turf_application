// import 'package:booking_application/cart_screen.dart';
// import 'package:booking_application/category/category_screen.dart';
// import 'package:booking_application/home/home_screen.dart';
// import 'package:booking_application/provider/navbar_provider.dart';
// import 'package:booking_application/views/profile/my_bookings.dart';
// import 'package:booking_application/views/profile/profile_screen.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class NavbarScreen extends StatelessWidget {
//   const NavbarScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottomnavbarProvider = Provider.of<BottomNavbarProvider>(context);

//     final pages = [
//       HomeScreen(),
//       CategoryScreen(),
//       MyBookings(),
//       ProfileScreen(),
//       CartScreen()
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[bottomnavbarProvider.currentIndex],
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 12.0),
//         child: PhysicalModel(
//           color: Colors.transparent,
//           elevation: 12,
//           shadowColor: const Color.fromARGB(66, 0, 0, 0),
//           borderRadius: BorderRadius.circular(30),
//           child: CurvedNavigationBar(
//             index: bottomnavbarProvider.currentIndex,
//             height: 60,
//             backgroundColor: Colors.transparent,
//             color: const Color(0xFF34495E),
//             buttonBackgroundColor: const Color(0xFFF39C12),
//             animationDuration: const Duration(milliseconds: 300),
//             animationCurve: Curves.easeInOut,
//             onTap: (index) {
//               bottomnavbarProvider.setIndex(index);
//             },
//             items: const [
//               _NavBarItem(icon: Icons.home_outlined, label: 'Home'),
//               _NavBarItem(icon: Icons.grid_view_rounded, label: 'Category'),
//               _NavBarItem(icon: Icons.assignment, label: 'Bookings'),
//               _NavBarItem(icon: Icons.person_outline, label: 'Profile'),
//               _NavBarItem(icon: Icons.shopping_cart, label: 'Cart'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NavBarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const _NavBarItem({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 24, color: Colors.white),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }












import 'package:booking_application/History/history_screen.dart';
import 'package:booking_application/cart_screen.dart';
import 'package:booking_application/category/category_screen.dart';
import 'package:booking_application/home/home_screen.dart';
import 'package:booking_application/provider/navbar_provider.dart';
import 'package:booking_application/views/profile/booking_history.dart';
import 'package:booking_application/views/profile/my_bookings.dart';
import 'package:booking_application/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomnavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      HomeScreen(),
      CategoryScreen(),
      BookingHistory(),
      ProfileScreen(),
      CartScreen(),
    ];

    return Scaffold(
      body: pages[bottomnavbarProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomnavbarProvider.currentIndex,
        onTap: (index) => bottomnavbarProvider.setIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFF39C12),
        unselectedItemColor: Colors.grey[600],
        // backgroundColor: Color(0xFF34495E),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
        ],
      ),
    );
  }
}
