import 'package:booking_application/onboardingscreen/splash_screen.dart';
import 'package:booking_application/provider/LocationProvider/location_provider.dart';
import 'package:booking_application/provider/all_turf_provider.dart';
import 'package:booking_application/provider/book_tournament_provider.dart';
import 'package:booking_application/provider/book_turf_provider.dart';
import 'package:booking_application/provider/category_provider.dart';
import 'package:booking_application/provider/getall_booking_provider.dart';
import 'package:booking_application/provider/location_provider.dart';
import 'package:booking_application/provider/login_provider.dart';
import 'package:booking_application/provider/match_game_provider.dart';
import 'package:booking_application/provider/match_provider.dart';
import 'package:booking_application/provider/my_turf_booking_provider.dart';
import 'package:booking_application/provider/navbar_provider.dart';
import 'package:booking_application/provider/nearby_turf_provider.dart';
import 'package:booking_application/provider/notification_provider.dart';
import 'package:booking_application/provider/registration_provider.dart';
import 'package:booking_application/provider/single_match_provider.dart';
import 'package:booking_application/provider/single_tournament_provider.dart';
import 'package:booking_application/provider/tournament_category_provider.dart';
import 'package:booking_application/provider/tournament_provider.dart';
import 'package:booking_application/provider/upcoming_tournament_provider.dart';
import 'package:booking_application/provider/user_details_provider.dart';
import 'package:booking_application/provider/user_profile_provider.dart';
import 'package:booking_application/views/Cricket/providers/team_provider.dart';
import 'package:booking_application/views/Cricket/providers/tournament_provider.dart';
import 'package:booking_application/views/Games/GameProvider/team_provider.dart';
import 'package:booking_application/views/Games/game_provider.dart';
import 'package:booking_application/views/Tournaments/TournamentProvider/tournament_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => UpcomingTournamentProvider()),
        // ChangeNotifierProvider(create: (_)=>LocationProvider()),
        ChangeNotifierProvider(create: (_) => AllTurfProvider()),
        ChangeNotifierProvider(create: (_) => TournamentProvider()),
        ChangeNotifierProvider(create: (_) => SingleTournamentProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => BookTurfProvider()),
        ChangeNotifierProvider(create: (_) => MyTurfBookingProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => BookTournamentProvider()),
        ChangeNotifierProvider(create: (_) => TournamentCategoryProvider()),
        ChangeNotifierProvider(create: (_) => GetAllBookingProvider()),
        ChangeNotifierProvider(create: (_) => MatchProvider()),
        ChangeNotifierProvider(create: (_) => MatchGameProvider()),
        ChangeNotifierProvider(create: (_) => SingleMatchGameProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
                ChangeNotifierProvider(create: (_) => NewTournamentProvider()),
                                ChangeNotifierProvider(create: (_) => LocationFetchProvider()),
                                                                ChangeNotifierProvider(create: (_) => TeamNewProvider()),
                                                                                                                                ChangeNotifierProvider(create: (_) => TournamentNewProvider())




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
