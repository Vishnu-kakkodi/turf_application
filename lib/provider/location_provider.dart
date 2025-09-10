// import 'package:booking_application/helper/storage_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:booking_application/services/location_service.dart';

// import 'package:booking_application/modal/location_model.dart';


// class LocationProvider extends ChangeNotifier {
//   final LocationService _locationService = LocationService();
  
//   UserLocation? _currentLocation;
//   List<Turf> _nearbyTurfs = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   bool _locationPermissionGranted = false;

//   // Getters
//   UserLocation? get currentLocation => _currentLocation;
//   List<Turf> get nearbyTurfs => _nearbyTurfs;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   bool get locationPermissionGranted => _locationPermissionGranted;

//   // Get current device location
//   Future<bool> getCurrentLocation() async {
//     _setLoading(true);
//     _clearError();

//     try {
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         _setError('Location services are disabled. Please enable them.');
//         return false;
//       }

//       // Check location permissions
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           _setError('Location permissions are denied');
//           return false;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         _setError('Location permissions are permanently denied');
//         return false;
//       }

//       _locationPermissionGranted = true;

//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       _currentLocation = UserLocation(
//         latitude: position.latitude,
//         longitude: position.longitude,
//         timestamp: DateTime.now(),
//       );

//       notifyListeners();
//       return true;
//     } catch (e) {
//       _setError('Error getting location: $e');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Add user location to server
//   Future<bool> addUserLocation() async {
//     if (_currentLocation == null) {
//       _setError('No location available. Please get current location first.');
//       return false;
//     }

//     _setLoading(true);
//     _clearError();

//     try {
//       final user = await UserPreferences.getUser();
//       if (user == null) {
//         _setError('User not found. Please login again.');
//         return false;
//       }

//       final result = await _locationService.addUserLocation(
//         userId: user.id,
//         latitude: _currentLocation!.latitude,
//         longitude: _currentLocation!.longitude,
//       );

//       if (result['success']) {
//         notifyListeners();
//         return true;
//       } else {
//         _setError(result['message']);
//         return false;
//       }
//     } catch (e) {
//       _setError('Error adding location: $e');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Get nearby turfs
//   // Future<bool> getNearbyTurfs() async {
//   //   _setLoading(true);
//   //   _clearError();

//   //   try {
//   //     final user = await UserPreferences.getUser();
//   //     if (user == null) {
//   //       _setError('User not found. Please login again.');
//   //       return false;
//   //     }

//   //     final result = await _locationService.getNearbyTurfs(user.id);

//   //     if (result['success']) {
//   //       _nearbyTurfs = result['turfs'] ?? [];
//   //       notifyListeners();
//   //       return true;
//   //     } else {
//   //       _setError(result['message']);
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     _setError('Error getting nearby turfs: $e');
//   //     return false;
//   //   } finally {
//   //     _setLoading(false);
//   //   }
//   // }

//   // Update location and get nearby turfs
//   // Future<bool> updateLocationAndGetTurfs() async {
//   //   final locationSuccess = await getCurrentLocation();
//   //   if (!locationSuccess) return false;

//   //   final addLocationSuccess = await addUserLocation();
//   //   if (!addLocationSuccess) return false;

//   //   return await getNearbyTurfs();
//   // }

//   // Calculate distance between two points (in kilometers)
//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
//   }

//   // Set manual location (for testing or manual input)
//   void setManualLocation(double latitude, double longitude) {
//     _currentLocation = UserLocation(
//       latitude: latitude,
//       longitude: longitude,
//       timestamp: DateTime.now(),
//     );
//     notifyListeners();
//   }

//   // Clear nearby turfs
//   void clearNearbyTurfs() {
//     _nearbyTurfs.clear();
//     notifyListeners();
//   }

//   // Private helper methods
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void _setError(String error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   void _clearError() {
//     _errorMessage = null;
//   }

//   // Dispose
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }