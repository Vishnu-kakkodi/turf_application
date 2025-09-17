

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modal/match_model.dart';

class MatchService {
  final String baseUrl = "http://31.97.206.144:3081/users/getmatches";

  Future<List<Match>> fetchMatches(String userId, String status) async {
    final url = Uri.parse("$baseUrl/$userId?status=$status");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return (body["matches"] as List)
          .map((e) => Match.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to fetch matches");
    }
  }
}

