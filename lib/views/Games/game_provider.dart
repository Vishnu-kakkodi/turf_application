import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';


class MatchResponse {
  final bool success;
  final String message;
  final MatchData match;

  MatchResponse({
    required this.success,
    required this.message,
    required this.match,
  });

  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      match: MatchData.fromJson(json['match']),
    );
  }
}

class MatchData {
  final String id;
  final String name;
  final String categoryId;
  final String scoringMethod;
  final String gameMode;
  final List<String> players;
  final List<MatchTeam> teams;
  final String status;
  final String createdBy;

  MatchData({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.scoringMethod,
    required this.gameMode,
    required this.players,
    required this.teams,
    required this.status,
    required this.createdBy,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      categoryId: json['categoryId'] ?? '',
      scoringMethod: json['scoringMethod'] ?? '',
      gameMode: json['gameMode'] ?? '',
      players: List<String>.from(json['players'] ?? []),
      teams: (json['teams'] as List?)
              ?.map((team) => MatchTeam.fromJson(team))
              .toList() ??
          [],
      status: json['status'] ?? 'upcoming',
      createdBy: json['createdBy'] ?? '',
    );
  }
}

class MatchTeam {
  final String teamId;
  final String? teamName;

  MatchTeam({
    required this.teamId,
    this.teamName,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) {
    return MatchTeam(
      teamId: json['teamId'] ?? '',
      teamName: json['teamName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamId': teamId,
      if (teamName != null) 'teamName': teamName,
    };
  }
}

// ============================================================================
// MATCH SERVICE (match_service.dart)
// ============================================================================



class MatchService {
  static const String baseUrl = 'http://31.97.206.144:3081';

  // Create match for single players
  static Future<MatchResponse> createSingleMatch({
    required String userId,
    required String matchName,
    required String categoryId,
    required String scoringMethod,
    required List<String> players,
    String type = 'friendly',
    String? tournamentId,
  }) async {
    try {
      final payload = {
        'name': matchName,
        'categoryId': categoryId,
        'scoringMethod': scoringMethod,
        'gameMode': 'single',
        'players': players,
        'type': type,
        if (tournamentId != null) 'tournamentId': tournamentId,
      };

      print('Creating single match with payload: ${json.encode(payload)}');

      final response = await http.post(
        Uri.parse('$baseUrl/users/creategamematch/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return MatchResponse.fromJson(data);
      } else {
        throw Exception('Failed to create match: ${response.body}');
      }
    } catch (e) {
      print('Error creating single match: $e');
      rethrow;
    }
  }

  // Create match for teams
  static Future<MatchResponse> createTeamMatch({
    required String userId,
    required String matchName,
    required String categoryId,
    required String scoringMethod,
    required List<Map<String, String>> teams,
    String type = 'friendly',
    String? tournamentId,
  }) async {
    try {
      final payload = {
        'name': matchName,
        'categoryId': categoryId,
        'scoringMethod': scoringMethod,
        'gameMode': 'team',
        'teams': teams,
        'type': type,
        if (tournamentId != null) 'tournamentId': tournamentId,
      };

      print('Creating team match with payload: ${json.encode(payload)}');

      final response = await http.post(
        Uri.parse('$baseUrl/users/creategamematch/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return MatchResponse.fromJson(data);
      } else {
        throw Exception('Failed to create match: ${response.body}');
      }
    } catch (e) {
      print('Error creating team match: $e');
      rethrow;
    }
  }
}

// ============================================================================
// UPDATED GAME PROVIDER (game_provider.dart)
// ============================================================================


class GameProvider extends ChangeNotifier {
  final List<MatchData> _matches = [];
  bool _isLoading = false;
  String? _error;

  List<MatchData> get matches => _matches;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<MatchData> get upcomingMatches =>
      _matches.where((match) => match.status == 'upcoming').toList();

  List<MatchData> get liveMatches =>
      _matches.where((match) => match.status == 'live').toList();

  List<MatchData> get completedMatches =>
      _matches.where((match) => match.status == 'completed').toList();

  // Create match with API integration
  Future<String?> createMatch({
    required String userId,
    required String matchName,
    required String categoryId,
    required String scoringMethod,
    required bool isTeamBased,
    List<String>? players,
    List<Team>? teams,
    String type = 'friendly',
    String? tournamentId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      MatchResponse response;

      if (isTeamBased && teams != null && teams.isNotEmpty) {
        // Create team match
        final teamPayload = teams
            .map((team) => {
                  'teamId': team.id,
                })
            .toList();

        response = await MatchService.createTeamMatch(
          userId: userId,
          matchName: matchName,
          categoryId: categoryId,
          scoringMethod: scoringMethod,
          teams: teamPayload,
          type: type,
          tournamentId: tournamentId,
        );
      } else if (players != null && players.isNotEmpty) {
        // Create single match
        response = await MatchService.createSingleMatch(
          userId: userId,
          matchName: matchName,
          categoryId: categoryId,
          scoringMethod: scoringMethod,
          players: players,
          type: type,
          tournamentId: tournamentId,
        );
      } else {
        throw Exception('No players or teams provided');
      }

      // Add match to local list
      _matches.add(response.match);
      _isLoading = false;
      notifyListeners();

      return response.match.id;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      print('Error in createMatch: $e');
      return null;
    }
  }

  void updateMatchStatus(String matchId, String newStatus) {
    final matchIndex = _matches.indexWhere((match) => match.id == matchId);
    if (matchIndex != -1) {
      // Note: Since MatchData is immutable, we need to replace the entire match
      // For now, we'll just update the local list
      notifyListeners();
    }
  }

  MatchData? getMatchById(String matchId) {
    try {
      return _matches.firstWhere((match) => match.id == matchId);
    } catch (e) {
      return null;
    }
  }

  void deleteMatch(String matchId) {
    _matches.removeWhere((match) => match.id == matchId);
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

// Keep the Team class for UI purposes
class Team {
  final String id;
  final String name;
  final List<String> players;

  Team({
    required this.id,
    required this.name,
    required this.players,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'players': players,
      };

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        name: json['name'],
        players: List<String>.from(json['players']),
      );
}