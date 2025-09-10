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

















// import 'package:booking_application/modal/tournament_model_tabbar.dart';
// import 'package:flutter/material.dart';
// import '../services/get_all_tournament_services.dart';

// class TournamentProvider extends ChangeNotifier {
//   final GetAllTournamentServices _service = GetAllTournamentServices();

//   // All tournaments
//   List<Tournament> _tournaments = [];
//   bool _isLoading = false;
//   String? _error;

//   // Single tournament
//   Tournament? _singleTournament;
//   bool _isSingleLoading = false;
//   String? _singleError;

//   // Getters for all tournaments
//   List<Tournament> get tournaments => _tournaments;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   // Getters for single tournament
//   Tournament? get singleTournament => _singleTournament;
//   bool get isSingleLoading => _isSingleLoading;
//   String? get singleError => _singleError;
//   bool get hasSingleError => _singleError != null;

//   // Load all tournaments
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

//   // Load single tournament
//   Future<void> loadSingleTournament(String tournamentId) async {
//     _isSingleLoading = true;
//     _singleError = null;
//     _singleTournament = null;
//     notifyListeners();

//     try {
//       _singleTournament = await _service.fetchSingleTournament(tournamentId);
//     } catch (e) {
//       _singleError = e.toString();
//     }

//     _isSingleLoading = false;
//     notifyListeners();
//   }

//   // Clear single tournament data
//   void clearSingleTournament() {
//     _singleTournament = null;
//     _singleError = null;
//     _isSingleLoading = false;
//     notifyListeners();
//   }

//   // Retry loading single tournament
//   Future<void> retrySingleTournament(String tournamentId) async {
//     await loadSingleTournament(tournamentId);
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

  // Filtered tournaments
  List<Tournament> _filteredTournaments = [];
  String _searchQuery = '';

  // Getters for all tournaments
  List<Tournament> get tournaments => _tournaments;
  List<Tournament> get filteredTournaments => _filteredTournaments.isEmpty ? _tournaments : _filteredTournaments;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get hasTournaments => _tournaments.isNotEmpty;

  // Getters for single tournament
  Tournament? get singleTournament => _singleTournament;
  bool get isSingleLoading => _isSingleLoading;
  String? get singleError => _singleError;
  bool get hasSingleError => _singleError != null;

  // Search query getter
  String get searchQuery => _searchQuery;

  // Load all tournaments
  Future<void> loadTournaments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tournaments = await _service.fetchTournaments();
      _error = null;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _tournaments = [];
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
      _singleError = null;
    } catch (e) {
      _singleError = e.toString().replaceAll('Exception: ', '');
      _singleTournament = null;
    }

    _isSingleLoading = false;
    notifyListeners();
  }

  // Search tournaments
  void searchTournaments(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredTournaments = [];
    } else {
      _filteredTournaments = _tournaments.where((tournament) {
        return tournament.name.toLowerCase().contains(query.toLowerCase()) ||
               (tournament.location?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
               (tournament.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
      }).toList();
    }
    
    notifyListeners();
  }

  // Filter tournaments by location
  void filterByLocation(String location) {
    if (location.isEmpty) {
      _filteredTournaments = [];
    } else {
      _filteredTournaments = _tournaments.where((tournament) {
        return tournament.location?.toLowerCase() == location.toLowerCase();
      }).toList();
    }
    notifyListeners();
  }

  // Filter tournaments by price range
  void filterByPriceRange(int minPrice, int maxPrice) {
    _filteredTournaments = _tournaments.where((tournament) {
      return tournament.price >= minPrice && tournament.price <= maxPrice;
    }).toList();
    notifyListeners();
  }

  // Clear all filters
  void clearFilters() {
    _filteredTournaments = [];
    _searchQuery = '';
    notifyListeners();
  }

  // Clear single tournament data
  void clearSingleTournament() {
    _singleTournament = null;
    _singleError = null;
    _isSingleLoading = false;
    notifyListeners();
  }

  // Retry loading tournaments
  Future<void> retryLoadTournaments() async {
    await loadTournaments();
  }

  // Retry loading single tournament
  Future<void> retrySingleTournament(String tournamentId) async {
    await loadSingleTournament(tournamentId);
  }

  // Get tournament by ID from loaded tournaments
  Tournament? getTournamentById(String tournamentId) {
    try {
      return _tournaments.firstWhere((tournament) => tournament.id == tournamentId);
    } catch (e) {
      return null;
    }
  }

  // Get full image URL
  String getFullImageUrl(String? imagePath) {
    return _service.getFullImageUrl(imagePath);
  }

  // Get available slots for a tournament
  List<TimeSlot> getAvailableSlots(String tournamentId) {
    final tournament = getTournamentById(tournamentId);
    if (tournament == null || tournament.details == null) {
      return [];
    }
    return tournament.details!.slots.where((slot) => !slot.isBooked).toList();
  }

  // Get booked slots for a tournament
  List<TimeSlot> getBookedSlots(String tournamentId) {
    final tournament = getTournamentById(tournamentId);
    if (tournament == null || tournament.details == null) {
      return [];
    }
    return tournament.details!.slots.where((slot) => slot.isBooked).toList();
  }

  // Check if tournament has available slots
  bool hasAvailableSlots(String tournamentId) {
    return getAvailableSlots(tournamentId).isNotEmpty;
  }

  // Get unique locations from all tournaments
  List<String> getUniqueLocations() {
    final locations = _tournaments
        .where((tournament) => tournament.location != null && tournament.location!.isNotEmpty)
        .map((tournament) => tournament.location!)
        .toSet()
        .toList();
    locations.sort();
    return locations;
  }
}