import 'package:intl/intl.dart';

class Match {
  final String id;
  final String matchName;
  final String categoryName;
  final String tournamentName;
  final DateTime dateTime;
  final String location;
  final int maxParticipants;
  final String status;

  Match({
    required this.id,
    required this.matchName,
    required this.categoryName,
    required this.tournamentName,
    required this.dateTime,
    required this.location,
    required this.maxParticipants,
    required this.status,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['_id'] ?? '',
      matchName: json['matchName'] ?? '',
      categoryName: json['categoryId']?['name'] ?? '',
      tournamentName: json['tournamentId']?['name'] ?? '',
      dateTime: DateTime.tryParse(json['schedule']?['dateTime'] ?? '') ??
          DateTime.now(),
      location: json['location'] ?? '',
      maxParticipants: json['maxParticipants'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}
