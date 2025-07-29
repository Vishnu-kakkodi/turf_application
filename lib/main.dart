
import 'package:booking_application/onboardingscreen/splash_screen.dart';
import 'package:booking_application/provider/category_provider.dart';
import 'package:booking_application/provider/login_provider.dart';
import 'package:booking_application/provider/navbar_provider.dart';
import 'package:booking_application/provider/registration_provider.dart';
import 'package:booking_application/provider/upcoming_tournament_provider.dart';
import 'package:booking_application/provider/user_details_provider.dart';
import 'package:booking_application/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_)=>RegistrationProvider()),
        ChangeNotifierProvider(create: (_)=>LoginProvider()),
        ChangeNotifierProvider(create: (_)=>UserDetailsProvider()),
        ChangeNotifierProvider(create: (_)=>CategoryProvider()),
        ChangeNotifierProvider(create: (_)=>UserProfileProvider()),
        ChangeNotifierProvider(create: (_)=>UpcomingTournamentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Booking Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
