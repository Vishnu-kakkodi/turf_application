
import 'dart:convert';
import 'package:booking_application/views/Cricket/models/tournament_model.dart';
import 'package:http/http.dart' as http;

class TournamentService {
  static const String baseUrl = 'http://31.97.206.144:3081/users';

  // Create a new tournament
  Future<Map<String, dynamic>> createTournament({
    required String userId,
    required Tournament tournament,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/createtournaments/$userId');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(tournament.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'tournament': Tournament.fromJson(data['tournament']),
          'message': data['message'] ?? 'Tournament created successfully',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to create tournament: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error creating tournament: $e',
      };
    }
  }

  // Get all tournaments
  Future<List<Tournament>> getAllTournaments() async {
    try {
      final url = Uri.parse('$baseUrl/alltournaments');
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> tournamentsJson = data['tournaments'] ?? [];
        return tournamentsJson
            .map((json) => Tournament.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load tournaments');
      }
    } catch (e) {
      print('Error fetching tournaments: $e');
      return [];
    }
  }

  // Get tournaments by status
  Future<List<Tournament>> getTournamentsByStatus(String status) async {
    try {
      final url = Uri.parse('$baseUrl/alltournaments?status=$status');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> tournamentsJson = data['tournaments'] ?? [];
        return tournamentsJson
            .map((json) => Tournament.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load tournaments');
      }
    } catch (e) {
      print('Error fetching tournaments by status: $e');
      return [];
    }
  }

  // Search teams
  Future<Map<String, dynamic>> searchTeams(String query) async {
    try {
      final url = Uri.parse('$baseUrl/allteams?search=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': data['success'] ?? true,
          'teams': data['teams'] ?? [],
          'total': data['total'] ?? 0,
          'message': data['message'] ?? 'Teams fetched successfully',
        };
      } else {
        return {
          'success': false,
          'teams': [],
          'total': 0,
          'message': 'Failed to search teams: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error searching teams: $e');
      return {
        'success': false,
        'teams': [],
        'total': 0,
        'message': 'Error searching teams: $e',
      };
    }
  }

  // Add team to tournament
  Future<Map<String, dynamic>> addTeamToTournament({
    required String userId,
    required String tournamentId,
    required String teamId,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/addteamtournaments/$userId');
      print(url);
      print("TournamnetID: $tournamentId");
            print("TournamnetID: $teamId");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'tournamentId': tournamentId,
          'teamId': teamId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Team added to tournament successfully',
          'data': data,
        };
      } else {
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add team to tournament',
        };
      }
    } catch (e) {
      print('Error adding team to tournament: $e');
      return {
        'success': false,
        'message': 'Error adding team to tournament: $e',
      };
    }
  }

  // Get tournament teams (you may need to add this API endpoint on backend)
 Future<Map<String, dynamic>> getTournamentTeams(String tournamentId) async {
  try {
    final url = Uri.parse('$baseUrl/tournamentsteams/$tournamentId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final tournament = data['tournament'];
      return {
        'success': true,
        'teams': tournament['teams'] ?? [],
        'message': data['message'] ?? 'Teams fetched successfully',
      };
    } else {
      return {
        'success': false,
        'teams': [],
        'message': 'Failed to fetch tournament teams',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'teams': [],
      'message': 'Error fetching tournament teams: $e',
    };
  }
}

}