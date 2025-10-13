import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  Future<bool> addLocation(String userId, String latitude, String longitude) async {
    try {
      print('📍 Adding location for user: $userId');
      print('➡️ Latitude: $latitude, Longitude: $longitude');

      final response = await http.post(
        Uri.parse("http://194.164.148.244:4062/api/users/add-location"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': "68da44599d96d329b6169526",
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      print('🛰️ Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      } else {
        print('❌ Failed to add location. Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('🚨 Error adding location: $e');
      return false;
    }
  }
}
