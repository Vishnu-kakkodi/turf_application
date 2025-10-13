// lib/providers/location_provider.dart

import 'package:booking_application/services/LocationService/location_fetch_service.dart';
import 'package:booking_application/services/LocationService/location_service.dart';
import 'package:flutter/foundation.dart';


class LocationFetchProvider extends ChangeNotifier {
  String _address = 'Fetching location...';
  List<double>? _coordinates;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  // Getters
  String get address => _address;
  List<double>? get coordinates => _coordinates;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  bool get hasLocation => _coordinates != null && _coordinates!.length >= 2;

  // Initialize location (get current location)
  Future<void> initLocation(String userId) async {
    try {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
      notifyListeners();

      // Get coordinates first
      final coords = await LocationFetchService.getCurrentCoordinates();
      if (coords == null) {
        throw Exception('Failed to get coordinates');
      }
      _coordinates = coords;

      // Get address
      final fullAddress = await LocationFetchService.getCurrentAddress();
      if (fullAddress == null) {
        throw Exception('Failed to get address');
      }

      // Check if address contains error messages
      if (fullAddress.contains('Location services are disabled') ||
          fullAddress.contains('Location permission denied') ||
          fullAddress.contains('permanently denied') ||
          fullAddress.contains('Address not found')) {
        throw Exception(fullAddress);
      }

      _address = _formatAddress(fullAddress);
      
      // Call addLocation API with user's coordinates
      final isSuccess = await LocationService().addLocation(
        userId, 
        _coordinates![0].toString(), // latitude
        _coordinates![1].toString()  // longitude
      );
      
      if (!isSuccess) {
        if (kDebugMode) {
          print('Warning: Failed to save location to server');
        }
        // Note: We don't throw an error here as the location was still fetched successfully
        // The API call failure shouldn't prevent the user from using the app
      }

      _isLoading = false;
      _hasError = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = e.toString();
      _address = 'Location not available';
      _coordinates = null;
      notifyListeners();
    }
  }

  // Update location manually (from search)
  Future<void> updateLocation(String newAddress, List<double> newCoordinates, String userId) async {
    _address = _formatAddress(newAddress);
    _coordinates = newCoordinates;
    _isLoading = false;
    _hasError = false;
    _errorMessage = '';
          final isSuccess = await LocationService().addLocation(
        userId, 
        _coordinates![0].toString(), // latitude
        _coordinates![1].toString()  // longitude
      );
    notifyListeners();
  }

  // Format address to show only first 2 parts
  String _formatAddress(String fullAddress) {
    if (fullAddress.isEmpty) return 'Unknown location';
    
    final parts = fullAddress.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'Unknown location';
    
    return parts.length > 1 ? '${parts[0]}, ${parts[1]}' : parts[0];  
  }

  // Refresh current location
  Future<void> refreshLocation() async {
    final userId = '68da44599d96d329b6169526';
    await initLocation(userId.toString());
  }

  // Reset location state
  void resetLocation() {
    _address = 'Fetching location...';
    _coordinates = null;
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }
}