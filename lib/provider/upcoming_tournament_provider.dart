import 'package:booking_application/modal/tournament_model.dart';
import 'package:booking_application/services/upcoming_tournament_services.dart';
import 'package:flutter/material.dart';

enum TournamentState { initial, loading, loaded, error }

class UpcomingTournamentProvider extends ChangeNotifier {
  final UpcomingTournamentService _service = UpcomingTournamentService();
  
  Tournament? _tournament;
  TournamentState _state = TournamentState.initial;
  String? _errorMessage;

  // Getters
  Tournament? get tournament => _tournament;
  TournamentState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == TournamentState.loading;
  bool get hasError => _state == TournamentState.error;
  bool get hasData => _tournament != null;

  // Methods
  Future<void> fetchUpcomingTournament() async {
    _state = TournamentState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.getUpcomingTournaments();
      
      if (response.success && response.tournament != null) {
        _tournament = response.tournament;
        _state = TournamentState.loaded;
      } else {
        _errorMessage = response.message ?? 'Failed to load tournament';
        _state = TournamentState.error;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      _state = TournamentState.error;
    }
    
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_state == TournamentState.error) {
      _state = TournamentState.initial;
    }
    notifyListeners();
  }

  void reset() {
    _tournament = null;
    _state = TournamentState.initial;
    _errorMessage = null;
    notifyListeners();
  }
}