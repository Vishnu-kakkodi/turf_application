// import 'dart:convert';
// import 'package:booking_application/modal/tournament_model_tabbar.dart';
// import 'package:http/http.dart' as http;
//  // Update path as needed

// class GetAllTournamentServices {
//   final String baseUrl = 'http://31.97.206.144:3081/turnament/gettournaments';

//   Future<List<Tournament>> fetchTournaments() async {
//     try {
//       final response = await http.get(Uri.parse(baseUrl));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true && data['tournaments'] != null) {
//           List<Tournament> tournaments = (data['tournaments'] as List)
//               .map((item) => Tournament.fromJson(item))
//               .toList();
//           return tournaments;
//         } else {
//           throw Exception('No tournaments found');
//         }
//       } else {
//         throw Exception('Failed to load tournaments');
//       }
//     } catch (e) {
//       throw Exception('Error fetching tournaments: $e');
//     }
//   }
// }
















// import 'dart:convert';
// import 'package:booking_application/modal/tournament_model_tabbar.dart';
// import 'package:http/http.dart' as http;
//  // update path as needed

// class GetAllTournamentServices {
//   final String baseUrl = 'http://31.97.206.144:3081/turnament/gettournaments';

//   Future<List<Tournament>> fetchTournaments() async {
//     try {
//       final response = await http.get(Uri.parse(baseUrl));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true && data['tournaments'] != null) {
//           List<Tournament> tournaments = (data['tournaments'] as List)
//               .map((item) => Tournament.fromJson(item))
//               .toList();
//           return tournaments;
//         } else {
//           throw Exception('No tournaments found');
//         }
//       } else {
//         throw Exception('Failed to load tournaments');
//       }
//     } catch (e) {
//       throw Exception('Error fetching tournaments: $e');
//     }
//   }
// }











import 'dart:convert';
import 'package:booking_application/modal/tournament_model_tabbar.dart';
import 'package:http/http.dart' as http;
 // update path as needed

class GetAllTournamentServices {
  final String baseUrl = 'http://31.97.206.144:3081';

  Future<List<Tournament>> fetchTournaments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/turnament/gettournaments'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true && data['tournaments'] != null) {
          List<Tournament> tournaments = (data['tournaments'] as List)
              .map((item) => Tournament.fromJson(item))
              .toList();
          return tournaments;
        } else {
          throw Exception('No tournaments found');
        }
      } else {
        throw Exception('Failed to load tournaments');
      }
    } catch (e) {
      throw Exception('Error fetching tournaments: $e');
    }
  }

  Future<Tournament> fetchSingleTournament(String tournamentId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/turnament/singletournament/$tournamentId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true && data['tournament'] != null) {
          return Tournament.fromJson(data['tournament']);
        } else {
          throw Exception('Tournament not found');
        }
      } else {
        throw Exception('Failed to load tournament');
      }
    } catch (e) {
      throw Exception('Error fetching tournament: $e');
    }
  }
}