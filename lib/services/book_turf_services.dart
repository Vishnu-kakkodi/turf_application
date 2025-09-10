import 'dart:convert';
import 'package:http/http.dart' as http;

class BookTurfServices {
  final String baseUrl = 'http://31.97.206.144:3081/users/book-turf-slot';

  Future<Map<String, dynamic>> bookTurfSlot({
    required String userId,
    required String turfId,
    required String date,
    required String timeSlot,
    String? token,
  }) async {
    try {
      final Map<String, dynamic> payload = {
        "userId": userId,
        "turfId": turfId,
        "date": date,
        "timeSlot": timeSlot,
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      print('status codeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
      print('response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
          'message': 'Booking successful'
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Booking failed',
          'error': errorData
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'error': e.toString()
      };
    }
  }
}