// services/tournament_service.dart

import 'dart:convert';
import 'package:booking_application/modal/tournament_category_model.dart';
import 'package:http/http.dart' as http;


class TournamentServiceCategory {
  final String baseUrl = 'http://31.97.206.144:3081/turnament/gettournaments';

  // Get tournaments by category
  Future<TournamentResponse> getTournamentsByCategory(String category) async {
    try {
      final url = Uri.parse('$baseUrl?category=$category');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return TournamentResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load tournaments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tournaments: $e');
    }
  }

  // Get tournaments for Football (specific method)
  Future<TournamentResponse> getFootballTournaments() async {
    return getTournamentsByCategory('Football');
  }

  // Get tournaments for other sports
  Future<TournamentResponse> getCricketTournaments() async {
    return getTournamentsByCategory('Cricket');
  }

  Future<TournamentResponse> getBasketballTournaments() async {
    return getTournamentsByCategory('Basketball');
  }

  Future<TournamentResponse> getBadmintonTournaments() async {
    return getTournamentsByCategory('Badminton');
  }

  // Generic method to get tournaments with custom parameters
  Future<TournamentResponse> getTournaments({
    String? category,
    String? location,
    String? date,
  }) async {
    try {
      final Map<String, String> queryParams = {};
      
      if (category != null) queryParams['category'] = category;
      if (location != null) queryParams['location'] = location;
      if (date != null) queryParams['date'] = date;

      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return TournamentResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load tournaments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tournaments: $e');
    }
  }
}