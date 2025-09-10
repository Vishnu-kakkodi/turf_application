import 'dart:convert';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/modal/location_model.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final String baseUrl = 'http://31.97.206.144:3081';

  // Add user location
  Future<Map<String, dynamic>> addUserLocation({
    required String userId,
    required double latitude,
    required double longitude,
  }) async {
    try {

      
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$latitude');
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$longitude');
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$userId');

      final token = await UserPreferences.getToken();
      
      final response = await http.put(
        Uri.parse('$baseUrl/users/addlocation/$userId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'latitude': latitude,
          'longitude': longitude,
        }),
      );


      print('melvinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${response.statusCode}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to add location: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error adding location: $e',
      };
    }
  }

  // Get nearby turfs
  // Future<Map<String, dynamic>> getNearbyTurfs(String userId) async {
  //   try {
  //     final token = await UserPreferences.getToken();
      
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/users/nearby-turfs/$userId'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         if (token != null) 'Authorization': 'Bearer $token',
  //       },
  //     );

  //    print('dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${response.statusCode}');

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
        
  //       // Parse turfs from response
  //       List<Turf> turfs = [];
  //       if (data['success'] == true && data['turfs'] != null) {
  //         turfs = (data['turfs'] as List)
  //             .map((turfJson) => Turf.fromJson(turfJson))
  //             .toList();
  //       }

  //       return {
  //         'success': true,
  //         'turfs': turfs,
  //         'data': data,
  //       };
  //     } else {
  //       return {
  //         'success': false,
  //         'message': 'Failed to get nearby turfs: ${response.statusCode}',
  //         'turfs': <Turf>[],
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'message': 'Error getting nearby turfs: $e',
  //       'turfs': <Turf>[],
  //     };
  //   }
  // }
}