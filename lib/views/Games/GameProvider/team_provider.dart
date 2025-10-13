import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamProvider extends ChangeNotifier {
  List<dynamic> _teams = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get teams => _teams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTeams() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:3081/users/allgamesteam'),
        headers: {
          'Content-Type': 'application/json',
          // Add your authorization token if needed
          // 'Authorization': 'Bearer YOUR_TOKEN',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          _teams = data['teams'] ?? [];
          _error = null;
        } else {
          _error = 'Failed to load teams';
          _teams = [];
        }
      } else {
        _error = 'Server error: ${response.statusCode}';
        _teams = [];
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
      _teams = [];
      debugPrint('Error fetching teams: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}