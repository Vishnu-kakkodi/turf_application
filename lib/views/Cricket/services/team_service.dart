// services/team_service.dart

import 'dart:convert';
import 'package:booking_application/views/Cricket/models/get_all_teams_model.dart';
import 'package:booking_application/views/Cricket/models/team_model.dart';
import 'package:http/http.dart' as http;

class TeamService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  // Create Team
  Future<CreateTeamResponse> createTeam({
    required String userId,
    required String teamName,
    required List<String> playerNames,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/users/createteams/$userId');

      final body = {
        'teamName': teamName,
        'players': playerNames, // ✅ Just a list of strings
      };

      // Debug prints
      print('API URL: $url');
      print('Team Name: $teamName');
      print('Request Body: ${jsonEncode(body)}'); // Pretty JSON format

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return CreateTeamResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to create team: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating team: $e');
    }
  }

  // Search Users
  Future<SearchUsersResponse> searchUsers(String searchQuery) async {
    try {
      final url = Uri.parse('$baseUrl/users/searchusers?search=$searchQuery');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
                print("kkkkkkkkkkkkkkkkkkkkkkk${response.body}");

        return SearchUsersResponse.fromJson(jsonResponse);
      } else {
        final jsonResponse = jsonDecode(response.body);
        print("kkkkkkkkkkkkkkkkkkkkkkk${response.body}");
        return SearchUsersResponse.fromJson(jsonResponse);
      }
    } catch (e) {
      throw Exception('Error searching users: $e');
    }
  }

  Future<GetAllTeamsResponse> getAllTeams() async {
    try {
      final url = Uri.parse('$baseUrl/users/allteams');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return GetAllTeamsResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch teams: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching teams: $e');
    }
  }
}
