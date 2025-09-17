// services/match_service.dart
import 'dart:convert';
import 'package:booking_application/modal/single_match_model.dart';
import 'package:http/http.dart' as http;

class MatchService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  // Get single match details
  static Future<MatchResponse> getSingleMatch(String userId, String matchId) async {
    try {
            print("Match Printing: $matchId");
      final url = Uri.parse('$baseUrl/users/singlematch/$userId/$matchId');
            print("Url Printing: $url");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MatchResponse.fromJson(data);
      } else {
        throw Exception('Failed to load match: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching match: $e');
    }
  }

  // Start match
  static Future<Map<String, dynamic>> startMatch(
    String userId, 
    String matchId, 
    StartMatchRequest request
  ) async {
    try {
      print("UserId Printing: $userId");
      print("Match Printing: $matchId");
            print("Match Printing: ${request.over}");


      final url = Uri.parse('$baseUrl/users/startmatch/$userId/$matchId');
      print("Url Printing: $url");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      print("Response Printing: ${response.body}");


      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to start match: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error starting match: $e');
    }
  }
}