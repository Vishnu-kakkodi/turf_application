

// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:booking_application/services/book_tournament_slot_services.dart';
// import 'package:flutter/material.dart';

// class BookTournamentProvider extends ChangeNotifier {
//   final BookTournamentSlotServices _bookTournamentServices =
//       BookTournamentSlotServices();

//   bool _isLoading = false;
//   String? _errorMessage;
//   Map<String, dynamic>? _bookingResponse;

//   // Getters
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   Map<String, dynamic>? get bookingResponse => _bookingResponse;

//   // Clear error message
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   // Clear booking response
//   void clearBookingResponse() {
//     _bookingResponse = null;
//     notifyListeners();
//   }

//   Future<bool> bookTournamentSlot({
//     required String tournamentId,
//     required String date,
//     required String slotId, // Changed from timeSlot to slotId
//   }) async {

//     //Newly added code
//     if (tournamentId.isEmpty || date.isEmpty || slotId.isEmpty) {
//       _errorMessage = 'All fields are required';
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       // Get user data and token from preferences
//       final user = await UserPreferences.getUser();
//       final token = await UserPreferences.getToken();

//       if (user == null) {
//         _errorMessage = 'User not found. Please login again.';
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }

//       final response = await _bookTournamentServices.bookTournamentSlot(
//         userId: user.id,
//         tournamentId: tournamentId,
//         date: date,
//         slotId: slotId, // Pass slotId instead of timeSlot
//         token: token,
//       );

//       _bookingResponse = response;


//       print('userrrrrrrrrrrrrrrrrrrrrrrrid ${user.id}');

//       if (response['success'] == true) {
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _errorMessage = response['message'] ?? 'Booking failed';
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = 'An unexpected error occurred: ${e.toString()}';
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   String formatDateForApi(String dateString) {
//     try {
//       final parts = dateString.split('/');
//       if (parts.length == 3) {
//         return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
//       }
//       return dateString;
//     } catch (e) {
//       return dateString;
//     }
//   }

//   String formatTimeSlotForApi(String timeSlot) {
//     return timeSlot.replaceAll(' - ', '-');
//   }
// }





















import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/services/book_tournament_slot_services.dart';
import 'package:flutter/material.dart';

class BookTournamentProvider extends ChangeNotifier {
  final BookTournamentSlotServices _bookTournamentServices =
      BookTournamentSlotServices();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _bookingResponse;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get bookingResponse => _bookingResponse;

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear booking response
  void clearBookingResponse() {
    _bookingResponse = null;
    notifyListeners();
  }

  Future<bool> bookTournamentSlot({
    required String tournamentId,
    required String date,
    required String timeSlot,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Get user data and token from preferences
      final user = await UserPreferences.getUser();
      final token = await UserPreferences.getToken();

      // Debug prints to check what we have
      print('=== BOOKING DEBUG INFO ===');
      print('User: $user');
      print('User ID: ${user?.id}');
      print('Tournament ID: $tournamentId');
      print('Date: $date');
      print('timeslot: $timeSlot');
      // print('Token: $token');

      if (user == null || user.id.isEmpty) {
        _errorMessage = 'User not found. Please login again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Validate all required fields before making the API call
      if (tournamentId.trim().isEmpty) {
        _errorMessage = 'Tournament ID is missing';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (date.trim().isEmpty) {
        _errorMessage = 'Date is missing';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (timeSlot.trim().isEmpty) {
        _errorMessage = 'Slot ID is missing';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await _bookTournamentServices.bookTournamentSlot(
        userId: user.id.trim(),
        tournamentId: tournamentId.trim(),
        date: date.trim(),
        timeSlot: timeSlot.trim(),
        token: token,
      );

      _bookingResponse = response;

      print('=== BOOKING RESPONSE ===');
      print('Response: $response');

      if (response['success'] == true) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Booking failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('=== BOOKING ERROR ===');
      print('Error: $e');
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }


  Future<bool> bookTournament({
  required String tournamentId,
  required String userId,
  String? date,
  String? timeSlot,
}) async {
  return await bookTournamentSlot(
    tournamentId: tournamentId,
    date: date ?? DateTime.now().toString().split(' ')[0], // Default to today
    timeSlot: timeSlot ?? '09:00-10:00', // Default time slot
  );
}

  String formatDateForApi(String dateString) {
    try {
      if (dateString.trim().isEmpty) {
        return '';
      }
      
      // Handle different date formats
      if (dateString.contains('-')) {
        // Already in YYYY-MM-DD format
        return dateString;
      }
      
      final parts = dateString.split('/');
      if (parts.length == 3) {
        // Convert DD/MM/YY or DD/MM/YYYY to YYYY-MM-DD
        String year = parts[2];
        if (year.length == 2) {
          // Convert YY to YYYY (assuming 20YY for years 00-99)
          year = '20$year';
        }
        return '$year-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
      }
      return dateString;
    } catch (e) {
      print('Date formatting error: $e');
      return dateString;
    }
  }

 String formatTimeSlotForApi(String timeSlot) {
  // Remove any spaces around the dash for consistency
  return timeSlot.replaceAll(' - ', '-').replaceAll(' ', '');
}
}