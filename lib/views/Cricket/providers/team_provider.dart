// providers/team_provider.dart

import 'package:booking_application/views/Cricket/models/team_model.dart';
import 'package:booking_application/views/Cricket/services/team_service.dart';
import 'package:flutter/material.dart';

import 'package:booking_application/views/Cricket/models/get_all_teams_model.dart';

class TeamNewProvider with ChangeNotifier {
  final TeamService _teamService = TeamService();

  bool _isCreatingTeam = false;
  bool get isCreatingTeam => _isCreatingTeam;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Team? _createdTeam;
  Team? get createdTeam => _createdTeam;

  List<Teams> _allTeams = [];
  List<Teams> get allTeams => _allTeams;

  bool _isFetchingTeams = false;
  bool get isFetchingTeams => _isFetchingTeams;

  // Create Team
  Future<bool> createTeam({
    required String userId,
    required String teamName,
    required List<String> playerNames,
  }) async {
    _isCreatingTeam = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _teamService.createTeam(
        userId: userId,
        teamName: teamName,
        playerNames: playerNames,
      );

      _createdTeam = response.team;
      _isCreatingTeam = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isCreatingTeam = false;
      notifyListeners();
      return false;
    }
  }

  // Get All Teams
  Future<void> fetchAllTeams() async {
    _isFetchingTeams = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _teamService.getAllTeams();
      _allTeams = response.teams;
      _isFetchingTeams = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isFetchingTeams = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearTeam() {
    _createdTeam = null;
    notifyListeners();
  }
}
