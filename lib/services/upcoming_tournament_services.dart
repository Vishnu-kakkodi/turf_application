import 'dart:convert';
import 'package:booking_application/modal/tournament_model.dart';
import 'package:http/http.dart' as http;

class UpcomingTournamentService {
  final String baseUrl = 'http://31.97.206.144:3081/turnament/getuncomingturnaments';
  
  Future<TournamentResponse> getUpcomingTournaments() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return TournamentResponse.fromJson(data);
      } else {
        return TournamentResponse(
          success: false,
          message: 'Failed to load tournaments. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return TournamentResponse(
        success: false,
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }
}