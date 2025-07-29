import 'dart:convert';
import 'package:booking_application/modal/venue_model.dart';
import 'package:http/http.dart' as http;


class AllTurfServices {
  final String baseUrl = 'http://31.97.206.144:3081/admin/allturfs';

  Future<List<VenueModel>> fetchAllTurfs() async {
    final uri = Uri.parse(baseUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> turfsJson = jsonData['turfs'];

      return turfsJson.map((json) => VenueModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load turfs');
    }
  }
}
