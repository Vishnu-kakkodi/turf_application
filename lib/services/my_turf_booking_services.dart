import 'dart:convert';
import 'package:http/http.dart' as http;

class MyTurfBookingServices {
  final String baseUrl = 'http://31.97.206.144:3081/users/myturfbookings';

  // Get turf bookings for a specific user
  Future<Map<String, dynamic>> getMyTurfBookings(String userId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/$userId');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch bookings: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Cancel a booking
  Future<Map<String, dynamic>> cancelBooking(String bookingId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/cancel/$bookingId');
      
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to cancel booking: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Reschedule a booking
  Future<Map<String, dynamic>> rescheduleBooking(
    String bookingId, 
    String newDate, 
    String newTimeSlot, 
    String token
  ) async {
    try {
      final url = Uri.parse('$baseUrl/reschedule/$bookingId');
      
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'newDate': newDate,
          'newTimeSlot': newTimeSlot,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to reschedule booking: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
}