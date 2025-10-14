import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://31.97.206.144:3081';
  
  // Get single match by ID
  static Future<Map<String, dynamic>> getSingleMatch(String matchId) async {
    try {
      print("Match Iddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd: $matchId");
      final response = await http.get(
        Uri.parse('$baseUrl/users/getsinglematch/$matchId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load match: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching match: $e');
    }
  }

  // Update match score
  // static Future<Map<String, dynamic>> updateMatch(
  //   String matchId, 
  //   Map<String, dynamic> payload
  // ) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse('$baseUrl/users/updatematch/$matchId'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(payload),
  //     );

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     } else {
  //       throw Exception('Failed to update match: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error updating match: $e');
  //   }
  // }


  static Future<Map<String, dynamic>> updateMatch(
  String matchId, 
  Map<String, dynamic> payload
) async {
  try {
    // ✅ Print payload before API call
    print("Updating match: $matchId");
    print("Payload: ${jsonEncode(payload)}");

    final response = await http.put(
      Uri.parse('$baseUrl/users/updatematch/$matchId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );
        print("Updating match Responseeee: ${response.statusCode}");


    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update match: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error updating match: $e');
  }
}

}