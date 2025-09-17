import 'package:booking_application/services/match_service.dart';
import 'package:flutter/material.dart';
import '../modal/match_model.dart';

class MatchProvider with ChangeNotifier {
  final MatchService _service = MatchService();

  List<Match> currentMatches = [];

  Future<void> loadMatchesByStatus(String userId, String status) async {
    try {
      currentMatches = await _service.fetchMatches(userId, status);
      notifyListeners();
    } catch (e) {
      print("Error fetching $status matches: $e");
    }
  }
}
