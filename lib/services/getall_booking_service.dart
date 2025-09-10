// // services/booking_service.dart
// import 'dart:convert';
// import 'package:booking_application/modal/getall_booking_model.dart';
// import 'package:http/http.dart' as http;

// class BookingService {
//   static const String baseUrl = 'http://31.97.206.144:3081/users';
  
//   // Get user's turf bookings
//   Future<BookingResponse> getMyTurfBookings(String userId) async {
//     try {
//       final url = Uri.parse('$baseUrl/myturfbookings/$userId');
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );



//       print('response status codeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
//       print('Response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return BookingResponse.fromTurfJson(data);
//       } else {
//         return BookingResponse(
//           success: false,
//           message: 'Failed to fetch turf bookings: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return BookingResponse(
//         success: false,
//         message: 'Network error: ${e.toString()}',
//       );
//     }
//   }

//   // Get user's tournament bookings
//   Future<BookingResponse> getMyTournamentBookings(String userId) async {
//     try {
//       final url = Uri.parse('$baseUrl/mytournamentbookings/$userId');

//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );


//       print('response status codeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
//       print('Response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return BookingResponse.fromTournamentJson(data);
//       } else {
//         return BookingResponse(
//           success: false,
//           message: 'Failed to fetch tournament bookings: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return BookingResponse(
//         success: false,
//         message: 'Network error: ${e.toString()}',
//       );
//     }
//   }

//   // Cancel turf booking
//   Future<BookingResponse> cancelTurfBooking(String bookingId) async {
//     try {
//       final url = Uri.parse('$baseUrl/cancelturfbooking/$bookingId');
//       final response = await http.delete(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return BookingResponse(
//           success: data['success'] ?? false,
//           message: data['message'],
//         );
//       } else {
//         return BookingResponse(
//           success: false,
//           message: 'Failed to cancel booking: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return BookingResponse(
//         success: false,
//         message: 'Network error: ${e.toString()}',
//       );
//     }
//   }

//   // Cancel tournament booking
//   Future<BookingResponse> cancelTournamentBooking(String bookingId) async {
//     try {
//       final url = Uri.parse('$baseUrl/canceltournamentbooking/$bookingId');
//       final response = await http.delete(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return BookingResponse(
//           success: data['success'] ?? false,
//           message: data['message'],
//         );
//       } else {
//         return BookingResponse(
//           success: false,
//           message: 'Failed to cancel tournament booking: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return BookingResponse(
//         success: false,
//         message: 'Network error: ${e.toString()}',
//       );
//     }
//   }
// }



















// services/booking_service.dart
import 'dart:convert';
import 'package:booking_application/helper/storage_helper.dart';
import 'package:booking_application/modal/getall_booking_model.dart';
import 'package:http/http.dart' as http;

class BookingService {
  static const String baseUrl = 'http://31.97.206.144:3081/users';
  
  // Helper method to get userId from UserPreferences
  Future<String?> _getUserId() async {
    final user = await UserPreferences.getUser();
    return user?.id; // Assuming User model has an 'id' field
  }
  
  // Get user's turf bookings (no userId parameter needed)
  Future<BookingResponse> getMyTurfBookings() async {
    try {
      final userId = await _getUserId();
      if (userId == null) {
        return BookingResponse(
          success: false,
          message: 'User not logged in',
        );
      }

      final url = Uri.parse('$baseUrl/myturfbookings/$userId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('response status codeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
      print('Response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BookingResponse.fromTurfJson(data);
      } else {
        return BookingResponse(
          success: false,
          message: 'Failed to fetch turf bookings: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Get user's tournament bookings (no userId parameter needed)
  Future<BookingResponse> getMyTournamentBookings() async {
    try {
      final userId = await _getUserId();
      if (userId == null) {
        return BookingResponse(
          success: false,
          message: 'User not logged in',
        );
      }

      final url = Uri.parse('$baseUrl/mytournamentbookings/$userId');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('response status codeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
      print('Response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BookingResponse.fromTournamentJson(data);
      } else {
        return BookingResponse(
          success: false,
          message: 'Failed to fetch tournament bookings: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Alternative: Keep the original methods with userId parameter for flexibility
  Future<BookingResponse> getMyTurfBookingsWithUserId(String userId) async {
    try {
      final url = Uri.parse('$baseUrl/myturfbookings/$userId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('response status codeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
      print('Response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BookingResponse.fromTurfJson(data);
      } else {
        return BookingResponse(
          success: false,
          message: 'Failed to fetch turf bookings: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  Future<BookingResponse> getMyTournamentBookingsWithUserId(String userId) async {
    try {
      final url = Uri.parse('$baseUrl/mytournamentbookings/$userId');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('response status codeeeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
      print('Response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BookingResponse.fromTournamentJson(data);
      } else {
        return BookingResponse(
          success: false,
          message: 'Failed to fetch tournament bookings: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Cancel turf booking
  Future<BookingResponse> cancelTurfBooking(String bookingId) async {
    try {
      final url = Uri.parse('$baseUrl/cancelturfbooking/$bookingId');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BookingResponse(
          success: data['success'] ?? false,
          message: data['message'],
        );
      } else {
        return BookingResponse(
          success: false,
          message: 'Failed to cancel booking: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Cancel tournament booking
  Future<BookingResponse> cancelTournamentBooking(String bookingId) async {
    try {
      final url = Uri.parse('$baseUrl/canceltournamentbooking/$bookingId');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BookingResponse(
          success: data['success'] ?? false,
          message: data['message'],
        );
      } else {
        return BookingResponse(
          success: false,
          message: 'Failed to cancel tournament booking: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BookingResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}