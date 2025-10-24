// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = 'http://31.97.206.144:3081';
  
//   // Get single match by ID
//   static Future<Map<String, dynamic>> getSingleMatch(String matchId) async {
//     try {
//       print("Match Iddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd: $matchId");
//       final response = await http.get(
//         Uri.parse('$baseUrl/users/getsinglematch/$matchId'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to load match: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching match: $e');
//     }
//   }

//   // Update match score
//   // static Future<Map<String, dynamic>> updateMatch(
//   //   String matchId, 
//   //   Map<String, dynamic> payload
//   // ) async {
//   //   try {
//   //     final response = await http.put(
//   //       Uri.parse('$baseUrl/users/updatematch/$matchId'),
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: json.encode(payload),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       return json.decode(response.body);
//   //     } else {
//   //       throw Exception('Failed to update match: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     throw Exception('Error updating match: $e');
//   //   }
//   // }


//   static Future<Map<String, dynamic>> updateMatch(
//   String matchId, 
//   Map<String, dynamic> payload
// ) async {
//   try {
//     // ✅ Print payload before API call
//     print("Updating match: $matchId");
//     print("Payload: ${jsonEncode(payload)}");

//     final response = await http.put(
//       Uri.parse('$baseUrl/users/updatematch/$matchId'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(payload),
//     );
//         print("Updating match Responseeee: ${response.statusCode}");
//                 print("Updating match Responseeee: ${response.body}");



//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to update match: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error updating match: $e');
//   }
// }

// }








import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  // ===========================
  // Custom SnackBar Helper
  // ===========================
  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1976D2),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1200),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ===========================
  // Get Single Match by ID
  // ===========================
  static Future<Map<String, dynamic>?> getSingleMatch(
      BuildContext context, String matchId) async {
    try {
      print("Fetching match ID: $matchId");
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsinglematch/$matchId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else if (response.statusCode == 404) {
        _showSnackBar(context, 'Match not found');
        return null;
      } else {
        _showSnackBar(context, 'Failed to load match (${response.statusCode})');
        return null;
      }
    } catch (e) {
      _showSnackBar(context, 'Error fetching match: $e');
      return null;
    }
  }

  // ===========================
  // Update Match
  // ===========================
  static Future<Map<String, dynamic>?> updateMatch(
    BuildContext context,
    String matchId,
    Map<String, dynamic> payload,
  ) async {
    try {
      print("Updating match ID: $matchId");
      print("Payload: ${jsonEncode(payload)}");

      final response = await http.put(
        Uri.parse('$baseUrl/users/updatematch/$matchId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print("Update match response code: ${response.statusCode}");
      print("Update match response body: ${response.body}");

      final jsonResponse = json.decode(response.body);

      // Handle success/failure based on API response
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == false) {
          _showSnackBar(context, jsonResponse['message'] ?? 'Something went wrong');
          return jsonResponse;
        } else {
          _showSnackBar(context, 'Match updated successfully');
          return jsonResponse;
        }
      } else {
        _showSnackBar(context, jsonResponse['message'] ?? 'Something went wrong');
        return jsonResponse;
      }
    } catch (e) {
      _showSnackBar(context, 'Error updating match: $e');
      return null;
    }
  }
}
