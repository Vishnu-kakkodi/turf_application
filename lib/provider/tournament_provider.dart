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

  List<Tournament> _tournaments = [];
  bool _isLoading = false;
  String? _error;

  List<Tournament> get tournaments => _tournaments;
  bool get isLoading => _isLoading;
  String? get error => _error;

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
}
