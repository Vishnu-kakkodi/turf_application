// import 'package:booking_application/modal/tournament_model_tabbar.dart';
// import 'package:flutter/material.dart';

// import '../services/get_all_tournament_services.dart';

// class TournamentProvider extends ChangeNotifier {
//   final GetAllTournamentServices _service = GetAllTournamentServices();

//   List<Tournament> _tournaments = [];
//   bool _isLoading = false;
//   String? _error;

//   List<Tournament> get tournaments => _tournaments;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> loadTournaments() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _tournaments = await _service.fetchTournaments();
//     } catch (e) {
//       _error = e.toString();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }














// import 'package:booking_application/modal/tournament_model_tabbar.dart';
// import 'package:flutter/material.dart';

// import '../services/get_all_tournament_services.dart';

// class TournamentProvider extends ChangeNotifier {
//   final GetAllTournamentServices _service = GetAllTournamentServices();

//   List<Tournament> _tournaments = [];
//   bool _isLoading = false;
//   String? _error;

//   List<Tournament> get tournaments => _tournaments;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> loadTournaments() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _tournaments = await _service.fetchTournaments();
//     } catch (e) {
//       _error = e.toString();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

















import 'package:booking_application/modal/tournament_model_tabbar.dart';
import 'package:flutter/material.dart';
import '../services/get_all_tournament_services.dart';

class TournamentProvider extends ChangeNotifier {
  final GetAllTournamentServices _service = GetAllTournamentServices();

  // All tournaments
  List<Tournament> _tournaments = [];
  bool _isLoading = false;
  String? _error;

  // Single tournament
  Tournament? _singleTournament;
  bool _isSingleLoading = false;
  String? _singleError;

  // Getters for all tournaments
  List<Tournament> get tournaments => _tournaments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Getters for single tournament
  Tournament? get singleTournament => _singleTournament;
  bool get isSingleLoading => _isSingleLoading;
  String? get singleError => _singleError;
  bool get hasSingleError => _singleError != null;

  // Load all tournaments
  Future<void> loadTournaments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tournaments = await _service.fetchTournaments();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load single tournament
  Future<void> loadSingleTournament(String tournamentId) async {
    _isSingleLoading = true;
    _singleError = null;
    _singleTournament = null;
    notifyListeners();

    try {
      _singleTournament = await _service.fetchSingleTournament(tournamentId);
    } catch (e) {
      _singleError = e.toString();
    }

    _isSingleLoading = false;
    notifyListeners();
  }

  // Clear single tournament data
  void clearSingleTournament() {
    _singleTournament = null;
    _singleError = null;
    _isSingleLoading = false;
    notifyListeners();
  }

  // Retry loading single tournament
  Future<void> retrySingleTournament(String tournamentId) async {
    await loadSingleTournament(tournamentId);
  }
}