// providers/tournament_provider.dart
import 'package:booking_application/views/Tournaments/TournamentModel/tournament.dart';
import 'package:flutter/foundation.dart';

class NewTournamentProvider with ChangeNotifier {
  final List<Tournament> _tournaments = [];

  List<Tournament> get tournaments => _tournaments;

  List<Tournament> get registrationOpenTournaments => _tournaments
      .where((tournament) => tournament.status == TournamentStatus.registrationOpen)
      .toList();

  List<Tournament> get liveTournaments => _tournaments
      .where((tournament) => tournament.status == TournamentStatus.live)
      .toList();

  List<Tournament> get completedTournaments => _tournaments
      .where((tournament) => tournament.status == TournamentStatus.completed)
      .toList();

  void addTournament(Tournament tournament) {
    _tournaments.add(tournament);
    notifyListeners();
  }

  void updateTournament(String id, Tournament updatedTournament) {
    final index = _tournaments.indexWhere((tournament) => tournament.id == id);
    if (index != -1) {
      _tournaments[index] = updatedTournament;
      notifyListeners();
    }
  }

  void deleteTournament(String id) {
    _tournaments.removeWhere((tournament) => tournament.id == id);
    notifyListeners();
  }

  Tournament? getTournamentById(String id) {
    try {
      return _tournaments.firstWhere((tournament) => tournament.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateTournamentStatus(String id, TournamentStatus status) {
    final tournament = getTournamentById(id);
    if (tournament != null) {
      final updatedTournament = tournament.copyWith(status: status);
      updateTournament(id, updatedTournament);
    }
  }
}