import 'package:booking_application/modal/tournament_model_tabbar.dart';
import 'package:booking_application/services/single_tournament_services.dart';
import 'package:flutter/material.dart';

enum TournamentState { initial, loading, loaded, error }

class SingleTournamentProvider extends ChangeNotifier {
  final SingleTournamentServices _tournamentService = SingleTournamentServices();
  
  Tournament? _tournament;
  TournamentState _state = TournamentState.initial;
  String? _errorMessage;

  // Getters
  Tournament? get tournament => _tournament;
  TournamentState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == TournamentState.loading;
  bool get hasError => _state == TournamentState.error;

  Future<void> fetchTournament(String tournamentId) async {
    _state = TournamentState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _tournament = await _tournamentService.fetchSingleTournament(tournamentId);
      _state = TournamentState.loaded;
    } catch (e) {
      _state = TournamentState.error;
      _errorMessage = e.toString();
      _tournament = null;
    }
    
    notifyListeners();
  }

  void clearData() {
    _tournament = null;
    _state = TournamentState.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
