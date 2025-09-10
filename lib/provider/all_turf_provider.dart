// import 'package:booking_application/modal/venue_model.dart';
// import 'package:booking_application/services/all_turf_services.dart';
// import 'package:flutter/material.dart';


// class AllTurfProvider extends ChangeNotifier {
//   final AllTurfServices _service = AllTurfServices();

//   List<VenueModel> _turfs = [];
//   bool _isLoading = false;
//   bool _hasError = false;

//   List<VenueModel> get turfs => _turfs;
//   bool get isLoading => _isLoading;
//   bool get hasError => _hasError;

//   Future<void> loadTurfs() async {
//     _isLoading = true;
//     _hasError = false;
//     notifyListeners();

//     try {
//       _turfs = await _service.fetchAllTurfs();
//     } catch (e) {
//       _hasError = true;
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

















import 'package:booking_application/modal/venue_model.dart';
import 'package:booking_application/services/all_turf_services.dart';
import 'package:flutter/material.dart';

class AllTurfProvider extends ChangeNotifier {
  final AllTurfServices _service = AllTurfServices();

  List<VenueModel> _turfs = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<VenueModel> get turfs => _turfs;
  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;

  Future<void> loadTurfs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _turfs = await _service.fetchAllTurfs();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _turfs = []; // Clear turfs on error
    }

    _isLoading = false;
    notifyListeners();
  }

  // Additional helper methods
  List<VenueModel> getTurfsByLocation(String location) {
    return _turfs.where((turf) => 
        turf.location.toLowerCase().contains(location.toLowerCase())).toList();
  }

  List<VenueModel> getTurfsByPriceRange(int minPrice, int maxPrice) {
    return _turfs.where((turf) => 
        turf.pricePerHour >= minPrice && turf.pricePerHour <= maxPrice).toList();
  }

  VenueModel? getTurfById(String id) {
    try {
      return _turfs.firstWhere((turf) => turf.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get available slots for a specific turf
  List<Slot> getAvailableSlots(String turfId) {
    final turf = getTurfById(turfId);
    if (turf == null) return [];
    
    return turf.slots.where((slot) => !slot.isBooked).toList();
  }

  // Get booked slots for a specific turf
  List<Slot> getBookedSlots(String turfId) {
    final turf = getTurfById(turfId);
    if (turf == null) return [];
    
    return turf.slots.where((slot) => slot.isBooked).toList();
  }

  // Retry loading turfs
  Future<void> retryLoadTurfs() async {
    await loadTurfs();
  }

  // Clear data
  void clearData() {
    _turfs = [];
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
