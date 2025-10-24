// services/team_service.dart
import 'dart:convert';
import 'package:booking_application/views/Games/GameModel/team_model.dart';
import 'package:http/http.dart' as http;

class TeamService {
  final String baseUrl = "http://31.97.206.144:3081"; // replace with backend

  Future<List<Team>> fetchTeams() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Team.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load teams");
    }
  }

  Future<Team> createTeam(Team team) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(team.toJson()),
    );

    if (response.statusCode == 201) {
      return Team.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create team");
    }
  }


    Future<SearchUsersResponse> searchUsers(String searchQuery) async {
    try {
      final url = Uri.parse('$baseUrl/users/searchusers?search=$searchQuery');
            print("Response status code: $url");


      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print("Response status code: ${response.statusCode}");
            print("Response status code: ${response.body}");


      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return SearchUsersResponse.fromJson(jsonResponse);
      } 
      else {
        throw Exception('Failed to search users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching users: $e');
    }
  }
}
