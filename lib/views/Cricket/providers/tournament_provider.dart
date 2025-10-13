// // tournament_provider.dart

// import 'package:booking_application/views/Cricket/models/tournament_model.dart';
// import 'package:booking_application/views/Cricket/services/tournament_service.dart';
// import 'package:flutter/foundation.dart';

// class TournamentNewProvider extends ChangeNotifier {
//   final TournamentService _service = TournamentService();
//   List<Tournament> _tournaments = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   List<Tournament> get tournaments => _tournaments;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;

//   // Get tournaments by status
//   List<Tournament> get registrationOpenTournaments {
//     return _tournaments
//         .where((t) => t.tournamentStatus == TournamentStatus.registrationOpen)
//         .toList();
//   }

//   List<Tournament> get liveTournaments {
//     return _tournaments
//         .where((t) => t.tournamentStatus == TournamentStatus.live)
//         .toList();
//   }

//   List<Tournament> get completedTournaments {
//     return _tournaments
//         .where((t) => t.tournamentStatus == TournamentStatus.completed)
//         .toList();
//   }

//   // Fetch all tournaments
//   Future<void> fetchTournaments() async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();

//     try {
//       _tournaments = await _service.getAllTournaments();
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _errorMessage = 'Failed to fetch tournaments: $e';
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Create a new tournament
//   Future<bool> createTournament({
//     required String userId,
//     required String name,
//     required String description,
//     required DateTime startDate,
//     required DateTime endDate,
//     required DateTime registrationEndDate,
//     required double lat,
//     required double lng,
//     required int numberOfTeams,
//     required String format,
//     required bool isPaidEntry,
//     double? entryFee,
//     required String locationName,
//     String? rules,
//     String? prizes,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final tournament = Tournament(
//         id: '',
//         name: name,
//         description: description,
//         startDate: startDate,
//         endDate: endDate,
//         registrationEndDate: registrationEndDate,
//         location: TournamentLocation(lat: lat, lng: lng),
//         numberOfTeams: numberOfTeams,
//         format: format,
//         tournamentType: isPaidEntry ? 'paid' : 'free',
//         price: isPaidEntry ? entryFee : null,
//         locationName: locationName,
//         rules: rules,
//         prizes: prizes,
//         createdBy: userId,
//         status: 'upcoming',
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );

//       final result = await _service.createTournament(
//         userId: userId,
//         tournament: tournament,
//       );

//       if (result['success'] == true) {
//         // Refresh tournaments list
//         await fetchTournaments();
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _errorMessage = result['message'] ?? 'Failed to create tournament';
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = 'Error creating tournament: $e';
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Fetch tournaments by status
//   Future<void> fetchTournamentsByStatus(String status) async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();

//     try {
//       _tournaments = await _service.getTournamentsByStatus(status);
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _errorMessage = 'Failed to fetch tournaments: $e';
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }






















import 'package:booking_application/views/Cricket/models/tournament_model.dart';
import 'package:booking_application/views/Cricket/models/team_model.dart';
import 'package:booking_application/views/Cricket/services/tournament_service.dart';
import 'package:flutter/foundation.dart';

class TournamentNewProvider extends ChangeNotifier {
  final TournamentService _service = TournamentService();
  List<Tournament> _tournaments = [];
  bool _isLoading = false;
  bool _isLoadingTeams = false;
  String _errorMessage = '';
  
  // Store teams for each tournament
  Map<String, List<Team>> _tournamentTeams = {};

  List<Tournament> get tournaments => _tournaments;
  bool get isLoading => _isLoading;
  bool get isLoadingTeams => _isLoadingTeams;
  String get errorMessage => _errorMessage;
  Map<String, List<Team>> get tournamentTeams => _tournamentTeams;

  // Get tournaments by status
  List<Tournament> get registrationOpenTournaments {
    return _tournaments
        .where((t) => t.tournamentStatus == TournamentStatus.registrationOpen)
        .toList();
  }

  List<Tournament> get liveTournaments {
    return _tournaments
        .where((t) => t.tournamentStatus == TournamentStatus.live)
        .toList();
  }

  List<Tournament> get completedTournaments {
    return _tournaments
        .where((t) => t.tournamentStatus == TournamentStatus.completed)
        .toList();
  }

  // Fetch all tournaments
  Future<void> fetchTournaments() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _tournaments = await _service.getAllTournaments();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch tournaments: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a new tournament
  Future<bool> createTournament({
    required String userId,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime registrationEndDate,
    required double lat,
    required double lng,
    required int numberOfTeams,
    required String format,
    required bool isPaidEntry,
    double? entryFee,
    required String locationName,
    String? rules,
    String? prizes,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final tournament = Tournament(
        id: '',
        name: name,
        description: description,
        startDate: startDate,
        endDate: endDate,
        registrationEndDate: registrationEndDate,
        location: TournamentLocation(lat: lat, lng: lng),
        numberOfTeams: numberOfTeams,
        format: format,
        tournamentType: isPaidEntry ? 'paid' : 'free',
        price: isPaidEntry ? entryFee : null,
        locationName: locationName,
        rules: rules,
        prizes: prizes,
        createdBy: userId,
        status: 'upcoming',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await _service.createTournament(
        userId: userId,
        tournament: tournament,
      );

      if (result['success'] == true) {
        // Refresh tournaments list
        await fetchTournaments();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Failed to create tournament';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error creating tournament: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Fetch tournaments by status
  Future<void> fetchTournamentsByStatus(String status) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _tournaments = await _service.getTournamentsByStatus(status);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch tournaments: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search teams
  Future<List<Team>> searchTeams(String query) async {
    try {
      final result = await _service.searchTeams(query);
      
      if (result['success'] == true) {
        final List<dynamic> teamsJson = result['teams'];
        return teamsJson.map((json) => Team.fromJson(json)).toList();
      } else {
        _errorMessage = result['message'] ?? 'Failed to search teams';
        return [];
      }
    } catch (e) {
      _errorMessage = 'Error searching teams: $e';
      return [];
    }
  }

  // Add team to tournament
  Future<bool> addTeamToTournament({
    required String userId,
    required String tournamentId,
    required String teamId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      print("ttttttttttttttttttttttttttttt");
      final result = await _service.addTeamToTournament(
        userId: userId,
        tournamentId: tournamentId,
        teamId: teamId,
      );

      if (result['success'] == true) {
        // Refresh tournament teams
        await fetchTournamentTeams(tournamentId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Failed to add team to tournament';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error adding team to tournament: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Fetch tournament teams
  Future<void> fetchTournamentTeams(String tournamentId) async {
    _isLoadingTeams = true;
    notifyListeners();

    try {
      final result = await _service.getTournamentTeams(tournamentId);
      
      if (result['success'] == true) {
        final List<dynamic> teamsJson = result['teams'];
        _tournamentTeams[tournamentId] = 
            teamsJson.map((json) => Team.fromJson(json)).toList();
      } else {
        _tournamentTeams[tournamentId] = [];
      }
      
      _isLoadingTeams = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching tournament teams: $e');
      _tournamentTeams[tournamentId] = [];
      _isLoadingTeams = false;
      notifyListeners();
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}