// providers/tournament_category_provider.dart

import 'package:booking_application/modal/tournament_category_model.dart';
import 'package:flutter/material.dart';
import '../services/tournament_service.dart';

class TournamentCategoryProvider extends ChangeNotifier {
  final TournamentServiceCategory _tournamentService = TournamentServiceCategory();

  // State variables
  List<Tournament> _tournaments = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Football';

  // Getters
  List<Tournament> get tournaments => _tournaments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  // Get tournaments by category
  Future<void> fetchTournamentsByCategory(String category) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _tournamentService.getTournamentsByCategory(category);
      if (response.success) {
        _tournaments = response.tournaments;
        _selectedCategory = category;
      } else {
        _setError('Failed to fetch tournaments');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Get football tournaments specifically
  Future<void> fetchFootballTournaments() async {
    await fetchTournamentsByCategory('Football');
  }

  // Get tournaments with filters
  Future<void> fetchTournamentsWithFilters({
    String? category,
    String? location,
    String? date,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _tournamentService.getTournaments(
        category: category,
        location: location,
        date: date,
      );
      
      if (response.success) {
        _tournaments = response.tournaments;
        if (category != null) {
          _selectedCategory = category;
        }
      } else {
        _setError('Failed to fetch tournaments');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Filter tournaments by location (client-side filtering)
  List<Tournament> getTournamentsByLocation(String location) {
    return _tournaments
        .where((tournament) => 
            tournament.location.toLowerCase().contains(location.toLowerCase()))
        .toList();
  }

  // Filter tournaments by date (client-side filtering)
  List<Tournament> getTournamentsByDate(String date) {
    return _tournaments
        .where((tournament) => tournament.details.date == date)
        .toList();
  }

  // Filter tournaments by price range
  List<Tournament> getTournamentsByPriceRange(int minPrice, int maxPrice) {
    return _tournaments
        .where((tournament) => 
            tournament.price >= minPrice && tournament.price <= maxPrice)
        .toList();
  }

  // Get tournaments with available slots
  List<Tournament> getTournamentsWithAvailableSlots() {
    return _tournaments
        .where((tournament) => 
            tournament.details.slots.any((slot) => !slot.isBooked))
        .toList();
  }

  // Get tournament by ID
  Tournament? getTournamentById(String id) {
    try {
      return _tournaments.firstWhere((tournament) => tournament.id == id);
    } catch (e) {
      return null;
    }
  }

  // Refresh tournaments
  Future<void> refreshTournaments() async {
    await fetchTournamentsByCategory(_selectedCategory);
  }

  // Clear tournaments
  void clearTournaments() {
    _tournaments = [];
    _clearError();
    notifyListeners();
  }

  // Set category without fetching
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Get unique locations from current tournaments
  List<String> getUniqueLocations() {
    final locations = _tournaments.map((t) => t.location).toSet().toList();
    locations.sort();
    return locations;
  }

  // Get unique dates from current tournaments
  List<String> getUniqueDates() {
    final dates = _tournaments.map((t) => t.details.date).toSet().toList();
    dates.sort();
    return dates;
  }

  // Get tournament count
  int get tournamentCount => _tournaments.length;

  // Check if tournaments are empty
  bool get isEmpty => _tournaments.isEmpty;

  // Check if there are tournaments with available slots
  bool get hasAvailableSlots => 
      _tournaments.any((t) => t.details.slots.any((slot) => !slot.isBooked));
}