import 'package:booking_application/modal/nearby_turf_model.dart';
import 'package:booking_application/services/nearby_turf_services.dart';
import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  final NearbyTurfServices _nearbyTurfServices = NearbyTurfServices();
  
  List<NearbyTurfModel> _nearbyTurfs = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<NearbyTurfModel> get nearbyTurfs => _nearbyTurfs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch nearby turfs
  Future<void> fetchNearbyTurfs({
    required String userId,
    String category = 'cricket',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _nearbyTurfServices.getNearbyTurfs(
        userId: userId,
        category: category,
      );

      if (response.success) {
        _nearbyTurfs = response.turfs;
        _errorMessage = null;
      } else {
        _nearbyTurfs = [];
        _errorMessage = 'Failed to fetch nearby turfs';
      }
    } catch (e) {
      _nearbyTurfs = [];
      _errorMessage = 'Error: ${e.toString()}';
      debugPrint('Error fetching nearby turfs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear data
  void clearData() {
    _nearbyTurfs = [];
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshNearbyTurfs({
    required String userId,
    String category = 'cricket',
  }) async {
    await fetchNearbyTurfs(userId: userId, category: category);
  }
}