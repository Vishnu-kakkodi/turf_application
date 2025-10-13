// models/tournament_model.dart
import 'package:flutter/foundation.dart';

class Tournament {
  final String id;
  final String name;
  final String description;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationEndDate;
  final int numberOfTeams;
  final String format;
  final bool isPaidEntry;
  final double? entryFee;
  final String rules;
  final String prizes;
  final DateTime createdAt;
  TournamentStatus status;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.registrationEndDate,
    required this.numberOfTeams,
    required this.format,
    required this.isPaidEntry,
    this.entryFee,
    required this.rules,
    required this.prizes,
    required this.createdAt,
    this.status = TournamentStatus.registrationOpen,
  });

  Tournament copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? registrationEndDate,
    int? numberOfTeams,
    String? format,
    bool? isPaidEntry,
    double? entryFee,
    String? rules,
    String? prizes,
    DateTime? createdAt,
    TournamentStatus? status,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      registrationEndDate: registrationEndDate ?? this.registrationEndDate,
      numberOfTeams: numberOfTeams ?? this.numberOfTeams,
      format: format ?? this.format,
      isPaidEntry: isPaidEntry ?? this.isPaidEntry,
      entryFee: entryFee ?? this.entryFee,
      rules: rules ?? this.rules,
      prizes: prizes ?? this.prizes,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'registrationEndDate': registrationEndDate.millisecondsSinceEpoch,
      'numberOfTeams': numberOfTeams,
      'format': format,
      'isPaidEntry': isPaidEntry,
      'entryFee': entryFee,
      'rules': rules,
      'prizes': prizes,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status.index,
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      location: map['location'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      registrationEndDate: DateTime.fromMillisecondsSinceEpoch(map['registrationEndDate']),
      numberOfTeams: map['numberOfTeams'],
      format: map['format'],
      isPaidEntry: map['isPaidEntry'],
      entryFee: map['entryFee'],
      rules: map['rules'],
      prizes: map['prizes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: TournamentStatus.values[map['status']],
    );
  }
}

enum TournamentStatus {
  registrationOpen,
  live,
  completed,
}