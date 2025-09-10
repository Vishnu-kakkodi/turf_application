
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookTournamentSlotServices {
  final String baseUrl='http://31.97.206.144:3081/users/book-turnament-slot';

  Future<Map<String, dynamic>> bookTournamentSlot({
    required String userId,
    required String tournamentId,
    required String date,
    required String timeSlot, 
    String? token,
  }) async {

   // newly added code 
    if (userId.isEmpty || tournamentId.isEmpty || date.isEmpty || timeSlot.isEmpty) {
    return {
      'success': false,
      'message': 'All fields are required',
    };
  }
  

    try {
      final Map<String, dynamic> payload = {
        "userId": userId,
        "tournamentId": tournamentId,
        "date": date,
        "timeSlot": timeSlot, 
      };

      print('Booking payload: $payload'); 

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      print('status code for booking tournament ${response.statusCode}');
      print('response body for booking tournament${response.body}');

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
          'message': errorData['message'] ?? 'Tournament Booking failed',
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