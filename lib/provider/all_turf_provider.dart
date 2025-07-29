import 'package:booking_application/modal/venue_model.dart';
import 'package:booking_application/services/all_turf_services.dart';
import 'package:flutter/material.dart';


class AllTurfProvider extends ChangeNotifier {
  final AllTurfServices _service = AllTurfServices();

  List<VenueModel> _turfs = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<VenueModel> get turfs => _turfs;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> loadTurfs() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _turfs = await _service.fetchAllTurfs();
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
