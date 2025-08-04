// services/single_tournament_service.dart
import 'dart:convert';
import 'package:booking_application/modal/tournament_model_tabbar.dart';
import 'package:http/http.dart' as http;

class SingleTournamentServices {
  final String baseUrl = 'http://31.97.206.144:3081/turnament/singletournament';

  Future<Tournament> fetchSingleTournament(String tournamentId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$tournamentId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Tournament.fromJson(data);
      } else {
        throw Exception('Failed to load tournament: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tournament: $e');
    }
  }
}