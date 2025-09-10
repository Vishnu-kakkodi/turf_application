import 'dart:convert';
import 'package:booking_application/modal/nearby_turf_model.dart';
import 'package:http/http.dart' as http;

class NearbyTurfServices {
  final String baseUrl = 'http://31.97.206.144:3081/users/nearby-turfs';
  
  Future<NearbyTurfsResponse> getNearbyTurfs({
    required String userId,
    String category = 'cricket',
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$userId?category=$category');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return NearbyTurfsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load nearby turfs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching nearby turfs: $e');
    }
  }
}