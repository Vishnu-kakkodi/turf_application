// provider/match_game_provider.dart
import 'package:booking_application/modal/single_match_model.dart';
import 'package:booking_application/services/single_match_service.dart';
import 'package:flutter/material.dart';

class SingleMatchGameProvider extends ChangeNotifier {
  // Match data
  MatchData? _matchData;
  bool _isLoading = false;
  String? _error;

  // Toss data
  String? _tossWinner;
  String? _electedTo;

  // Player selections
  String? _striker;
  String? _nonStriker;
  String? _bowler;
  String? _bowlingStyle;
  String? _overs;


  // Selected teams (IDs)
  String? _battingTeamId;
  String? _bowlingTeamId;

  // Getters
  MatchData? get matchData => _matchData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get tossWinner => _tossWinner;
  String? get electedTo => _electedTo;
  String? get striker => _striker;
  String? get nonStriker => _nonStriker;
  String? get bowler => _bowler;
  String? get overs => _overs;
  String? get bowlingStyle => _bowlingStyle;

  // Get team names for dropdown
  List<String> getTeamNames() {
    if (_matchData == null) return [];
    return _matchData!.teams.map((team) => team.teamName).toList();
  }

  // Get team ID by name
  String? getTeamIdByName(String teamName) {
    if (_matchData == null) return null;
    final team = _matchData!.teams.firstWhere(
      (team) => team.teamName == teamName,
      orElse: () => TeamData(
        id: '',
        teamName: '',
        categoryId: '',
        tournamentId: '',
        players: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    return team.id.isEmpty ? null : team.id;
  }

  // Get batting team players
  List<PlayerData> getBattingTeamPlayers() {
    if (_matchData == null || _battingTeamId == null) return [];
    final team = _matchData!.teams.firstWhere(
      (team) => team.id == _battingTeamId,
      orElse: () => TeamData(
        id: '',
        teamName: '',
        categoryId: '',
        tournamentId: '',
        players: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    return team.players;
  }

  // Get bowling team players
  List<PlayerData> getBowlingTeamPlayers() {
    if (_matchData == null || _bowlingTeamId == null) return [];
    final team = _matchData!.teams.firstWhere(
      (team) => team.id == _bowlingTeamId,
      orElse: () => TeamData(
        id: '',
        teamName: '',
        categoryId: '',
        tournamentId: '',
        players: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    return team.players;
  }

  // Load match data
  Future<void> loadMatchData(String userId, String matchId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await MatchService.getSingleMatch(userId, matchId);
      _matchData = response.match;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _matchData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set toss winner and determine batting/bowling teams
  void setTossWinner(String teamName) {
    _tossWinner = teamName;
    _updateTeamRoles();
    notifyListeners();
  }

  // Set elected to (Bat/Bowl)
  void setElectedTo(String elected) {
    _electedTo = elected;
    _updateTeamRoles();
    notifyListeners();
  }

  // Update team roles based on toss winner and election
  void _updateTeamRoles() {
    if (_tossWinner == null || _electedTo == null || _matchData == null) return;

    final tossWinnerTeamId = getTeamIdByName(_tossWinner!);
    if (tossWinnerTeamId == null) return;

    if (_electedTo == 'Bat') {
      _battingTeamId = tossWinnerTeamId;
      _bowlingTeamId = _matchData!.teams
          .firstWhere((team) => team.id != tossWinnerTeamId)
          .id;
    } else {
      _bowlingTeamId = tossWinnerTeamId;
      _battingTeamId = _matchData!.teams
          .firstWhere((team) => team.id != tossWinnerTeamId)
          .id;
    }

    // Reset player selections when team roles change
    _striker = null;
    _nonStriker = null;
    _bowler = null;
    _bowlingStyle = null;
  }

  // Set opening batsmen
  void setOpeningBatsmen(String striker, String nonStriker) {
    _striker = striker;
    _nonStriker = nonStriker;
    notifyListeners();
  }

  // Set bowler
  void setBowler(String bowler, String bowlingStyle) {
    _bowler = bowler;
    _bowlingStyle = bowlingStyle;
    notifyListeners();
  }

  void setOvers(String value) {
  _overs = value;
  notifyListeners();
}

  // Get player ID by name from a specific team
  String? getPlayerIdByName(String playerName, String teamId) {
    if (_matchData == null) return null;
    
    final team = _matchData!.teams.firstWhere(
      (team) => team.id == teamId,
      orElse: () => TeamData(
        id: '',
        teamName: '',
        categoryId: '',
        tournamentId: '',
        players: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    
    final player = team.players.firstWhere(
      (player) => player.name == playerName,
      orElse: () => PlayerData(
        id: '',
        name: '',
        role: '',
        subRole: '',
        designation: '',
      ),
    );
    
    return player.id.isEmpty ? null : player.id;
  }

  // Start match
  Future<bool> startMatch(String userId, String matchId) async {
    if (!canStartMatch()) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final tossWinnerTeamId = getTeamIdByName(_tossWinner!)!;
      final strikerPlayerId = getPlayerIdByName(_striker!, _battingTeamId!)!;
      final nonStrikerPlayerId = getPlayerIdByName(_nonStriker!, _battingTeamId!)!;
      final bowlerPlayerId = getPlayerIdByName(_bowler!, _bowlingTeamId!)!;

      final request = StartMatchRequest(
        tossWinner: tossWinnerTeamId,
        electedTo: _electedTo!,
        striker: strikerPlayerId,
        nonStriker: nonStrikerPlayerId,
        bowler: bowlerPlayerId,
        bowlingStyle: _bowlingStyle!,
        over: _overs!, // Default to 20 overs if not specified
      );

      await MatchService.startMatch(userId, matchId, request);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Check if all required data is available to start match
  bool canStartMatch() {
    return _tossWinner != null &&
        _electedTo != null &&
        _striker != null &&
        _nonStriker != null &&
        _bowler != null &&
        _bowlingStyle != null;
  }

  // Clear all data
  void clearData() {
    _matchData = null;
    _tossWinner = null;
    _electedTo = null;
    _striker = null;
    _nonStriker = null;
    _bowler = null;
    _bowlingStyle = null;
    _battingTeamId = null;
    _bowlingTeamId = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}