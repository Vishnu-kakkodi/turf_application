// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:booking_application/services/book_turf_services.dart';


// class BookTurfProvider extends ChangeNotifier {
//   final BookTurfServices _bookTurfServices = BookTurfServices();
  
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

//   // Book turf slot
//   Future<bool> bookTurfSlot({
//     required String turfId,
//     required String date,
//     required String timeSlot,
//   }) async {
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

//       final response = await _bookTurfServices.bookTurfSlot(
//         userId: user.id ?? '',
//         turfId: turfId,
//         date: date,
//         timeSlot: timeSlot,
//         token: token,
//       );

//       _bookingResponse = response;

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

//   // Format date for API (assuming input is DD/MM/YYYY and API expects YYYY-MM-DD)
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

//   // Format time slot for API
//   String formatTimeSlotForApi(String timeSlot) {
//     // Convert "09 - 10 AM" to "09 - 10  AM" (API format with double space)
//     return timeSlot.replaceAll(' - ', ' - ').replaceAll(' AM', '  AM').replaceAll(' PM', '  PM');
//   }
// }

















import 'package:booking_application/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:booking_application/services/book_turf_services.dart';


class BookTurfProvider extends ChangeNotifier {
  final BookTurfServices _bookTurfServices = BookTurfServices();
  
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

  // Book turf slot
  Future<bool> bookTurfSlot({
    required String turfId,
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

      if (user == null) {
        _errorMessage = 'User not found. Please login again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await _bookTurfServices.bookTurfSlot(
        userId: user.id ?? '',
        turfId: turfId,
        date: date,
        timeSlot: timeSlot,
        token: token,
      );

      _bookingResponse = response;

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
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Format date for API (assuming input is DD/MM/YYYY and API expects YYYY-MM-DD)
  String formatDateForApi(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  // Format time slot for API - FIXED VERSION
  String formatTimeSlotForApi(String timeSlot) {
    // Convert "09 - 10 AM" to "09-10 AM" (API format with hyphen, no spaces around it)
    return timeSlot.replaceAll(' - ', '-');
  }
}