import 'package:booking_application/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:booking_application/services/my_turf_booking_services.dart';


class MyTurfBookingProvider extends ChangeNotifier {
  final MyTurfBookingServices _services = MyTurfBookingServices();
  
  // Loading states
  bool _isLoading = false;
  bool _isCancellingBooking = false;
  bool _isReschedulingBooking = false;
  
  // Data
  List<dynamic> _venueBookings = [];
  List<dynamic> _tournamentBookings = [];
  String? _errorMessage;
  
  // Getters
  bool get isLoading => _isLoading;
  bool get isCancellingBooking => _isCancellingBooking;
  bool get isReschedulingBooking => _isReschedulingBooking;
  List<dynamic> get venueBookings => _venueBookings;
  List<dynamic> get tournamentBookings => _tournamentBookings;
  String? get errorMessage => _errorMessage;

  // Fetch user's turf bookings
  Future<void> fetchMyTurfBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Get user data and token from shared preferences
      final user = await UserPreferences.getUser();
      final token = await UserPreferences.getToken();
      
      if (user == null || token == null) {
        _errorMessage = 'User not authenticated';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final result = await _services.getMyTurfBookings(user.id.toString(), token);
      
      if (result['success']) {
        final data = result['data'];
        
        // Separate venue and tournament bookings
        _venueBookings = data['venueBookings'] ?? [];
        _tournamentBookings = data['tournamentBookings'] ?? [];
        
        _errorMessage = null;
      } else {
        _errorMessage = result['message'];
        _venueBookings = [];
        _tournamentBookings = [];
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch bookings: $e';
      _venueBookings = [];
      _tournamentBookings = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cancel a booking
  Future<bool> cancelBooking(String bookingId) async {
    _isCancellingBooking = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await UserPreferences.getToken();
      
      if (token == null) {
        _errorMessage = 'User not authenticated';
        _isCancellingBooking = false;
        notifyListeners();
        return false;
      }

      final result = await _services.cancelBooking(bookingId, token);
      
      if (result['success']) {
        // Refresh the bookings list
        await fetchMyTurfBookings();
        _isCancellingBooking = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        _isCancellingBooking = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Failed to cancel booking: $e';
      _isCancellingBooking = false;
      notifyListeners();
      return false;
    }
  }

  // Reschedule a booking
  Future<bool> rescheduleBooking(
    String bookingId, 
    String newDate, 
    String newTimeSlot
  ) async {
    _isReschedulingBooking = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await UserPreferences.getToken();
      
      if (token == null) {
        _errorMessage = 'User not authenticated';
        _isReschedulingBooking = false;
        notifyListeners();
        return false;
      }

      final result = await _services.rescheduleBooking(
        bookingId, 
        newDate, 
        newTimeSlot, 
        token
      );
      
      if (result['success']) {
        // Refresh the bookings list
        await fetchMyTurfBookings();
        _isReschedulingBooking = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        _isReschedulingBooking = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Failed to reschedule booking: $e';
      _isReschedulingBooking = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset provider state
  void reset() {
    _isLoading = false;
    _isCancellingBooking = false;
    _isReschedulingBooking = false;
    _venueBookings = [];
    _tournamentBookings = [];
    _errorMessage = null;
    notifyListeners();
  }
}