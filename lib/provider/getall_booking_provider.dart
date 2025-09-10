// providers/get_all_booking_provider.dart
import 'package:booking_application/modal/getall_booking_model.dart';
import 'package:booking_application/services/getall_booking_service.dart';
import 'package:flutter/material.dart';


class GetAllBookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();
  
  // State variables
  List<TurfBooking> _turfBookings = [];
  List<TournamentBooking> _tournamentBookings = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<TurfBooking> get turfBookings => _turfBookings;
  List<TournamentBooking> get tournamentBookings => _tournamentBookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Fetch turf bookings
  Future<void> fetchTurfBookings(String userId) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final response = await _bookingService.getMyTurfBookings();
      
      if (response.success && response.turfBookings != null) {
        _turfBookings = response.turfBookings!;
        _setError(null);
      } else {
        _turfBookings = [];
        _setError(response.message ?? 'Failed to fetch turf bookings');
      }
    } catch (e) {
      _turfBookings = [];
      _setError('Failed to fetch turf bookings: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Fetch tournament bookings
  Future<void> fetchTournamentBookings(String userId) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final response = await _bookingService.getMyTournamentBookings();
      
      if (response.success && response.tournamentBookings != null) {
        _tournamentBookings = response.tournamentBookings!;
        _setError(null);
      } else {
        _tournamentBookings = [];
        _setError(response.message ?? 'Failed to fetch tournament bookings');
      }
    } catch (e) {
      _tournamentBookings = [];
      _setError('Failed to fetch tournament bookings: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Fetch both types of bookings
  Future<void> fetchAllBookings(String userId) async {
    try {
      _setLoading(true);
      _setError(null);
      
      // Fetch both simultaneously
      await Future.wait([
        fetchTurfBookings(userId),
        fetchTournamentBookings(userId),
      ]);
    } catch (e) {
      _setError('Failed to fetch bookings: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Cancel turf booking
  Future<bool> cancelTurfBooking(String bookingId) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final response = await _bookingService.cancelTurfBooking(bookingId);
      
      if (response.success) {
        // Remove the cancelled booking from the list
        _turfBookings.removeWhere((booking) => booking.bookingId == bookingId);
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Failed to cancel booking');
        return false;
      }
    } catch (e) {
      _setError('Failed to cancel booking: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Cancel tournament booking
  Future<bool> cancelTournamentBooking(String bookingId) async {
    try {
      _setLoading(true);
      _setError(null);
      
      final response = await _bookingService.cancelTournamentBooking(bookingId);
      
      if (response.success) {
        // Remove the cancelled booking from the list
        _tournamentBookings.removeWhere((booking) => booking.bookingId == bookingId);
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Failed to cancel tournament booking');
        return false;
      }
    } catch (e) {
      _setError('Failed to cancel tournament booking: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Refresh turf bookings
  Future<void> refreshTurfBookings(String userId) async {
    await fetchTurfBookings(userId);
  }

  // Refresh tournament bookings
  Future<void> refreshTournamentBookings(String userId) async {
    await fetchTournamentBookings(userId);
  }

  // Refresh all bookings
  Future<void> refreshAllBookings(String userId) async {
    await fetchAllBookings(userId);
  }

  // Clear all data
  void clearAllData() {
    _turfBookings = [];
    _tournamentBookings = [];
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  // Get turf booking by ID
  TurfBooking? getTurfBookingById(String bookingId) {
    try {
      return _turfBookings.firstWhere((booking) => booking.bookingId == bookingId);
    } catch (e) {
      return null;
    }
  }

  // Get tournament booking by ID
  TournamentBooking? getTournamentBookingById(String bookingId) {
    try {
      return _tournamentBookings.firstWhere((booking) => booking.bookingId == bookingId);
    } catch (e) {
      return null;
    }
  }

  // Get bookings by status
  List<TurfBooking> getTurfBookingsByStatus(String status) {
    return _turfBookings.where((booking) => 
        booking.status.toLowerCase() == status.toLowerCase()).toList();
  }

  List<TournamentBooking> getTournamentBookingsByStatus(String status) {
    return _tournamentBookings.where((booking) => 
        booking.status.toLowerCase() == status.toLowerCase()).toList();
  }

  // Get recent bookings (last 10)
  List<TurfBooking> getRecentTurfBookings() {
    final sortedBookings = List<TurfBooking>.from(_turfBookings);
    sortedBookings.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
    return sortedBookings.take(10).toList();
  }

  List<TournamentBooking> getRecentTournamentBookings() {
    final sortedBookings = List<TournamentBooking>.from(_tournamentBookings);
    sortedBookings.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
    return sortedBookings.take(10).toList();
  }
}